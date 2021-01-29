import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue[400],
      highlightColor: Colors.blue[600],
      shape: StadiumBorder(),
      onPressed: this.onPressed,
      child: Container(
          width: double.infinity,
          height: 40,
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(color: Color(0xffF2F2F2)),
            ),
          )),
    );
  }
}
