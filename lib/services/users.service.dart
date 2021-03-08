import 'package:ChatApp/models/responses/users.response.dart';
import 'package:ChatApp/models/users.dart';
import 'package:http/http.dart' as http;

import 'package:ChatApp/globals/enviorement.dart';
import 'package:ChatApp/services/auth.service.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    final String cookie = await AuthService.getToken();
    try {
      final resp = await http.get('${Enviorements.apiUrl}users', headers: {
        "Content-Type": "application/json",
        "Cookie": cookie,
      });

      final UsersListResponse usersListResponse =
          usersListResponseFromJson(resp.body);

      return usersListResponse.users;
    } catch (e) {
      return [];
    }
  }
}
