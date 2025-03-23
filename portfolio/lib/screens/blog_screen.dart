import 'package:flutter/material.dart';

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
      'image':
          'https://www.freepik.com/free-vector/app-development-banner_5467426.htm#fromView=keyword&page=1&position=0&uuid=75ff28a8-58cb-4f42-a684-6f9c9e7df04f&query=Flutter',
    },
    {
      'title': 'State Management in Flutter',
      'description': 'Bloc, Riverpod, Provider? Find out the best approach.',
      'image':
          'https://www.freepik.com/free-photo/representations-user-experience-interface-design_37153483.htm#fromView=search&page=1&position=29&uuid=55f34c25-743b-4e31-ab5a-4948fe627c4d&query=Flutter+state+management',
    },
    {
      'title': 'Integrating APIs in Flutter',
      'description':
          'A step-by-step guide on how to integrate APIs efficiently.',
      'image':
          'https://www.freepik.com/free-vector/flat-design-api-illustration_25876189.htm#fromView=search&page=1&position=3&uuid=a6016fbb-bd8d-412f-a015-b48a089df854&query=api+in+Flutter',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark theme
      appBar: AppBar(
        title: const Text('Blog'),
        backgroundColor: Colors.black,
      ),
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

// Blog Card Widget
class BlogCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const BlogCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.black45,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Blog Detail Screen
class BlogDetailScreen extends StatelessWidget {
  final Map<String, String> post;

  const BlogDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(post['title']!),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Expanded(
                child: Image.network(
                  post['image']!,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image,
                        color: Colors.white, size: 50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post['title']!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              post['description']!,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget est eu risus venenatis facilisis ut et lorem. Proin luctus pharetra elit, nec sodales turpis fermentum et. Duis consectetur augue vel volutpat elementum.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
