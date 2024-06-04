class NotificModel {
  int? id;
  String? title;
  String? message;

  NotificModel({this.id, this.title, this.message});

  NotificModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }

  
}