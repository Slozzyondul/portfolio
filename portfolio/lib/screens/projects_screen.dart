import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animations/animations.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _staggerController;
  late Animation<double> _fadeAnimation;
  late List<Animation<double>> _itemAnimations;

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Nairobi MTB - Orders Management',
      'description':
          'A comprehensive order management system for Nairobi MTB with real-time tracking and analytics.',
      'url': 'https://slozzyondula.pythonanywhere.com/',
      'image': 'assets/images/python.jpeg',
      'tech': ['Python', 'Django', 'SQLite', 'Bootstrap'],
      'category': 'Web Application',
    },
    {
      'title': 'Corruption Zii',
      'description':
          'A social justice platform for reporting and tracking corruption cases with community engagement features.',
      'url':
          'https://slozzyondul.github.io/Social_Justice_and_Reform_Hackathon/',
      'image': 'assets/images/corruption_zii.png',
      'tech': ['HTML', 'CSS', 'JavaScript', 'GitHub Pages'],
      'category': 'Web Platform',
    },
    {
      'title': 'Dog Food',
      'description':
          'An e-commerce platform for pet food and supplies with inventory management and order processing.',
      'url': 'https://slozzyondul.github.io/dog_food/',
      'image': 'assets/images/dog_food.jpeg',
      'tech': ['HTML', 'CSS', 'JavaScript', 'Local Storage'],
      'category': 'E-commerce',
    },
    {
      'title': 'Music App',
      'description':
          'A modern music streaming application with playlist management and audio controls.',
      'url': 'https://slozzyondul.github.io/music-app/',
      'image': 'assets/images/music_app.jpeg',
      'tech': ['HTML', 'CSS', 'JavaScript', 'Web Audio API'],
      'category': 'Entertainment',
    },
    {
      'title': 'My Pocket Wallet',
      'description':
          'A personal finance management app for tracking expenses, income, and budgeting.',
      'url': 'https://slozzyondul.github.io/wallet/',
      'image': 'assets/images/wallet.jpeg',
      'tech': ['HTML', 'CSS', 'JavaScript', 'Chart.js'],
      'category': 'Finance',
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
      projects.length,
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

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeProvider.isDarkMode
                ? [
                    const Color(0xFF0A0A0A),
                    const Color(0xFF1E1B4B),
                    const Color(0xFF312E81),
                    const Color(0xFF0A0A0A),
                  ]
                : [
                    const Color(0xFFFAFAFA),
                    const Color(0xFFE5E7EB),
                    const Color(0xFFD1D5DB),
                    const Color(0xFFFAFAFA),
                  ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: LayoutBuilder(builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            return Padding(
              padding: EdgeInsets.all(screenWidth > 768 ? 24.0 : 16.0),
              child: Column(
                crossAxisAlignment: screenWidth > 768
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  // Header
                  Text(
                    'My Projects',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign:
                        screenWidth > 768 ? TextAlign.left : TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Here are some of the projects I\'ve worked on',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign:
                        screenWidth > 768 ? TextAlign.left : TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Projects Grid
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;
                        double screenHeight = constraints.maxHeight;

                        // Determine cross axis count based on screen width
                        int crossAxisCount;
                        if (screenWidth > 1400) {
                          crossAxisCount = 4;
                        } else if (screenWidth > 1200) {
                          crossAxisCount = 3;
                        } else if (screenWidth > 768) {
                          crossAxisCount = 2;
                        } else {
                          crossAxisCount = 1;
                        }

                        // Calculate responsive spacing
                        double spacing = screenWidth > 1200
                            ? 32.0
                            : screenWidth > 768
                                ? 24.0
                                : 16.0;

                        // Calculate responsive aspect ratio
                        double aspectRatio;
                        if (screenWidth > 1400) {
                          aspectRatio = 0.8; // Wider cards for large screens
                        } else if (screenWidth > 1200) {
                          aspectRatio = 0.75;
                        } else if (screenWidth > 768) {
                          aspectRatio = 0.7;
                        } else {
                          aspectRatio = 0.65; // Taller cards for mobile
                        }

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: spacing,
                            mainAxisSpacing: spacing,
                            childAspectRatio: aspectRatio,
                          ),
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: _itemAnimations[index],
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _itemAnimations[index].value,
                                  child: _buildProjectCard(
                                    projects[index],
                                    theme,
                                    screenWidth,
                                    screenHeight,
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
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    Map<String, dynamic> project,
    ThemeData theme,
    double screenWidth,
    double screenHeight,
  ) {
    return OpenContainer(
      closedElevation: screenWidth > 768 ? 8 : 6,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth > 768 ? 20 : 16),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, _) => _buildProjectDetail(project, theme),
      closedBuilder: (context, openContainer) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeProvider.isDarkMode
                  ? [
                      theme.colorScheme.surface.withOpacity(0.9),
                      theme.colorScheme.surface.withOpacity(0.85),
                    ]
                  : [
                      theme.colorScheme.surface.withOpacity(0.95),
                      theme.colorScheme.surface.withOpacity(0.9),
                    ],
            ),
            borderRadius: BorderRadius.circular(screenWidth > 768 ? 20 : 16),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: themeProvider.isDarkMode
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.1),
                blurRadius: screenWidth > 768 ? 25 : 20,
                offset: Offset(0, screenWidth > 768 ? 15 : 12),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Project Image
              Expanded(
                flex: screenWidth > 768 ? 3 : 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(screenWidth > 768 ? 20 : 16),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        project['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: theme.colorScheme.surface.withOpacity(0.5),
                            child: Icon(
                              Icons.image_not_supported,
                              color: theme.colorScheme.primary,
                              size: screenWidth > 768 ? 48 : 32,
                            ),
                          );
                        },
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      // Category badge
                      Positioned(
                        top: screenWidth > 768 ? 16 : 12,
                        right: screenWidth > 768 ? 16 : 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth > 768 ? 12 : 8,
                            vertical: screenWidth > 768 ? 6 : 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(
                              screenWidth > 768 ? 20 : 16,
                            ),
                          ),
                          child: Text(
                            project['category'],
                            style: (screenWidth > 768
                                    ? theme.textTheme.bodySmall
                                    : theme.textTheme.bodySmall
                                        ?.copyWith(fontSize: 10))
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Project Info
              Expanded(
                flex: screenWidth > 768 ? 2 : 3,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth > 768 ? 20 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project['title'],
                        style: (screenWidth > 768
                                ? theme.textTheme.headlineSmall
                                : theme.textTheme.titleLarge)
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: screenWidth > 768 ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenWidth > 768 ? 8 : 6),
                      Text(
                        project['description'],
                        style: (screenWidth > 768
                                ? theme.textTheme.bodyMedium
                                : theme.textTheme.bodySmall)
                            ?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        maxLines: screenWidth > 768 ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),

                      // Tech stack
                      Wrap(
                        spacing: screenWidth > 768 ? 6 : 4,
                        runSpacing: screenWidth > 768 ? 6 : 4,
                        children: (project['tech'] as List<String>)
                            .take(screenWidth > 768 ? 3 : 2)
                            .map((tech) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth > 768 ? 8 : 6,
                              vertical: screenWidth > 768 ? 4 : 3,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                screenWidth > 768 ? 12 : 8,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: (screenWidth > 768
                                      ? theme.textTheme.bodySmall
                                      : theme.textTheme.bodySmall
                                          ?.copyWith(fontSize: 10))
                                  ?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const Spacer(),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _launchURL(project['url']),
                              icon: Icon(
                                Icons.open_in_new,
                                size: screenWidth > 768 ? 16 : 14,
                              ),
                              label: Text(
                                screenWidth > 768 ? 'View Project' : 'View',
                                style: TextStyle(
                                  fontSize: screenWidth > 768 ? null : 12,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenWidth > 768 ? 12 : 8,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth > 768 ? 8 : 6),
                          IconButton(
                            onPressed: openContainer,
                            icon: Icon(
                              Icons.info_outline,
                              size: screenWidth > 768 ? 24 : 20,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: theme.colorScheme.surface,
                              foregroundColor: theme.colorScheme.primary,
                              padding: EdgeInsets.all(
                                screenWidth > 768 ? 8 : 6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProjectDetail(Map<String, dynamic> project, ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          project['title'],
          style: TextStyle(
            color: themeProvider.isDarkMode
                ? Colors.white
                : const Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color:
              themeProvider.isDarkMode ? Colors.white : const Color(0xFF1F2937),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeProvider.isDarkMode
                ? Colors.white
                : const Color(0xFF1F2937),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeProvider.isDarkMode
                ? [
                    const Color(0xFF0A0A0A),
                    const Color(0xFF1E1B4B),
                    const Color(0xFF312E81),
                    const Color(0xFF0A0A0A),
                  ]
                : [
                    const Color(0xFFFAFAFA),
                    const Color(0xFFE5E7EB),
                    const Color(0xFFD1D5DB),
                    const Color(0xFFFAFAFA),
                  ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: themeProvider.isDarkMode
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 25,
                      offset: const Offset(0, 15),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    project['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: theme.colorScheme.surface.withOpacity(0.5),
                        child: Icon(
                          Icons.image_not_supported,
                          color: theme.colorScheme.primary,
                          size: 64,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Project Title
              Text(
                project['title'],
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Category
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  project['category'],
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'Description',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                project['description'],
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),

              // Tech Stack
              Text(
                'Technologies Used',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: (project['tech'] as List<String>).map((tech) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      tech,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _launchURL(project['url']),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('View Live Project'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
