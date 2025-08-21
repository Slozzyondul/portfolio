import 'package:flutter/material.dart';
import 'package:portfolio/methods/blog_card.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _staggerController;
  late Animation<double> _fadeAnimation;
  late List<Animation<double>> _itemAnimations;

  final List<Map<String, String>> blogPosts = [
    {
      'title': 'Getting Started with Flutter Development',
      'excerpt':
          'Learn the basics of Flutter development and how to create your first cross-platform mobile application with this comprehensive guide.',
      'imageUrl': 'assets/images/flutter_development.jpeg',
      'date': 'Dec 15, 2024',
      'readTime': '5 min read',
    },
    {
      'title': 'State Management in Flutter',
      'excerpt':
          'Explore different state management solutions in Flutter including Provider, Bloc, and Riverpod for building scalable applications.',
      'imageUrl': 'assets/images/state_management.png',
      'date': 'Dec 10, 2024',
      'readTime': '8 min read',
    },
    {
      'title': 'Building REST APIs with Flutter',
      'excerpt':
          'Discover how to integrate REST APIs with Flutter applications using HTTP packages and best practices for data handling.',
      'imageUrl': 'assets/images/flutter_api.png',
      'date': 'Dec 5, 2024',
      'readTime': '6 min read',
    },
    {
      'title': 'Flutter UI/UX Best Practices',
      'excerpt':
          'Master the art of creating beautiful and intuitive user interfaces in Flutter with these essential design principles.',
      'imageUrl': 'assets/images/flutter_development.jpeg',
      'date': 'Nov 30, 2024',
      'readTime': '7 min read',
    },
    {
      'title': 'Performance Optimization in Flutter',
      'excerpt':
          'Learn advanced techniques to optimize your Flutter applications for better performance and user experience.',
      'imageUrl': 'assets/images/state_management.png',
      'date': 'Nov 25, 2024',
      'readTime': '10 min read',
    },
    {
      'title': 'Testing Flutter Applications',
      'excerpt':
          'Comprehensive guide to testing Flutter applications including unit tests, widget tests, and integration tests.',
      'imageUrl': 'assets/images/flutter_api.png',
      'date': 'Nov 20, 2024',
      'readTime': '9 min read',
    },
  ];

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _itemAnimations = List.generate(
      blogPosts.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            index * 0.1,
            (index + 1) * 0.1,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _startAnimations();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  void _startAnimations() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _staggerController.forward();
  }

  void _onBlogTap(int index) {
    // Handle blog post tap
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening: ${blogPosts[index]['title']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Blog & Articles',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Thoughts, tutorials, and insights about Flutter development',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 32),

              // Blog Posts Grid
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 1200
                        ? 3
                        : constraints.maxWidth > 768
                            ? 2
                            : 1;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: blogPosts.length,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _itemAnimations[index],
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _itemAnimations[index].value,
                              child: BlogCard(
                                title: blogPosts[index]['title']!,
                                excerpt: blogPosts[index]['excerpt']!,
                                imageUrl: blogPosts[index]['imageUrl']!,
                                date: blogPosts[index]['date']!,
                                readTime: blogPosts[index]['readTime']!,
                                onTap: () => _onBlogTap(index),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
