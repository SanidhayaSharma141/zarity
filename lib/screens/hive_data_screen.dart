import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zarity/model/blog_post.dart';
import 'package:zarity/screens/blog_item_preview.dart';

class HiveDataScreen extends StatelessWidget {
  const HiveDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogBox = Hive.box<BlogPost>('blogPosts');
    final List<BlogPost> blogPosts = blogBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Stored Data'),
      ),
      body: blogPosts.isEmpty
          ? const Center(
              child: Text("Empty Hive data"),
            )
          : ListView.builder(
              itemCount: blogPosts.length,
              itemBuilder: (context, index) {
                final blogPost = blogPosts[index];
                return BlogItemPreview(id: blogPost.id);
              },
            ),
    );
  }
}
