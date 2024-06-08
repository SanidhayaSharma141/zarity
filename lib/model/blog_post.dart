import 'package:hive/hive.dart';

part 'blog_post.g.dart';

@HiveType(typeId: 1)
class BlogPost extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String summary;

  @HiveField(4)
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
