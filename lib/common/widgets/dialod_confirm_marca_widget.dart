import 'package:flutter/material.dart';
import 'package:marcarcion/provider/faces_provider.dart';
import 'package:provider/provider.dart';

class AlertMarcaSuccess extends StatelessWidget {
  const AlertMarcaSuccess({
    super.key,
  });

  cerrarDialog(context) async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FacesProvider>(context, listen: false);
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
              provider.respOk['data']['empleado'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'MuseoSans',
                color: Theme.of(context).colorScheme.primary,
                // fontSize: 26,
              ),
            ),
            Text(
              provider.respOk['data']['hora'],
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
    );
  }
}
