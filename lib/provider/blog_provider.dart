import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zarity/model/blog_post.dart';

class BlogProvider with ChangeNotifier {
  List<BlogPost> _blogs = [];
  final Box<BlogPost> _blogBox;

  List<BlogPost> get blogs => _blogs;

  BlogProvider(this._blogBox) {
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      if (_blogBox.isNotEmpty) {
        print('getting from hive');
        _blogs = _blogBox.values.toList();
        notifyListeners();
      } else {
        final snapshot =
            await FirebaseFirestore.instance.collection('blogs').get();
        final List<BlogPost> fetchedBlogs = snapshot.docs.map((doc) {
          return BlogPost.fromMap(doc.data(), doc.id);
        }).toList();

        _blogs = fetchedBlogs;
        await _blogBox.clear();
        for (var blog in fetchedBlogs) {
          await _blogBox.add(blog);
        }

        notifyListeners();
      }
    } catch (e) {
      if (_blogBox.isNotEmpty) {
        _blogs = _blogBox.values.toList();
        notifyListeners();
      } else {
        _blogs = [];
        notifyListeners();
      }
    }
  }
}
