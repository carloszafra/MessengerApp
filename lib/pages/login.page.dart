import 'package:ChatApp/widgets/custom.button.dart';
import 'package:ChatApp/widgets/custom.label.dart';
import 'package:ChatApp/widgets/custom.logo.dart';
import 'package:ChatApp/widgets/custom.terms.dart';
import 'package:flutter/material.dart';
import 'package:ChatApp/widgets/custom.input.dart';

class LoginPage extends StatelessWidget {
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
                Logo(title: "Messenger"),
                _Form(),
                Labels(
                  text1: "Don't have an account?",
                  text2: "Create one!",
                  route: "register",
                ),
                Terms(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            data: Icons.mail_outline,
            placeholder: "Email",
            textCont: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            data: Icons.lock_outline,
            placeholder: "Password",
            textCont: passwordCtrl,
            isPassword: true,
          ),
          CustomButton(
            text: "Log in",
            onPressed: () {
              print(this.emailCtrl.text);
              print(this.passwordCtrl.text);
            },
          )
        ],
      ),
    );
  }
}
