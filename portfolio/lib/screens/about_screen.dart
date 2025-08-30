import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:portfolio/methods/contact_info.dart';
import 'package:portfolio/methods/service_card.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _startAnimations();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _startAnimations() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;
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
          child: SlideTransition(
            position: _slideAnimation,
            child: isMobile
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildMobileLayout(theme),
                  )
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildDesktopLayout(theme),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Section
        _buildMobileProfileSection(theme),
        const SizedBox(height: 24),

        // Main Content
        _buildMainContent(theme),
      ],
    );
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Section
        Expanded(
          flex: 1,
          child: _buildProfileSection(theme),
        ),
        const SizedBox(width: 32),

        // Main Content
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: _buildMainContent(theme),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(24),
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.3),
          width: 1.5,
        ),
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
      child: Column(
        children: [
          // Profile Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.JPG',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.primary,
                      size: 60,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Name and Title
          Text(
            'Solomon Ondula Omusinde',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Software Developer',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.secondary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Contact Information
          ContactInfo(
            icon: Icons.email,
            text: 'solomonondula@gmail.com',
            onTap: () => _launchEmail('solomonondula@gmail.com'),
          ),
          const SizedBox(height: 8),
          ContactInfo(
            icon: Icons.phone,
            text: '+254 792352745',
            onTap: () => _launchPhone('+254792352745'),
          ),
          const SizedBox(height: 8),
          ContactInfo(
            icon: Icons.location_on,
            text: 'Nairobi, Kenya',
          ),
          const SizedBox(height: 16),
          ContactInfo(
            icon: Icons.link,
            text: "LinkedIn Profile",
            onTap: () => _launchURL(
                'https://www.linkedin.com/in/solomon-ondula-4993471a7/'),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileProfileSection(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(24),
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.3),
          width: 1.5,
        ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.JPG',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.primary,
                      size: 60,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Name and Title
          Text(
            'Solomon Ondula Omusinde',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Software Developer',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.secondary,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Contact Information
          ContactInfo(
            icon: Icons.email,
            text: 'solomonondula@gmail.com',
            onTap: () => _launchEmail('solomonondula@gmail.com'),
          ),
          const SizedBox(height: 8),
          ContactInfo(
            icon: Icons.phone,
            text: '+254 792352745',
            onTap: () => _launchPhone('+254792352745'),
          ),
          const SizedBox(height: 8),
          ContactInfo(
            icon: Icons.location_on,
            text: 'Nairobi, Kenya',
          ),
          const SizedBox(height: 16),
          ContactInfo(
            icon: Icons.link,
            text: "LinkedIn Profile",
            onTap: () => _launchURL(
                'https://www.linkedin.com/in/solomon-ondula-4993471a7/'),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About Me Section
        Text(
          'About Me',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeProvider.isDarkMode
                  ? [
                      theme.colorScheme.surface.withOpacity(0.6),
                      theme.colorScheme.surface.withOpacity(0.5),
                    ]
                  : [
                      theme.colorScheme.surface.withOpacity(0.7),
                      theme.colorScheme.surface.withOpacity(0.6),
                    ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: themeProvider.isDarkMode
                    ? Colors.black.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            'A passionate software developer with strong expertise in cross-platform applications. I specialize in creating beautiful, performant, and user-friendly mobile and web applications using modern development practices and cutting-edge technologies.',
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Services Section
        Text(
          "What I'm Doing",
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ServiceCard(
              title: 'Mobile Apps',
              subtitle:
                  'Professional development of applications for Android and iOS using Flutter framework.',
              icon: Icons.mobile_friendly,
            ),
            ServiceCard(
              title: 'Web Development',
              subtitle:
                  'High-quality development of responsive web applications and progressive web apps.',
              icon: Icons.web,
            ),
            ServiceCard(
              title: 'UI/UX Design',
              subtitle:
                  'Modern and intuitive user interface design with focus on user experience.',
              icon: Icons.design_services,
            ),
            ServiceCard(
              title: 'Backend Development',
              subtitle:
                  'High-performance backend services and APIs designed for scalability.',
              icon: Icons.storage,
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Skills Section
        Text(
          "Skills & Technologies",
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildSkillsGrid(theme),
      ],
    );
  }

  Widget _buildSkillsGrid(ThemeData theme) {
    final skills = [
      {
        'name': 'Dart',
        'image': 'assets/images/dart.png',
        'url': 'https://dart.dev'
      },
      {
        'name': 'Flutter',
        'image': 'assets/images/flutter.png',
        'url': 'https://flutter.dev/'
      },
      {
        'name': 'Python',
        'image': 'assets/images/python.jpeg',
        'url': 'https://www.python.org/'
      },
      {
        'name': 'Linux',
        'image': 'assets/images/linux.jpeg',
        'url': 'https://archlinux.org/'
      },
      {
        'name': 'SQL',
        'image': 'assets/images/sql.jpeg',
        'url': 'https://mariadb.org/'
      },
      {
        'name': 'Git',
        'image': 'assets/images/git.png',
        'url': 'https://git-scm.com/'
      },
      {
        'name': 'JavaScript',
        'image': 'assets/images/javascript.png',
        'url': 'https://www.javascript.com/'
      },
      {'name': 'Go', 'image': 'assets/images/go.png', 'url': 'https://go.dev/'},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800
            ? 4
            : constraints.maxWidth > 600
                ? 3
                : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            final skill = skills[index];
            return _buildSkillCard(skill, theme);
          },
        );
      },
    );
  }

  Widget _buildSkillCard(Map<String, String> skill, ThemeData theme) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(skill['url']!),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  skill['image']!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.image_not_supported,
                        color: theme.colorScheme.primary,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                skill['name']!,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
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

  void _launchEmail(String email) async {
    final Uri uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchPhone(String phone) async {
    final Uri uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
