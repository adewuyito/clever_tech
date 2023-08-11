import 'package:flutter/material.dart';

class EButton extends StatelessWidget {
  final  VoidCallback? onPressed;
  final String label;
  final double fontSize;

  const EButton({
    super.key,
    this.fontSize = 17.0,
    required this.label, this.onPressed,
  });

  action(VoidCallback? button){
    return button = onPressed ?? () {};
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        onPressed: action(onPressed),
        backgroundColor: const Color.fromRGBO(79, 192, 112, 1),
        child: Text(
          label,
          style: TextStyle(
              fontFamily: 'SFTS',
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        // disabledElevation: 1,
      ),
    );
  }
}
