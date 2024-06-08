import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zarity/model/blog_post.dart';

void uploadDummyBlogsToFirestore() async {
  final CollectionReference blogsRef =
      FirebaseFirestore.instance.collection('blogs');

  List<Map<String, dynamic>> dummyBlogs = [
    {
      'title': 'The Art of Learning',
      'summary':
          'Learning is a journey. Discover the strategies and techniques that can help you master new skills effectively.',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Exploring Nature: A Photographic Journey',
      'summary':
          'Embark on a visual adventure through stunning landscapes and captivating wildlife photography.',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'The Power of Mindfulness',
      'summary':
          'Learn how practicing mindfulness can improve your mental well-being and enhance your daily life.',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'The Science of Happiness',
      'summary':
          'Discover the latest research and insights into what truly makes us happy and how to cultivate happiness in our lives.',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Mastering the Art of Cooking',
      'summary':
          'From basic techniques to advanced recipes, dive into the world of culinary arts and unleash your inner chef.',
      'imageUrl': 'https://via.placeholder.com/150',
    },
  ];

  for (var blogData in dummyBlogs) {
    await blogsRef.add(blogData);
  }

  // print('Dummy blogs uploaded to Firestore.');
}

Future<void> addBlogPost(BlogPost blogPost) async {
  final CollectionReference blogsRef =
      FirebaseFirestore.instance.collection('blogs');

  try {
    await blogsRef.add({
      'title': blogPost.title,
      'summary': blogPost.summary,
      'imageUrl': blogPost.imageUrl,
    });
  } catch (e) {
    // print('Failed to add blog post: $e');
  }
}

Future<List<BlogPost>> fetchFromFirestore() async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection('blogs').get();
    final List<BlogPost> fetchedBlogs = snapshot.docs.map((doc) {
      return BlogPost.fromMap(doc.data(), doc.id);
    }).toList();

    return fetchedBlogs;
  } catch (e) {
    // Handle error appropriately
    rethrow;
  }
}

List<BlogPost> loadFromHive(Box<BlogPost> blogBox) {
  return blogBox.values.toList();
}

Future<void> saveToHive(Box<BlogPost> blogBox, List<BlogPost> blogs) async {
  await blogBox.clear(); // Clear old entries before adding new ones
  for (var blog in blogs) {
    await blogBox.add(blog);
  }
}
