import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_project/core/helpers/helper.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
  final bool obscureText;
  final bool? checkMark;
  final TextDirection? textDirection;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;

  const CustomTextField({Key? key, required this.placeholder, this.onChange, this.obscureText = false,this.onSubmit, this.controller,this.inputFormatters = const[], this.checkMark,this.textDirection = TextDirection.ltr, this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      textDirection:widget.textDirection,
      controller: widget.controller,
      onChanged: widget.onChange,
      onSubmitted: widget.onSubmit,
      padding: const EdgeInsets.all(20),
      placeholder: widget.placeholder,
      inputFormatters:widget.inputFormatters ,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      placeholderStyle: const TextStyle(
        color: Color(0xFF515151),
        fontSize: 14,
      ),
      // textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,

      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE7E7E7),
        borderRadius: BorderRadius.circular(7),
      ),
      suffix:
      widget.checkMark == null ?
      SizedBox.shrink() :
      widget.checkMark! ?
      Icon(Icons.check,color: appMainTextColor,) :
      Icon(Icons.close,color: Colors.red,)
      ,
    );
  }
}
