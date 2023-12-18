import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorEnrrolLoginDialog extends StatelessWidget {
  const ErrorEnrrolLoginDialog({
    super.key,
    this.message = '',
  });
  final String message;

  cerrarDialog(context) async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    cerrarDialog(context);
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
      content: SizedBox(
        height: 130,
        width: 350,
        child: Text(
          message != ''
              ? message
              : 'Intentalo nuevamente.\n\nSi el problema persiste, contacta a soporte\nal encargado de tu área.',
          style: const TextStyle(
            color: Color(0XFF454B54),
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
