import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.userController, required this.hintText, this.onChanged, this.validator, this.keyboardType, this.textInputAction, this.inputFormatter,
  }) : super(key: key);

  final TextEditingController userController;
  final String hintText;
  final  ValueChanged<String>? onChanged;
  final  FormFieldValidator<String>? validator;
  final  TextInputType? keyboardType;
  final  TextInputAction? textInputAction;
  final  List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: TextFormField(
        textInputAction:textInputAction,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        controller: userController,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder:OutlineInputBorder(
                borderSide: BorderSide(color:Color(0xFF64B5F6),),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(20)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20))
        ),
      ),
    );
  }
}

