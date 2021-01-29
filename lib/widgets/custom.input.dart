import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData data;
  final String placeholder;
  final TextEditingController textCont;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({
    Key key,
    @required this.data,
    @required this.placeholder,
    @required this.textCont,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5,
              )
            ]),
        child: TextField(
          controller: this.textCont,
          autocorrect: false,
          keyboardType: this.keyboardType,
          obscureText: this.isPassword,
          decoration: InputDecoration(
              prefixIcon: Icon(this.data),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: this.placeholder,
              hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
        ));
  }
}
