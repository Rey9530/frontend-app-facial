import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marcarcion/provider/faces_provider.dart';
import 'package:provider/provider.dart';

class ErrorEnrrolDialog extends StatelessWidget {
  const ErrorEnrrolDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FacesProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            SvgPicture.asset("assets/svg/face-scan-circle-error.svg"),
            const Text(
              'No se pudo reconocer',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'MuseoSans',
                fontSize: 26,
                color: Color(0XFFFF4220),
              ),
            )
          ],
        ),
      ),
      content: const SizedBox(
        height: 130,
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Intentalo nuevamente.\n\nSi el problema persiste, contacta a soporte\ntécnico al siguiente correo:",
              style: TextStyle(
                color: Color(0XFF454B54),
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "ejemplodecorreo@cel.gob.sv",
              style: TextStyle(
                color: Color(0XFF454B54),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                provider.respOk = null;
              },
              child: Container(
                height: 60,
                width: 200,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: const Text(
                  "Reintentar",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
