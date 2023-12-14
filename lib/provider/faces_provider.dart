import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceItem {
  final Face face;
  final String nombre;
  FaceItem({required this.face, required this.nombre});
}

class FacesProvider extends ChangeNotifier {
  List<FaceItem> faces = [];

  addFaces(Face face) async {
    faces.add(
      FaceItem(
        face: face,
        nombre: "Registro #${faces.length + 1} - ${DateTime.now().toString()}",
      ),
    );
    notifyListeners();
  }

  searchFaces(Face face) async {
    var found = faces.where((e) => e.face.boundingBox == face.boundingBox);
    return found;
  }
}
