import 'package:flutter/material.dart';
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
                'My Projects',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Here are some of the projects I\'ve worked on',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 32),

              // Projects Grid
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
                        childAspectRatio: 0.75,
                      ),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _itemAnimations[index],
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _itemAnimations[index].value,
                              child: _buildProjectCard(projects[index], theme),
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

  Widget _buildProjectCard(Map<String, dynamic> project, ThemeData theme) {
    return OpenContainer(
      closedElevation: 8,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, _) => _buildProjectDetail(project, theme),
      closedBuilder: (context, openContainer) => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Project Image
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
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
                            size: 48,
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
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          project['category'],
                          style: theme.textTheme.bodySmall?.copyWith(
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
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project['title'],
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project['description'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    // Tech stack
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children:
                          (project['tech'] as List<String>).take(3).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tech,
                            style: theme.textTheme.bodySmall?.copyWith(
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
                            icon: const Icon(Icons.open_in_new, size: 16),
                            label: const Text('View Project'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: openContainer,
                          icon: const Icon(Icons.info_outline),
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.surface,
                            foregroundColor: theme.colorScheme.primary,
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
      ),
    );
  }

  Widget _buildProjectDetail(Map<String, dynamic> project, ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(project['title']),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }
}
