import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zarity/model/blog_post.dart';
import 'package:zarity/provider/blog_provider.dart';
import 'package:zarity/screens/blog_item_preview.dart';
import 'package:zarity/screens/hive_data_screen.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  String? selectedTitle;
  int? index;
  final itemScrollController = ItemScrollController();
  Future scrolltoBlog() async {
    itemScrollController.scrollTo(
        index: index!,
        duration: const Duration(milliseconds: 500),
        alignment: 0.2);
  }

  bool flag = false;
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final blogs = blogProvider.blogs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Posts'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HiveDataScreen()));
              },
              icon: const Icon(Icons.verified)),
          if (blogs.isNotEmpty)
            DropdownButton<String>(
              value: selectedTitle,
              focusColor: Colors.black26,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              dropdownColor: Colors.black,
              style: const TextStyle(color: Colors.white),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTitle = newValue;
                  index = blogs.indexWhere((blog) => blog.title == newValue);
                  scrolltoBlog();
                });
              },
              items: blogs.map((blog) {
                return DropdownMenuItem<String>(
                  value: blog.title,
                  child: SizedBox(width: 100, child: Text(blog.title)),
                );
              }).toList(),
            ),
        ],
      ),
      body: blogs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return BlogItemPreview(id: blog.id);
              },
            ),
      //Normal ListView Builder
      // ListView.builder(
      //   itemCount: blogs.length,
      //   itemBuilder: (context, index) {
      //     final blog = blogs[index];
      //     return BlogItemPreview(id: blog.id);
      //   },
      // ),
    );
  }
}
