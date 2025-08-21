import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animations/animations.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final List<Map<String, String>> projects = [
    {
      'title': 'Nairobi MTB - Orders Management',
      'url': 'https://slozzyondula.pythonanywhere.com/',
      'image': 'assets/images/python.jpeg'
    },
    {
      'title': 'Corruption Zii',
      'url':
          'https://slozzyondul.github.io/Social_Justice_and_Reform_Hackathon/',
      'image': 'assets/images/corruption_zii.png'
    },
    {
      'title': 'Dog Food',
      'url': 'https://slozzyondul.github.io/dog_food/',
      'image': 'assets/images/dog_food.jpeg'
    },
    {
      'title': 'Music App',
      'url': 'https://slozzyondul.github.io/music-app/',
      'image': 'assets/images/music_app.jpeg'
    },
    {
      'title': 'My Pocket Wallet',
      'url': 'https://slozzyondul.github.io/wallet/',
      'image': 'assets/images/wallet.jpeg'
    },
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return OpenContainer(
                  closedElevation: 5,
                  closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  transitionDuration: Duration(milliseconds: 500),
                  openBuilder: (context, _) => Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      title: Text(projects[index]['title']!),
                      backgroundColor: Colors.black,
                    ),
                    body: Center(
                      child: Text(
                        projects[index]['title']!,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  closedBuilder: (context, openContainer) => Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () => _launchURL(projects[index]['url']!),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: Image.asset(
                                projects[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Text(
                                  projects[index]['title']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Icon(Icons.open_in_new, color: Colors.amber),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
