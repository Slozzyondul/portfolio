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
      'title': 'Ngando Preparatory Schools',
      'description':
          'A comprehensive educational platform for Ngando Preparatory Schools, featuring academic program details, character development values, and an interactive donation portal.',
      'url': 'https://ngandopreparatoryschools.org/',
      'image': 'assets/images/ngando_school.png',
      'tech': ['Python', 'Django', 'Bootstrap', 'JavaScript'],
      'category': 'Education Platform',
    },
    {
      'title': 'Devotional',
      'description':
          'A digital sanctuary for worship, featuring weekly sessions, Bible study videos, and inspirational spiritual content.',
      'url': 'https://slozzyondul.github.io/devotion/',
      'image': 'assets/images/devotion.png',
      'tech': ['Flutter', 'Dart', 'GitHub Pages'],
      'category': 'Digital Ministry',
    },
    {
      'title': 'Ambient Atelier',
      'description':
          'Professional event planning and lighting services for weddings, corporate events, and celebrations in Nairobi.',
      'url': 'https://www.ambientatelier.co.ke/',
      'image': 'assets/images/flutter_development.jpeg',
      'tech': ['Python', 'Django', 'Bootstrap', 'CSS3'],
      'category': 'Event Services',
    },
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
                      builder: (context, gridConstraints) {
                        double gridWidth = gridConstraints.maxWidth;

                        // Calculate responsive spacing
                        double spacing = gridWidth > 1200
                            ? 32.0
                            : gridWidth > 768
                                ? 24.0
                                : 16.0;

                        return GridView.builder(
                          padding: const EdgeInsets.only(bottom: 24),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 450,
                            crossAxisSpacing: spacing,
                            mainAxisSpacing: spacing,
                            childAspectRatio: 0.78,
                          ),
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: _itemAnimations[index],
                              builder: (context, child) {
                                return FadeTransition(
                                  opacity: _itemAnimations[index],
                                  child: Transform.translate(
                                    offset: Offset(
                                        0,
                                        20 *
                                            (1 - _itemAnimations[index].value)),
                                    child: _ProjectCard(
                                      project: projects[index],
                                      onLaunch: () =>
                                          _launchURL(projects[index]['url']),
                                    ),
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
}

class ProjectDetailScreen extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailScreen({super.key, required this.project});

  void _launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
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
                  child: Hero(
                    tag: 'project_${project['title']}',
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
                  onPressed: () => _launchURL(project['url'], context),
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

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final VoidCallback onLaunch;

  const _ProjectCard({
    required this.project,
    required this.onLaunch,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -12.0 : 0.0),
        child: OpenContainer(
          closedElevation: _isHovered ? 20 : 8,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          transitionDuration: const Duration(milliseconds: 500),
          openBuilder: (context, _) =>
              ProjectDetailScreen(project: widget.project),
          closedBuilder: (context, openContainer) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: themeProvider.isDarkMode
                      ? [
                          theme.colorScheme.surface,
                          theme.colorScheme.surface.withOpacity(0.95),
                          theme.colorScheme.surface.withOpacity(0.9),
                        ]
                      : [
                          Colors.white,
                          theme.colorScheme.surface.withOpacity(0.98),
                          theme.colorScheme.surface.withOpacity(0.95),
                        ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _isHovered
                      ? theme.colorScheme.primary.withOpacity(0.4)
                      : theme.colorScheme.primary.withOpacity(0.1),
                  width: _isHovered ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: themeProvider.isDarkMode
                        ? Colors.black.withOpacity(0.5)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: _isHovered ? 40 : 20,
                    offset: Offset(0, _isHovered ? 20 : 10),
                    spreadRadius: _isHovered ? 4 : 0,
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                      spreadRadius: 0,
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Section
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Hero(
                            tag: 'project_${widget.project['title']}',
                            child: Image.asset(
                              widget.project['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.1),
                                child: Icon(Icons.image_not_supported,
                                    size: 48, color: theme.colorScheme.primary),
                              ),
                            ),
                          ),
                          // Subtle overlay for text readability
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.0),
                                  Colors.black.withOpacity(0.6),
                                ],
                              ),
                            ),
                          ),
                          // Category Badge
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2))
                                ],
                              ),
                              child: Text(
                                widget.project['category'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Content Section
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project['title'],
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: -0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.project['description'],
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.7),
                              height: 1.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                          // Tech chips
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: (widget.project['tech'] as List<String>)
                                .take(3)
                                .map((tech) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary
                                            .withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: theme.colorScheme.primary
                                              .withOpacity(0.15),
                                        ),
                                      ),
                                      child: Text(
                                        tech,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          const Spacer(),
                          // Action Row
                          Row(
                            children: [
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: widget.onLaunch,
                                  icon: const Icon(Icons.open_in_new, size: 18),
                                  label: const Text('Live Demo'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: theme.colorScheme.primary,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: openContainer,
                                icon: const Icon(Icons.info_outline),
                                color:
                                    theme.colorScheme.primary.withOpacity(0.8),
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
        ),
      ),
    );
  }
}
