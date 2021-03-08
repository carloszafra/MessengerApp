import 'dart:core';

class Message {
  Message({
    this.id,
    this.from,
    this.to,
    this.message,
    this.date,
    this.v,
  });

  String id;
  String from;
  String to;
  String message;
  DateTime date;
  int v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json["_id"],
      from: json["from"],
      to: json["to"],
      message: json["message"],
      date: DateTime.parse(json["date"]),
      v: json["__v"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "from": from,
        "to": to,
        "message": message,
        "date": date.toIso8601String(),
        "__v": v,
      };
}
