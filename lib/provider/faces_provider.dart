import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:marcarcion/view/face_detectors/face_detector_painter.dart';

class FacesProvider extends ChangeNotifier {
  //vienen de los padres

  var cameraLensDirection = CameraLensDirection.front;

  List<CameraDescription> cameras = [];
  CameraController? controllerCamera;
  int _cameraIndex = -1;
  bool mounted = false;

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  Future initialize() async {
    if (cameras.isEmpty) {
      cameras = await availableCameras();
    }
    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == cameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      return await _startLiveFeed();
    }
    return controllerCamera;
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    controllerCamera = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    await controllerCamera?.initialize();
    if (!mounted) {
      return;
    }
    await controllerCamera?.startImageStream((val) => _processCameraImage(val));
    // if (onCameraFeedReady != null) {//investigar que utilidad le podemos dar
    //   onCameraFeedReady!();
    // }
    cameraLensDirection = camera.lensDirection;
    return controllerCamera;
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    _processImage(inputImage);
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (controllerCamera == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${controllerCamera?.value.deviceOrientation} ${controllerCamera?.value.lockedCaptureOrientation} ${controllerCamera?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[controllerCamera!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  Future stopLiveFeed() async {
    await controllerCamera?.stopImageStream();
    await controllerCamera?.dispose();
    controllerCamera = null;
  }

  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  CustomPaint? customPaint;
  // String _text = '';
  bool _isBusy = false;
  Future<void> _processImage(InputImage inputImage) async {
    // if (!_canProcess) return;
    if (_isBusy) return;
    if (!mounted) return;
    _isBusy = true;
    // setState(() {
    //   _text = '';
    // });
    notifyListeners();
    final faces = await faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        cameraLensDirection,
      );
      customPaint = CustomPaint(painter: painter);
    } else {
      // TODO: set customPaint to draw boundingRect on top of image
      customPaint = null;
    }

    if (mounted) {
      notifyListeners();
    }

    _isBusy = false;
    if (mounted) {}
  }

  bool loading = false;
  Future<void> takePicture([load = false]) async {
    if (!controllerCamera!.value.isInitialized) {
      // La cámara no está lista
      return;
    }
    if (load) {
      loading = true;
      notifyListeners();
    }

    try {
      final image = await controllerCamera!.takePicture();
      // Usa la imagen capturada
      // Por ejemplo, puedes guardarla en un archivo
      // final path = image.path; // Ruta del archivo de la imagen
      var newPath = await convertToPngAndSave(image.path);
      await uploadFile(newPath);
      // _startLiveFeed();
    } catch (e) {
      // Manejar error
    } finally {
      if (load) {
        loading = false;
        notifyListeners();
      }
    }
  }

  Future<String> convertToPngAndSave(String imagePath) async {
    // Leer el archivo de imagen como una lista de bytes
    final imageBytes = await File(imagePath).readAsBytes();
    // Decodificar la imagen a un formato editable
    img.Image? image = img.decodeImage(imageBytes);

    if (image != null) {
      // Convertir a PNG
      var pngBytes = img.encodePng(image);

      // Guardar el archivo PNG
      String newImagePath = imagePath.replaceAll('.jpg', '.png');
      await File(newImagePath).writeAsBytes(pngBytes);
      return newImagePath; // Retorna la nueva ruta si necesitas usarla
    }
    return '';
  }

  // Future<void> startVideoRecording() async {
  //   if (!controllerCamera!.value.isInitialized) {
  //     // Error: la cámara no está lista
  //     return;
  //   }

  //   try {
  //     await controllerCamera?.startVideoRecording();
  //     await Future.delayed(const Duration(seconds: 5));
  //     await stopVideoRecording();
  //   } on CameraException catch (e) {
  //     print(e.toString());
  //     // Manejar error
  //   }
  // }

  // Future<XFile?> stopVideoRecording() async {
  //   if (!controllerCamera!.value.isRecordingVideo) {
  //     // Error: no se está graband5o
  //     return null;
  //   }
  //   try {
  //     var file = await controllerCamera!.stopVideoRecording();
  //     await uploadFile(file);
  //     // _startLiveFeed();
  //     return file;
  //   } on CameraException catch (e) {
  //     print(e.toString());
  //     // Manejar error
  //     return null;
  //   }
  // }

  Future<FormData> createFormData(String file) async {
    var splitName = file.split(".");
    return FormData.fromMap(
      {
        "file": await MultipartFile.fromFile(file,
            filename: "file.${splitName[splitName.length - 1]}"),
      },
    );
  }

  static final Dio _dio = Dio();
  final codeController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var respOk;
  Future<void> uploadFile(String file) async {
    FormData formData = await createFormData(file);

    try {
      Response response = await _dio.post(
        "http://10.0.2.2:3000/api/files/${codeController.text.isNotEmpty ? codeController.text : ''}",
        data: formData,
        options: Options(
          headers: {
            'accept': ' */*',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      respOk = response.data;
      print("e.success=========");
      print(respOk);
    } on DioException catch (e) {
      print("e.message=========");
      print(e.response?.data);
      respOk = e.response?.data;
      print(respOk);
    } finally {
      codeController.text = '';
    }
  }

  var counter = 10;
  Timer? timer;
  bool isEnroll = false;
  startTimer() {
    isEnroll = true;
    notifyListeners();
    counter = 10; // Restablecer el contador al iniciar
    timer = Timer.periodic(const Duration(seconds: 1), (times) {
      counter--;
      notifyListeners();
      if (counter == 8) {
        takePicture();
      }
      if (counter == 0) {
        counter = 10;
        timer!.cancel();
        timer = null;
        isEnroll = false;
      }
    });
  }
}
