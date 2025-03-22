import 'package:flutter/material.dart';
import 'package:portfolio/methods/contact_info.dart';
import 'package:portfolio/methods/service_card.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sidebar Profile Section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/logo.JPG'),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Solomon Ondula Omusinde',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Flutter Developer',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 16),
                        // Contact Information
                        ContactInfo(
                            icon: Icons.email, text: 'solomonondula@gmail.com'),
                        ContactInfo(icon: Icons.phone, text: '+254 792352745'),
                        ContactInfo(
                            icon: Icons.location_on, text: 'Nairobi, Kenya'),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.linked_camera, color: Colors.white),
                            SizedBox(width: 10),
                            Icon(Icons.g_translate, color: Colors.white),
                            SizedBox(width: 10),
                            Icon(Icons.alternate_email, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Main Content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _verticalScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About Me',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'A passionate Flutter developer with strong expertise in cross-platform applications ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "What I'm Doing",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ServiceCard(
                                  title: 'Mobile Apps',
                                  subtitle:
                                      'Professional development of applications for Android and iOS.'),
                              ServiceCard(
                                  title: 'Web Development',
                                  subtitle:
                                      'High-quality development of sites at the professional level.'),
                              ServiceCard(
                                  title: 'UI/UX Design',
                                  subtitle:
                                      'The most modern and high-quality design made at a professional level.'),
                              ServiceCard(
                                  title: 'Backend Development',
                                  subtitle:
                                      'High-performance backend services designed for scalability.'),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Skills",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SingleChildScrollView(
                            controller: _horizontalScrollController,
                            scrollDirection: Axis.horizontal,
                            child: Scrollbar(
                              controller: _horizontalScrollController,
                              scrollbarOrientation: ScrollbarOrientation.bottom,
                              thumbVisibility: true,
                              trackVisibility: true,
                              thickness: 6,
                              radius: Radius.circular(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child:
                                        Image.asset('assets/images/dart.png'),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Image.asset(
                                        'assets/images/flutter.png'),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Image.asset(
                                        'assets/images/python.jpeg'),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child:
                                        Image.asset('assets/images/linux.jpeg'),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child:
                                        Image.asset('assets/images/sql.jpeg'),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Image.asset('assets/images/git.png'),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Image.asset(
                                        'assets/images/javascript.png'),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Image.asset('assets/images/go.png'),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  // Sidebar Profile Section
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/logo.JPG'),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Solomon Ondula Omusinde',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Flutter Developer',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 16),
                          // Contact Information
                          ContactInfo(
                              icon: Icons.email,
                              text: 'solomonondula@gmail.com'),
                          ContactInfo(
                              icon: Icons.phone, text: '+254 792352745'),
                          ContactInfo(
                              icon: Icons.location_on, text: 'Nairobi, Kenya'),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.linked_camera, color: Colors.white),
                              SizedBox(width: 10),
                              Icon(Icons.g_translate, color: Colors.white),
                              SizedBox(width: 10),
                              Icon(Icons.alternate_email, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Main Content
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Me',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'A passionate Flutter developer with strong expertise in cross-platform apps... ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "What I'm Doing",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ServiceCard(
                                title: 'Mobile Apps',
                                subtitle:
                                    'Professional development of applications for Android and iOS.'),
                            ServiceCard(
                                title: 'Web Development',
                                subtitle:
                                    'High-quality development of sites at the professional level.'),
                            ServiceCard(
                                title: 'UI/UX Design',
                                subtitle:
                                    'The most modern and high-quality design made at a professional level.'),
                            ServiceCard(
                                title: 'Backend Development',
                                subtitle:
                                    'High-performance backend services designed for scalability.'),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Skills",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SingleChildScrollView(
                          controller: _horizontalScrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset('assets/images/dart.png'),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset('assets/images/flutter.png'),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset('assets/images/python.jpeg'),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset('assets/images/linux.jpeg'),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset('assets/images/sql.jpeg'),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset('assets/images/git.png'),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child:
                                    Image.asset('assets/images/javascript.png'),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset('assets/images/go.png'),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
