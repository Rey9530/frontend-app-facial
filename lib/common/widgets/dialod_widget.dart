import 'package:flutter/material.dart';

class AlertNewEnroll extends StatefulWidget {
  const AlertNewEnroll({
    super.key,
    required this.onPress,
  });

  final Function onPress;

  @override
  State<AlertNewEnroll> createState() => _AlertNewEnrollState();
}

class _AlertNewEnrollState extends State<AlertNewEnroll> {
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
        child: const Column(
          children: [
            Text(
              'Ingresar código',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'MuseoSans',
                fontSize: 26,
              ),
            ),
            Text(
              'Ingresa el Código del nuevo usuario.',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'MuseoSans',
                fontSize: 20,
                color: Color(0XFF454B54),
              ),
            ),
          ],
        ),
      ),
      content: SizedBox(
        width: 500,
        height: 80,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          validator: (String? valor) {
            // if (valor == null || valor.length < 6) return "Incorrecto";
            return null;
          },
          onChanged: (valor) {
            isValid = valor.length > 5;
            setState(() {});
          },
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0XFF0C223F),
                width: 4,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0XFF0C223F),
                width: 2,
              ),
            ),
            prefixIcon: Container(
              padding: const EdgeInsets.only(left: 20, right: 5),
              width: 80,
              alignment: Alignment.centerLeft,
              child: const Text(
                "TER- ",
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0XFF6F6F6F),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            labelStyle: const TextStyle(color: Colors.grey),
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000),
                  border: Border.all(
                    width: 2,
                  ),
                ),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                widget.onPress();
              },
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isValid
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.4),
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
        ),
      ],
    );
  }
}
