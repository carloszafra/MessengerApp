import 'package:ChatApp/pages/chat.page.dart';
import 'package:ChatApp/pages/loading.page.dart';
import 'package:ChatApp/pages/login.page.dart';
import 'package:ChatApp/pages/register.page.dart';
import 'package:ChatApp/pages/users.page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "users": (_) => UsersPage(),
  "login": (_) => LoginPage(),
  "register": (_) => RegisterPage(),
  "chat": (_) => ChatPage(),
  "loading": (_) => LoadingPage(),
};
