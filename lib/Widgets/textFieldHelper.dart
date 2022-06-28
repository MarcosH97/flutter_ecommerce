// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFieldHelper {

  TextField InputField(String label, String? hintText, Icon? ico, controller, Function onEditComplete) {
    return TextField(
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        focusNode: FocusNode(),
        controller: controller,
        onEditingComplete: () => onEditComplete,
        decoration: InputDecoration(
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isCollapsed: true,
            prefixIcon: ico,
            labelText: label,
            hintText: hintText,
            focusColor: Colors.blue));
  }
}
