import 'package:flutter/material.dart';

class NoNote extends StatelessWidget {
  const NoNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/freepik__background__60557.png',
            width: MediaQuery.sizeOf(context).width * 0.95,
          ),
          const Text(
            'You have no notes yet!\nCreate one by pressing the + button',
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
