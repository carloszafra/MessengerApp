import 'package:ChatApp/models/users.dart';
import 'package:ChatApp/services/chat.service.dart';
import 'package:ChatApp/services/socket.service.dart';
import 'package:ChatApp/services/users.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ChatApp/services/auth.service.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userService = new UsersService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<User> usersDB = [];

  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService _authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final user = _authService.user;
    print(user);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            user.name,
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            onPressed: () {
              socketService.disconnect();
              AuthService.deleteToken();
              Navigator.pushReplacementNamed(context, "login");
            },
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? Icon(Icons.check_circle, color: Colors.blue[400])
                  : Icon(Icons.offline_bolt, color: Colors.redAccent),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue[400],
          ),
          child: _usersListView(),
          onRefresh: _loadUsers,
        ));
  }

  ListView _usersListView() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => buildListTile(usersDB[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usersDB.length,
    );
  }

  ListTile buildListTile(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email ?? "default value"),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
        backgroundColor: Colors.lightBlue[300],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.blue[300] : Colors.grey[400],
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTO = user;
        Navigator.pushNamed(context, "chat");
      },
    );
  }

  _loadUsers() async {
    this.usersDB = await this.userService.getUsers();

    setState(() {});

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
