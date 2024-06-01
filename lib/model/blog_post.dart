class BlogPost {
  final String id;
  final String imageUrl;
  final String title;
  final String summary;
  final String? content;

  BlogPost({
    this.content,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.summary,
  });

  factory BlogPost.fromMap(Map<String, dynamic> data, String id) {
    return BlogPost(
      id: id,
      content: data['content'],
      imageUrl: data['imageUrl'],
      title: data['title'],
      summary: data['summary'],
    );
  }
}
