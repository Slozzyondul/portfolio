import 'package:flutter/material.dart';
import 'package:portfolio/methods/blog_card.dart';
import 'package:portfolio/screens/blog_detail_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final List<Map<String, String>> blogPosts = [
    {
      'title': 'Building Scalable Flutter Apps',
      'description': 'Learn how to scale your Flutter apps for production.',
      'image': 'assets/images/flutter_development.jpeg'
    },
    {
      'title': 'State Management in Flutter',
      'description': 'Bloc, Riverpod, Provider? Find out the best approach.',
      'image': 'assets/images/state_management.png',
    },
    {
      'title': 'Integrating APIs in Flutter',
      'description':
          'A step-by-step guide on how to integrate APIs efficiently.',
      'image': 'assets/images/flutter_api.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark theme
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          final post = blogPosts[index];
          return BlogCard(
            title: post['title']!,
            description: post['description']!,
            imageUrl: post['image']!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailScreen(post: post),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



