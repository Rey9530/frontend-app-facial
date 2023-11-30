import 'package:flutter/material.dart';

class AlertNewEnroll extends StatelessWidget {
  const AlertNewEnroll({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
          // validator: (),
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
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Disable'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Enable'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
