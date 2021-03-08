import "dart:convert";

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.online,
    this.id,
    this.name,
    this.email,
    this.v,
  });

  bool online;
  String id;
  String name;
  String email;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        online: json["online"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "_id": id,
        "name": name,
        "email": email,
        "__v": v,
      };
}
