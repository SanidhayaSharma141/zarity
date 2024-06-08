import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:zarity/app_theme.dart';
import 'package:zarity/firebase_options.dart';
import 'package:zarity/model/blog_post.dart';
import 'package:zarity/provider/blog_provider.dart';
import 'package:zarity/screens/blog_list.dart';
import 'package:zarity/screens/detail_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(BlogPostAdapter()); // Register the adapter
  final blogBox = await Hive.openBox<BlogPost>('blogPosts');

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Lock screen orientation to portrait
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp(blogBox: blogBox));
}

class MyApp extends StatelessWidget {
  final Box<BlogPost> blogBox;

  MyApp({required this.blogBox, super.key});

  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BlogListScreen(),
        routes: [
          GoRoute(
            path: 'blog/:blogID',
            builder: (context, state) =>
                BlogDetailScreen(id: state.pathParameters['blogID']!),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return ChangeNotifierProvider(
      create: (_) => BlogProvider(blogBox),
      child: MaterialApp.router(
        routerConfig: goRouter,
        title: 'Blog App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: AppTheme.textTheme,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(240, 234, 220, 0.5)),
          scaffoldBackgroundColor: const Color.fromRGBO(240, 234, 220, 1),
          platform: TargetPlatform.iOS,
        ),
      ),
    );
  }
}
