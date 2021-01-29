import 'package:ChatApp/widgets/custom.button.dart';
import 'package:ChatApp/widgets/custom.input.dart';
import 'package:ChatApp/widgets/custom.label.dart';
import 'package:ChatApp/widgets/custom.logo.dart';
import 'package:ChatApp/widgets/custom.terms.dart';
import 'package:flutter/material.dart';

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
  final confirmPassword = TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
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
            placeholder: "Confirm password",
            textCont: this.confirmPassword,
            isPassword: true,
          ),
          CustomButton(
              text: "Sign up",
              onPressed: () {
                print(emailCtrl.text);
                print(this.passwordCtrl.text);
                print(this.confirmPassword.text);
              })
        ],
      ),
    );
  }
}
