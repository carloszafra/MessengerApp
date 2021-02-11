import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {Key key,
      @required this.text,
      @required this.uid,
      @required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animationController,
        child: SizeTransition(
            sizeFactor: CurvedAnimation(
                parent: animationController, curve: Curves.easeInOut),
            child: Container(
                child: this.uid == "123" ? _myMessage() : _message())));
  }

  Widget _myMessage() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.only(left: 50, bottom: 5, right: 5),
          padding: EdgeInsets.all(8.0),
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Color(0xff4D9EF6),
              borderRadius: BorderRadius.circular(20)),
        ));
  }

  Widget _message() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(left: 5, bottom: 5, right: 50),
          padding: EdgeInsets.all(8.0),
          child: Text(
            this.text,
            style: TextStyle(color: Colors.black87),
          ),
          decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(20)),
        ));
  }
}
