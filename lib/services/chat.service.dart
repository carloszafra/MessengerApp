import 'package:ChatApp/models/messages.dart';
import 'package:ChatApp/models/responses/messages.response.dart';
import 'package:ChatApp/models/users.dart';
import 'package:ChatApp/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ChatApp/globals/enviorement.dart';

class ChatService with ChangeNotifier {
  User userTO;

  Future<List<Message>> getChat(String userID) async {
    final String cookie = await AuthService.getToken();
    print("esta llamando a get chat");
    print('${Enviorements.apiUrl}messages?to=$userID');
    final resp =
        await http.get('${Enviorements.apiUrl}messages?to=$userID', headers: {
      "Content-Type": "application/json",
      "Cookie": cookie,
    });

    final MessagesResponse messagesResponse =
        messagesResponseFromJson(resp.body);

    return messagesResponse.messages;
  }
}
