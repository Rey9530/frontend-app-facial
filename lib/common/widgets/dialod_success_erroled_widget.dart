import 'package:flutter/material.dart';
import 'package:marcarcion/provider/faces_provider.dart';
import 'package:provider/provider.dart';

class SuccessEnrrolDialog extends StatefulWidget {
  const SuccessEnrrolDialog({
    super.key,
  });

  @override
  State<SuccessEnrrolDialog> createState() => _SuccessEnrrolDialogState();
}

class _SuccessEnrrolDialogState extends State<SuccessEnrrolDialog> {
  bool isValid = false;
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
        child: Image.asset(
          "assets/images/Rectangle.png",
          width: 112,
          height: 112,
        ),
      ),
      content: Container(
        width: 400,
        height: 40,
        alignment: Alignment.center,
        child: const Text(
          'Enrolamiento completo',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontFamily: 'MuseoSans',
            fontSize: 26,
            color: Color(0XFF55C157),
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
                  "Aceptar",
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
