import 'package:flutter/material.dart';

class ETextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final Color? baseColor;
  final Color? borderColor;
  final Color? errorColor;
  final TextInputType inputType;
  final bool obscureText;
  final Function? validator;
  final Function? onChanged;

  const ETextField({
    super.key,
    this.hint,
    this.controller,
    this.baseColor,
    this.borderColor,
    this.errorColor,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  State<ETextField> createState() => _ETextFieldState();
}

class _ETextFieldState extends State<ETextField> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.borderColor!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          obscureText: widget.obscureText,
          onChanged: (text) {
            if (widget.onChanged != null) {
              widget.onChanged!(text);
            }
            setState(() {
              if (!widget.validator!(text) || text.isEmpty) {
                currentColor = widget.errorColor!;
              } else {
                currentColor = widget.baseColor!;
              }
            });
          },
          keyboardType: widget.inputType,
          controller: widget.controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: widget.baseColor,
              fontFamily: "SFTS",
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
            hintText: widget.hint,
          ),
        ),
      ),
    );
  }
}
