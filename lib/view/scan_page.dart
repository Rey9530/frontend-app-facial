import 'dart:io';

import 'package:flutter/material.dart';
import 'package:marcarcion/common/widgets/dialod_confirm_marca_widget.dart';
import 'package:marcarcion/common/widgets/dialod_confirm_widget.dart';
import 'package:marcarcion/common/widgets/dialod_widget.dart';
import 'package:marcarcion/common/widgets/index.dart';
import 'package:marcarcion/provider/faces_provider.dart';
import 'package:marcarcion/view/face_detectors/face_detector_view.dart';
import 'package:provider/provider.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  showDialogConfir(context) async {
    // await Future.delayed(const Duration(milliseconds: 500));
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AlertSuccess();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FacesProvider>(context, listen: false);
    return BackGroundWidget(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Platform.isIOS ? 55 : 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertNewEnroll(
                          onPress: () {
                            showDialogConfir(context);
                          },
                        );
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
            GestureDetector(
              onTap: () async {
                await provider.startVideoRecording();
                // return showDialog<void>(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return const AlertMarcaSuccess();
                //   },
                // );
              },
              child: Container(
                width: 250,
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
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(1000)),
                child: FaceDetectorView(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
