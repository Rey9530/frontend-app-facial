import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:marcarcion/provider/faces_provider.dart';
import 'package:provider/provider.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
  });

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  void initState() {
    super.initState();
    Provider.of<FacesProvider>(context, listen: false).mounted = mounted;
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<FacesProvider>(context, listen: false).stopLiveFeed();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FacesProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.initialize(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (provider.cameras.isEmpty) return Container();
        if (snapshot.data == null) return Container();
        if (snapshot.data?.value.isInitialized == false) return Container();
        return const CustomCameraWidget();
      },
    );
  }
}

class CustomCameraWidget extends StatelessWidget {
  const CustomCameraWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FacesProvider>(context);
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: CameraPreview(
                provider.controllerCamera!,
                child: provider.customPaint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
