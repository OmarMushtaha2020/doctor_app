class MessageNotification{
  String ?name;
  String ?body;
  MessageNotification(this.name,this.body);

  MessageNotification.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    body = json['body'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'body': body,
    };
  }
}