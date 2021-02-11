import 'dart:io';

import 'package:ChatApp/widgets/chat.message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _writing = false;
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text("CZ",
                  style: TextStyle(fontSize: 12, color: Colors.white70)),
              backgroundColor: Colors.blue[600],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text(
              "Carlos Zafra",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
                child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String text) {
                setState(() {
                  (text.trim().length > 0) ? _writing = true : _writing = false;
                });
              },
              decoration: InputDecoration.collapsed(hintText: "Send message"),
              focusNode: _focusNode,
            )),
            sendButtonContainer()
          ],
        ),
      ),
    );
  }

  Container sendButtonContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Platform.isIOS
          ? CupertinoButton(child: Text("Send"), onPressed: () {})
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconTheme(
                data: IconThemeData(color: Colors.blue[600]),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.send),
                  onPressed: _writing
                      ? () => _handleSubmit(_textController.text)
                      : null,
                ),
              ),
            ),
    );
  }

  _handleSubmit(String text) {
    if (text.length == 0) return;
    print(text);
    final newMessage = new ChatMessage(
      uid: "123",
      text: text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );

    this._messages.insert(0, newMessage);
    newMessage.animationController.forward();
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _writing = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }
}
