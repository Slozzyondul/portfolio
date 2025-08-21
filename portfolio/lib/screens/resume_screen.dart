import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/providers/theme_provider.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen>
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
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Responsive padding based on screen size
    final horizontalPadding = screenWidth < 400
        ? 16.0
        : screenWidth < 768
            ? 20.0
            : screenWidth < 1200
                ? 24.0
                : 32.0;

    final verticalPadding = screenHeight < 600 ? 16.0 : 24.0;

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
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth > 1400 ? 1200 : double.infinity,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: isMobile
                      ? _buildMobileLayout(theme)
                      : _buildDesktopLayout(theme),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(ThemeData theme) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth < 400 ? 16.0 : 24.0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildMobileHeader(theme),
          SizedBox(height: spacing),
          _buildExperienceSection(theme),
          SizedBox(height: spacing),
          _buildEducationSection(theme),
          SizedBox(height: spacing),
          _buildSkillsSection(theme),
          SizedBox(height: spacing), // Extra bottom padding
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1200;
    final spacing = isTablet ? 24.0 : 32.0;

    if (isTablet) {
      // For tablets, use single column with better spacing
      return SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(theme),
            SizedBox(height: spacing),
            _buildExperienceSection(theme),
            SizedBox(height: spacing),
            _buildEducationSection(theme),
            SizedBox(height: spacing),
            _buildSkillsSection(theme),
          ],
        ),
      );
    }

    // For desktop, use two-column layout with proper constraints
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildHeader(theme),
                  SizedBox(height: spacing),
                  _buildExperienceSection(theme),
                ],
              ),
            ),
            SizedBox(width: spacing),

            // Right Column
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildEducationSection(theme),
                  SizedBox(height: spacing),
                  _buildSkillsSection(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1200;
    final padding = isLargeScreen ? 28.0 : 20.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(padding),
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
          borderRadius: BorderRadius.circular(isLargeScreen ? 24 : 20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resume',
              style: (isLargeScreen
                      ? theme.textTheme.displayMedium
                      : theme.textTheme.displaySmall)
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isLargeScreen ? 20 : 16),
            Text(
              'Solomon Ondula Omusinde',
              style: (isLargeScreen
                      ? theme.textTheme.headlineLarge
                      : theme.textTheme.headlineMedium)
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: isLargeScreen ? 12 : 8),
            Text(
              'Flutter Developer',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.secondary,
                letterSpacing: 1.5,
                fontSize: isLargeScreen ? 18 : null,
              ),
            ),
            SizedBox(height: isLargeScreen ? 20 : 16),
            Text(
              'Passionate Flutter developer with expertise in cross-platform mobile and web development. Experienced in building scalable applications with modern development practices.',
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                fontSize: isLargeScreen ? 17 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileHeader(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth < 400 ? 16.0 : 20.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? theme.colorScheme.surface.withOpacity(0.9)
            : theme.colorScheme.surface.withOpacity(0.95),
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
          Text(
            'Resume',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Solomon Ondula Omusinde',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Flutter Developer',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.secondary,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Passionate Flutter developer with expertise in cross-platform mobile and web development. Experienced in building scalable applications with modern development practices.',
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1200;
    final padding = isLargeScreen
        ? 28.0
        : screenWidth < 768
            ? 20.0
            : 24.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? theme.colorScheme.surface.withOpacity(0.9)
            : theme.colorScheme.surface.withOpacity(0.95),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.work,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Work Experience',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildExperienceItem(
            theme,
            'Flutter Developer',
            'Freelance',
            '2023 - Present',
            [
              'Developed cross-platform mobile applications using Flutter framework',
              'Implemented state management solutions (Provider, Bloc)',
              'Integrated REST APIs and third-party services',
              'Collaborated with clients to deliver high-quality applications',
              'Maintained and optimized existing applications',
            ],
          ),
          const SizedBox(height: 20),
          _buildExperienceItem(
            theme,
            'Web Developer',
            'Freelance',
            '2022 - Present',
            [
              'Built responsive web applications using modern technologies',
              'Developed e-commerce platforms and business websites',
              'Implemented user authentication and database management',
              'Started building backend services in 2024 and continuously improving',
              'Optimized website performance and SEO',
              'Collaborated with clients to deliver high-quality web solutions',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(
    ThemeData theme,
    String title,
    String company,
    String period,
    List<String> responsibilities,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth > 1200
        ? 20.0
        : screenWidth < 768
            ? 12.0
            : 16.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? theme.colorScheme.surface.withOpacity(0.6)
            : theme.colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  period,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...responsibilities.map((responsibility) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        responsibility,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildEducationSection(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1200;
    final padding = isLargeScreen
        ? 28.0
        : screenWidth < 768
            ? 20.0
            : 24.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? theme.colorScheme.surface.withOpacity(0.9)
            : theme.colorScheme.surface.withOpacity(0.95),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.school,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Education',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildEducationItem(
            theme,
            'Bachelor of Science in Mathematics',
            'University of Nairobi',
            'Sep 2016 - Sep 2023',
            'Graduated with honors in Mathematics, specializing in Probability Theory.',
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(
    ThemeData theme,
    String degree,
    String institution,
    String period,
    String description,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth > 1200
        ? 20.0
        : screenWidth < 768
            ? 12.0
            : 16.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? theme.colorScheme.surface.withOpacity(0.6)
            : theme.colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  degree,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  period,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            institution,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1200;
    final padding = isLargeScreen
        ? 28.0
        : screenWidth < 768
            ? 20.0
            : 24.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? theme.colorScheme.surface.withOpacity(0.9)
            : theme.colorScheme.surface.withOpacity(0.95),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Skills & Expertise',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSkillCategory(theme, 'Programming Languages',
              ['Dart', 'Python', 'JavaScript', 'Go', 'SQL']),
          const SizedBox(height: 16),
          _buildSkillCategory(theme, 'Frameworks & Tools',
              ['Flutter', 'Django', 'Git', 'Linux', 'Docker']),
          const SizedBox(height: 16),
          _buildSkillCategory(theme, 'Soft Skills', [
            'Problem Solving',
            'Team Collaboration',
            'Communication',
            'Time Management'
          ]),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
      ThemeData theme, String category, List<String> skills) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills
              .map((skill) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? theme.colorScheme.primary.withOpacity(0.15)
                          : theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: themeProvider.isDarkMode
                              ? Colors.black.withOpacity(0.1)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      skill,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
