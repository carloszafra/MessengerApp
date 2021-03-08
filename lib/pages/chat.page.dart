import 'dart:io';

import 'package:ChatApp/models/messages.dart';
import 'package:ChatApp/services/auth.service.dart';
import 'package:ChatApp/services/chat.service.dart';
import 'package:ChatApp/services/socket.service.dart';
import 'package:ChatApp/widgets/chat.message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  AuthService authService;
  ChatService chatService;
  SocketService socketService;

  bool _writing = false;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    this.authService = Provider.of<AuthService>(context, listen: false);
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);

    this
        .socketService
        .socket
        .on("private-message", (data) => _listenMessage(data));

    this._loadChatRoom(this.chatService.userTO.id);

    super.initState();
  }

  void _loadChatRoom(String userID) async {
    List<Message> chat = await this.chatService.getChat(userID);
    final history = chat.map((e) => new ChatMessage(
        text: e.message,
        uid: e.from,
        animationController: new AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      this._messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic data) {
    print("hay un mensaje $data");
    ChatMessage message = new ChatMessage(
        text: data["message"],
        uid: data["from"],
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 400)));

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userTo = chatService.userTO;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text(userTo.name.substring(0, 2),
                  style: TextStyle(fontSize: 12, color: Colors.white70)),
              backgroundColor: Colors.blue[600],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text(
              userTo.name,
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
      uid: this.authService.user.id,
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

    final userTo = this.chatService.userTO;
    final user = this.authService.user;

    this.socketService.emit("private-message", {
      "from": user.id,
      "to": userTo.id,
      "message": text,
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    this.socketService.socket.off("private-message");

    super.dispose();
  }
}
