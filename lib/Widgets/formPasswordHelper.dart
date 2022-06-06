import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormPasswordHelper extends StatelessWidget {
  final String label;
  final String hint;
  final bool shpw;
  final Function tap;

  const FormPasswordHelper(
      {Key? key,
      required this.label,
      required this.hint,
      required this.shpw,
      required this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: TextFormField(
        maxLines: 1,
        focusNode: FocusNode(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: shpw ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            color: Colors.grey.withOpacity(0.7),
            onPressed: tap(),
          ),
          labelText: label,
          hintText: hint,
        ),
        obscureText: shpw,
      ),
    );
  }
}
