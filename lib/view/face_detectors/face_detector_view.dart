// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:marcarcion/provider/faces_provider.dart';
import 'package:provider/provider.dart';
import 'detector_view.dart';

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({super.key});

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  @override
  void dispose() {
    Provider.of<FacesProvider>(context, listen: false).faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DetectorView(
        title: 'Face Detector',
      ),
    );
  }
}
