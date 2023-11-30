import 'package:flutter/material.dart';

class AlertMarcaSuccess extends StatefulWidget {
  const AlertMarcaSuccess({
    super.key,
  });

  @override
  State<AlertMarcaSuccess> createState() => _AlertMarcaSuccessState();
}

class _AlertMarcaSuccessState extends State<AlertMarcaSuccess> {
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
              "assets/images/Rectangle.png",
              width: 70,
            ),
            Text(
              'Marcación correcta',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'MuseoSans',
                fontSize: 26,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
      content: SizedBox(
        height: 80,
        child: Column(
          children: [
            Text(
              'Mario Ernesto Bonilla López.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'MuseoSans',
                color: Theme.of(context).colorScheme.primary,
                // fontSize: 26,
              ),
            ),
            Text(
              '07:59 am.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'MuseoSans',
                color: Theme.of(context).colorScheme.primary,
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
      // actions: [
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //         child: Container(
      //           height: 60,
      //           width: 200,
      //           padding: const EdgeInsets.symmetric(horizontal: 50),
      //           alignment: Alignment.center,
      //           decoration: BoxDecoration(
      //             color: Theme.of(context).colorScheme.primary,
      //             borderRadius: BorderRadius.circular(1000),
      //           ),
      //           child: const Text(
      //             "Iniciar",
      //             style: TextStyle(
      //               fontWeight: FontWeight.w600,
      //               fontSize: 18,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   )
      // ],
    );
  }
}
