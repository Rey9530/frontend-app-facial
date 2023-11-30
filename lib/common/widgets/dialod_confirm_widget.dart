import 'package:flutter/material.dart';

class AlertSuccess extends StatefulWidget {
  const AlertSuccess({
    super.key,
  });

  @override
  State<AlertSuccess> createState() => _AlertSuccessState();
}

class _AlertSuccessState extends State<AlertSuccess> {
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Image.asset(
              "assets/images/face-scan-circle.png",
              width: 70,
            ),
            const Text(
              'Reconocimiento facial',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'MuseoSans',
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      content: const Text(
        'Se tomará un video de 10 segundos.\n\nPor favor, colocar su rostro dentro del círculo y hacermovimientos suaves hacia su derecha, izquierda, arriba y abajo.',
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontFamily: 'MuseoSans',
          // fontSize: 26,
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
                  "Iniciar",
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
