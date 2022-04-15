class NotificationModel {
  final int? id;
  final String? content;
  final String? createdAt;
  final bool? isSeen;

  NotificationModel({this.id, this.content, this.createdAt, this.isSeen});

  factory NotificationModel.fromJson({required Map<String, dynamic> map}) {
    return NotificationModel(
        id: map["id"],
        content: map["content"],
        createdAt: map["created_at"],
        isSeen: map["isSeen"]);
  }
}
