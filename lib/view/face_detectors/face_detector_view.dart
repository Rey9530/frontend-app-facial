// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'detector_view.dart';
import 'face_detector_painter.dart';

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({super.key});

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  int contador = 0;
  var _cameraLensDirection = CameraLensDirection.front;
  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetectorView(
        title: 'Face Detector',
        customPaint: _customPaint,
        text: _text,
        onImage: _processImage,
        initialCameraLensDirection: _cameraLensDirection,
        onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    if (!mounted) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);
    contador++;
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;
      // print(_text);
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }

    if (mounted) {
      setState(() {});
    }

    if (faces.isNotEmpty) {
      if (contador == 6) {
        // var provider = Provider.of<FacesProvider>(context, listen: false);
        // await provider.addFaces(faces.first);
        // const snackBar = SnackBar(
        //   content: Text('Rostro agregado'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // contador = 0;
        // return showDialog<void>(
        //   barrierColor: const Color(0xFF0D335A).withOpacity(0.4),
        //   context: context,
        //   barrierDismissible: false, // user must tap button!
        //   builder: (BuildContext context) {
        //     return AceptTerms(face: faces.first);
        //   },
        // );
      }
    }
    _isBusy = false;
    if (mounted) {
      // setState(() {});
    }
  }
}

////

// class AceptTerms extends StatefulWidget {
//   const AceptTerms({
//     super.key,
//     required this.face,
//   });
//   final Face face;
//   @override
//   State<AceptTerms> createState() => _AceptTermsState();
// }

// class _AceptTermsState extends State<AceptTerms> {
//   TextEditingController input = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<FacesProvider>(context, listen: false);
//     return AlertDialog(
//       title: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Ingrese un nombre",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//       content: SizedBox(
//         height: 300,
//         child: Column(
//           children: [
//             TextField(controller: input),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () async {
//             await provider.addFaces(
//               widget.face,
//               input.text,
//             );
//             var count = 0;
//             Navigator.popUntil(context, (route) {
//               return count++ == 2;
//             });
//           },
//           child: const Text("Salir"),
//         )
//       ],
//     );
//   }
// }
