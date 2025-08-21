import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:portfolio/methods/contact_info.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

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
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _startAnimations() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Thank you for your message! I\'ll get back to you soon.'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive breakpoints
    final isMobile = screenWidth < 768;
    final isSmallPhone = screenWidth < 400;
    final isVerySmallPhone = screenWidth < 320;

    // Responsive padding
    final horizontalPadding = isVerySmallPhone
        ? 12.0
        : isSmallPhone
            ? 16.0
            : isMobile
                ? 20.0
                : 24.0;

    final verticalPadding = isVerySmallPhone
        ? 16.0
        : isSmallPhone
            ? 20.0
            : isMobile
                ? 24.0
                : 24.0;

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
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: isMobile
                  ? _buildMobileLayout(theme, isSmallPhone, isVerySmallPhone)
                  : _buildDesktopLayout(theme),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      ThemeData theme, bool isSmallPhone, bool isVerySmallPhone) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          _buildMobileHeader(theme, isSmallPhone, isVerySmallPhone),
          SizedBox(height: isVerySmallPhone ? 16 : 24),

          // Contact Info
          _buildContactInfo(theme, isSmallPhone, isVerySmallPhone),
          SizedBox(height: isVerySmallPhone ? 16 : 24),

          // Contact Form
          _buildContactForm(theme, isSmallPhone, isVerySmallPhone),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Side - Contact Info
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildHeader(theme),
              const SizedBox(height: 32),
              _buildContactInfo(theme, false, false),
            ],
          ),
        ),
        const SizedBox(width: 48),

        // Right Side - Contact Form
        Expanded(
          flex: 2,
          child: _buildContactForm(theme, false, false),
        ),
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get In Touch',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Let\'s discuss your next project or just say hello!',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader(
      ThemeData theme, bool isSmallPhone, bool isVerySmallPhone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Get In Touch',
          style: (isVerySmallPhone
                  ? theme.textTheme.headlineMedium
                  : isSmallPhone
                      ? theme.textTheme.headlineSmall
                      : theme.textTheme.displaySmall)
              ?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isVerySmallPhone ? 4 : 8),
        Text(
          'Let\'s discuss your next project or just say hello!',
          style: (isVerySmallPhone
                  ? theme.textTheme.bodyMedium
                  : theme.textTheme.bodyLarge)
              ?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContactInfo(
      ThemeData theme, bool isSmallPhone, bool isVerySmallPhone) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final containerPadding = isVerySmallPhone
        ? 16.0
        : isSmallPhone
            ? 20.0
            : 24.0;

    final borderRadius = isVerySmallPhone ? 12.0 : 20.0;

    return Container(
      padding: EdgeInsets.all(containerPadding),
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
        borderRadius: BorderRadius.circular(borderRadius),
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
            'Contact Information',
            style: (isVerySmallPhone
                    ? theme.textTheme.titleLarge
                    : theme.textTheme.headlineSmall)
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isVerySmallPhone ? 16 : 20),
          ContactInfo(
            icon: Icons.email,
            text: 'solomonondula@gmail.com',
            onTap: () => _launchEmail('solomonondula@gmail.com'),
          ),
          SizedBox(height: isVerySmallPhone ? 8 : 12),
          ContactInfo(
            icon: Icons.phone,
            text: '+254 792352745',
            onTap: () => _launchPhone('+254792352745'),
          ),
          SizedBox(height: isVerySmallPhone ? 8 : 12),
          ContactInfo(
            icon: Icons.location_on,
            text: 'Nairobi, Kenya',
          ),
          SizedBox(height: isVerySmallPhone ? 8 : 12),
          ContactInfo(
            icon: Icons.link,
            text: "LinkedIn Profile",
            onTap: () => _launchURL(
                'https://www.linkedin.com/in/solomon-ondula-4993471a7/'),
          ),
          SizedBox(height: isVerySmallPhone ? 16 : 24),

          // Social Links
          Text(
            'Follow Me',
            style: (isVerySmallPhone
                    ? theme.textTheme.titleSmall
                    : theme.textTheme.titleMedium)
                ?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: isVerySmallPhone ? 12 : 16),
          _buildSocialButtons(theme, isSmallPhone, isVerySmallPhone),
        ],
      ),
    );
  }

  Widget _buildSocialButtons(
      ThemeData theme, bool isSmallPhone, bool isVerySmallPhone) {
    if (isVerySmallPhone) {
      // Stack buttons vertically on very small screens
      return Column(
        children: [
          _buildSocialButton(
            icon: Icons.link,
            label: 'LinkedIn',
            onTap: () => _launchURL(
                'https://www.linkedin.com/in/solomon-ondula-4993471a7/'),
            theme: theme,
            isSmallPhone: isSmallPhone,
            isVerySmallPhone: isVerySmallPhone,
          ),
          SizedBox(height: isVerySmallPhone ? 8 : 12),
          _buildSocialButton(
            icon: Icons.code,
            label: 'GitHub',
            onTap: () => _launchURL('https://github.com/slozzyondul'),
            theme: theme,
            isSmallPhone: isSmallPhone,
            isVerySmallPhone: isVerySmallPhone,
          ),
        ],
      );
    } else {
      // Use row layout for larger screens
      return Row(
        children: [
          Expanded(
            child: _buildSocialButton(
              icon: Icons.link,
              label: 'LinkedIn',
              onTap: () => _launchURL(
                  'https://www.linkedin.com/in/solomon-ondula-4993471a7/'),
              theme: theme,
              isSmallPhone: isSmallPhone,
              isVerySmallPhone: isVerySmallPhone,
            ),
          ),
          SizedBox(width: isSmallPhone ? 8 : 12),
          Expanded(
            child: _buildSocialButton(
              icon: Icons.code,
              label: 'GitHub',
              onTap: () => _launchURL('https://github.com/slozzyondul'),
              theme: theme,
              isSmallPhone: isSmallPhone,
              isVerySmallPhone: isVerySmallPhone,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ThemeData theme,
    required bool isSmallPhone,
    required bool isVerySmallPhone,
  }) {
    final padding = isVerySmallPhone
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
        : isSmallPhone
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 10)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    final borderRadius = isVerySmallPhone ? 8.0 : 12.0;
    final iconSize = isVerySmallPhone ? 16.0 : 18.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: theme.colorScheme.primary,
              size: iconSize,
            ),
            SizedBox(width: isVerySmallPhone ? 6 : 8),
            Flexible(
              child: Text(
                label,
                style: (isVerySmallPhone
                        ? theme.textTheme.bodySmall
                        : theme.textTheme.bodyMedium)
                    ?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(
      ThemeData theme, bool isSmallPhone, bool isVerySmallPhone) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final containerPadding = isVerySmallPhone
        ? 16.0
        : isSmallPhone
            ? 20.0
            : 24.0;

    final borderRadius = isVerySmallPhone ? 12.0 : 20.0;
    final fieldSpacing = isVerySmallPhone ? 12.0 : 16.0;

    return Container(
      padding: EdgeInsets.all(containerPadding),
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
        borderRadius: BorderRadius.circular(borderRadius),
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Message',
              style: (isVerySmallPhone
                      ? theme.textTheme.titleLarge
                      : theme.textTheme.headlineSmall)
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isVerySmallPhone ? 16 : 24),

            // Name Field
            _buildTextField(
              controller: _nameController,
              label: 'Your Name',
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              theme: theme,
              isSmallPhone: isSmallPhone,
              isVerySmallPhone: isVerySmallPhone,
            ),
            SizedBox(height: fieldSpacing),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              theme: theme,
              isSmallPhone: isSmallPhone,
              isVerySmallPhone: isVerySmallPhone,
            ),
            SizedBox(height: fieldSpacing),

            // Subject Field
            _buildTextField(
              controller: _subjectController,
              label: 'Subject',
              icon: Icons.subject,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
              theme: theme,
              isSmallPhone: isSmallPhone,
              isVerySmallPhone: isVerySmallPhone,
            ),
            SizedBox(height: fieldSpacing),

            // Message Field
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              icon: Icons.message,
              maxLines: isVerySmallPhone ? 4 : 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
              theme: theme,
              isSmallPhone: isSmallPhone,
              isVerySmallPhone: isVerySmallPhone,
            ),
            SizedBox(height: isVerySmallPhone ? 16 : 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: Icon(Icons.send, size: isVerySmallPhone ? 18 : 24),
                label: Text(
                  'Send Message',
                  style: TextStyle(
                    fontSize: isVerySmallPhone ? 14 : 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: isVerySmallPhone ? 12 : 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    required ThemeData theme,
    required bool isSmallPhone,
    required bool isVerySmallPhone,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final borderRadius = isVerySmallPhone ? 8.0 : 12.0;
    final iconSize = isVerySmallPhone ? 20.0 : 24.0;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: (isVerySmallPhone
          ? theme.textTheme.bodyMedium
          : theme.textTheme.bodyLarge),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon:
            Icon(icon, color: theme.colorScheme.primary, size: iconSize),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface.withOpacity(0.5),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isVerySmallPhone ? 12 : 16,
          vertical: isVerySmallPhone ? 12 : 16,
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
