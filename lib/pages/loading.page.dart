import 'package:ChatApp/pages/users.page.dart';
import 'package:ChatApp/pages/login.page.dart';
import 'package:ChatApp/services/auth.service.dart';
import 'package:ChatApp/services/socket.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text("Loading"),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final AuthService authService = Provider.of<AuthService>(context);
    final SocketService socketService =
        Provider.of<SocketService>(context, listen: false);
    final bool isAuth = await authService.isAuth();
    print(isAuth);

    if (isAuth) {
      //Navigator.pushReplacementNamed(context, "users");
      socketService.connect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsersPage(),
            transitionDuration: Duration(milliseconds: 0),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0),
          ));
    }
  }
}
