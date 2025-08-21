import 'package:flutter/material.dart';
import 'package:portfolio/screens/about_screen.dart';
import 'package:portfolio/screens/blog_screen.dart';
import 'package:portfolio/screens/contact_screen.dart';
import 'package:portfolio/screens/projects_screen.dart';
import 'package:portfolio/screens/resume_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Widget> _screens = [
    const AboutScreen(),
    const ResumeScreen(),
    const ProjectsScreen(),
    const BlogScreen(),
    const ContactScreen(),
  ];

  final List<String> _tabTitles = [
    'About',
    'Resume',
    'Projects',
    'Blog',
    'Contact',
  ];

  final List<IconData> _tabIcons = [
    Icons.person,
    Icons.description,
    Icons.work,
    Icons.article,
    Icons.contact_mail,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0A0A0A),
              const Color(0xFF1E1B4B),
              const Color(0xFF312E81),
              const Color(0xFF0A0A0A),
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Modern Navigation Bar
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 32,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Logo/Name
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.secondary,
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.code,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.secondary,
                            ],
                          ).createShader(bounds),
                          child: Text(
                            'Solomon Ondula',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Navigation Tabs
                  if (!isMobile) ...[
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _tabTitles.length,
                          (index) => _buildDesktopTab(index, theme),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _screens[_selectedIndex],
              ),
            ),
          ],
        ),
      ),
      // Mobile Bottom Navigation
      bottomNavigationBar: isMobile
          ? Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      _tabTitles.length,
                      (index) => Flexible(
                        child: _buildMobileTab(index, theme),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildDesktopTab(int index, ThemeData theme) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTabChanged(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.2)
              : Colors.transparent,
          border: isSelected
              ? Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _tabIcons[index],
              color: isSelected ? theme.colorScheme.primary : Colors.white70,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              _tabTitles[index],
              style: theme.textTheme.titleMedium?.copyWith(
                color: isSelected ? theme.colorScheme.primary : Colors.white70,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileTab(int index, ThemeData theme) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTabChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _tabIcons[index],
              color: isSelected ? theme.colorScheme.primary : Colors.white70,
              size: 18,
            ),
            const SizedBox(height: 2),
            Text(
              _tabTitles[index],
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected ? theme.colorScheme.primary : Colors.white70,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
