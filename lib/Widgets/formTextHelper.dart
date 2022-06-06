import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormTextHelper extends StatelessWidget {
  final String label;
  final String hint;
  final Icon icon;

  const FormTextHelper(
      {Key? key, required this.label, required this.hint, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          focusNode: FocusNode(),
          decoration: InputDecoration(
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              isCollapsed: true,
              prefixIcon: icon,
              labelText: label,
              hintText: hint,
              focusColor: Colors.blue)),
    );
  }
}
