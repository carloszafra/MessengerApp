import 'dart:convert';
import 'dart:core';

import 'package:ChatApp/globals/enviorement.dart';
import 'package:ChatApp/models/responses/login.response.dart';
import 'package:ChatApp/models/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;

class AuthService with ChangeNotifier {
  final _storage = new FlutterSecureStorage();
  String cookie = "";

  User user;

  bool _authenticating = false;
  bool get authenticating => this._authenticating;
  set authenticating(bool val) {
    this._authenticating = val;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    this.authenticating = true;
    final data = {"email": email, "password": password};
    print('${Enviorements.apiUrl}auth/login');

    final resp = await http.post('${Enviorements.apiUrl}auth/login',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    _updateCookies(resp);
    this.authenticating = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    this.authenticating = true;
    final data = {"name": name, "email": email, "password": password};
    final resp = await http.post('${Enviorements.apiUrl}/auth/register',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    print(resp.body);
    print(resp.headers);
    _updateCookies(resp);
    this.authenticating = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      return true;
    } else {
      return false;
    }
  }

  Future isAuth() async {
    final String tokenCookie = await this._storage.read(key: "Cookie");

    print(tokenCookie);
    // String finalCookie = (tokenCookie != null) ? tokenCookie : "asasdasd";
    print('${Enviorements.apiUrl}auth/renew');

    final resp = await http.get('${Enviorements.apiUrl}auth/renew', headers: {
      'Content-Type': 'application/json',
      'Cookie': '$tokenCookie'
    });

    _updateCookies(resp);

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      print(this.user);
      return true;
    } else {
      //this.logOut();
      return false;
    }
  }

  void _updateCookies(http.Response response) {
    String rawCookie = response.headers["set-cookie"];

    if (rawCookie != null) {
      int index = rawCookie.indexOf(";");
      String authCookie =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
      this.cookie = authCookie;
      _saveTokenCookie(this.cookie);
    }
  }

  Future _saveTokenCookie(String cookie) async {
    print(this.cookie);
    return await this._storage.write(key: "Cookie", value: cookie);
  }

  Future logOut() async {
    await this._storage.delete(key: "Cookie");
  }

  //Static methods

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final tokenCookie = await _storage.read(key: "Cookie");
    print(tokenCookie);
    return tokenCookie;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "Cookie");
  }
}
