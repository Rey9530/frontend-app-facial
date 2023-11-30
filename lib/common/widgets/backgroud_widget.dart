import 'package:flutter/material.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.primary,
          ),
          // Center(
          //   child: Image.asset(
          //     "assets/images/icon_background.png",
          //     width: double.infinity,
          //   ),
          // ),
          child
        ],
      ),
    );
  }
}
