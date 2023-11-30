import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:marcarcion/common/widgets/dialod_widget.dart';
import 'package:marcarcion/common/widgets/index.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertNewEnroll();
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Nuevo enrolamiento",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MuseoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20)
              ],
            ),
            const SizedBox(height: 20),
            Image.asset(
              "assets/images/icon_letter.png",
              width: 200.12,
              // height: 88.06,
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: const Text(
                "Coloca tu rostro dentro del círculo y\npresiona el botón marcar",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: 'MuseoSans',
                  color: Colors.white,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const ContainerCameraWidget(),
            Container(
              width: 200,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: const Text(
                "Marcar",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ContainerCameraWidget extends StatelessWidget {
  const ContainerCameraWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Image.asset(
          "assets/images/icon_background.png",
          width: size.width,
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: size.width * 0.145),
            width: size.width * 0.89,
            height: size.width * 0.89,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0XFF67E2EF),
                  Color(0XFF406A80),
                ],
              ),
              color: const Color(0XFF67E2EF),
              borderRadius: BorderRadius.circular(1000),
            ),
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.85,
              height: size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
              ),
              child: const CameraWidget(),
            ),
          ),
        ),
      ],
    );
  }
}

class CameraWidget extends StatelessWidget {
  const CameraWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (snapshot.hasData) {
          return CameraApp(
            camera: snapshot.data[0],
          );
        }
        return const SizedBox();
      },
    );
  }
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key, required this.camera});
  final CameraDescription camera;
  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      child: CameraPreview(controller),
    );
  }
}
