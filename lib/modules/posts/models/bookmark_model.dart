import 'package:chart_ganga/modules/posts/models/post_model.dart';

class BookmarkModel {
  final int? id;
  final String? createdAt;
  final PostModel? post;

  BookmarkModel({this.createdAt, this.id, this.post});

  factory BookmarkModel.fromJson({required Map<String, dynamic> map}) {
    return BookmarkModel(
        id: map["id"],
        post: (map["post_data"] != null)
            ? PostModel.fromJson(map: map["post_data"])
            : null,
        createdAt: map["created_at"]);
  }
}
