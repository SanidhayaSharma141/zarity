import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zarity/model/blog_post.dart';

class BlogProvider with ChangeNotifier {
  List<BlogPost> _blogs = [];

  List<BlogPost> get blogs => _blogs;

  BlogProvider() {
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('blogs').get();
      _blogs = snapshot.docs
          .map((doc) => BlogPost.fromMap(doc.data(), doc.id))
          .toList();
      notifyListeners();
    } catch (e) {
      // print(e);
    }
  }
}
