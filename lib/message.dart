class Message {
  String? id;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;

  Message({this.id, this.text, this.createdAt, this.updatedAt});

  /// This is useful to deserialize this dart class
  /// As we cannot use the factory method
  static Message fromMap(Map<String, dynamic> json) {
    return Message.fromJson(json);
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['_id'],
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]));
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': text,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
