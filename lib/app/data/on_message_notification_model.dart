class MessageNotification{
  String ?name;
  String ?body;
  String ?id;
  MessageNotification(this.name,this.body,this.id);

  MessageNotification.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    body = json['body'];
    id=json['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'body': body,
      'id':id,
    };
  }
}