import 'package:ChatApp/helpers/show.alert.dart';
import 'package:ChatApp/services/auth.service.dart';
import 'package:ChatApp/services/socket.service.dart';
import 'package:ChatApp/widgets/custom.button.dart';
import 'package:ChatApp/widgets/custom.input.dart';
import 'package:ChatApp/widgets/custom.label.dart';
import 'package:ChatApp/widgets/custom.logo.dart';
import 'package:ChatApp/widgets/custom.terms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.999,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Logo(title: "Register"),
                  _Form(),
                  Labels(
                      route: "login",
                      text1: "Already have an account?",
                      text2: "Log in"),
                  Terms(),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            data: Icons.mail_outline,
            placeholder: "Email",
            textCont: this.emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            data: Icons.lock_outlined,
            placeholder: "Password",
            textCont: this.passwordCtrl,
            isPassword: true,
          ),
          CustomInput(
            data: Icons.lock_outlined,
            placeholder: "name",
            textCont: this.nameCtrl,
          ),
          CustomButton(
              text: "Sign up",
              onPressed: authService.authenticating
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      var isOk = await authService.register(
                          nameCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          passwordCtrl.text.trim());
                      if (isOk) {
                        socketService.connect();
                        Navigator.pushReplacementNamed(context, "users");
                      } else {
                        showAlert(context, "Error", "Email is already in use");
                      }
                    })
        ],
      ),
    );
  }
}
