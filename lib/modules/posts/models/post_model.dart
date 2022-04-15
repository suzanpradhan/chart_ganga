class PostModel {
  final int? id;
  final String? title;
  final String? content;
  final int? categoryId;
  final String? coverImageLink;
  final int? upVotes;
  final int? downVotes;
  final int? sideVotes;
  final String? createdAt;
  final bool? isVoted;
  final bool? isBookmarked;

  PostModel(
      {this.categoryId,
      this.content,
      this.coverImageLink,
      this.isBookmarked,
      this.createdAt,
      this.downVotes,
      this.id,
      this.sideVotes,
      this.title,
      this.isVoted,
      this.upVotes});

  factory PostModel.fromJson({required Map<String, dynamic> map}) {
    return PostModel(
        id: map["id"],
        title: map["title"],
        content: map["content"],
        coverImageLink: map["file"],
        categoryId: map["category"],
        isBookmarked: map["isBookmarked"],
        upVotes: map["upVotes"],
        isVoted: map["isVoted"],
        downVotes: map["downVotes"],
        sideVotes: map["sideVotes"],
        createdAt: map["created_at"]);
  }
}
