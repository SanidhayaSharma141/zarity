import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zarity/provider/blog_provider.dart';

class BlogDetailScreen extends StatelessWidget {
  final String? id;

  const BlogDetailScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final blog = blogProvider.blogs.where((element) => element.id == id).first;
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.1,
        title: Text(blog.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  blog.imageUrl,
                  width: double.infinity > 600 ? 600 : double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(16, 13, 34, 1),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                blog.summary,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.black38),
              const SizedBox(height: 16),
              const Text(
                "Blog Content",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(16, 13, 34, 1),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    blog.content ??
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac volutpat nisi. Aliquam erat volutpat. Suspendisse et commodo libero, nec gravida dui. Integer consectetur eros in nunc facilisis, nec pellentesque tortor vulputate. Vivamus malesuada justo vel urna iaculis, a aliquam ex accumsan. Integer at tortor libero. Curabitur ac nisi dui. Integer facilisis sit amet augue sit amet pretium. Cras ac est ut nulla interdum consequat. Sed euismod eros sit amet velit ultrices efficitur.",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
