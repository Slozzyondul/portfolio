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

class _PortfolioScreenState extends State<PortfolioScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    AboutScreen(),
    ResumeScreen(),
    ProjectsScreen(),
    BlogScreen(),
    ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        backgroundColor: Color(0xFF1E1E1E),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: _buildTab("About", 0)),
            Expanded(child: _buildTab("Resume", 1)),
            Expanded(child: _buildTab("Projects", 2)),
            Expanded(child: _buildTab("Blog", 3)),
            Expanded(child: _buildTab("Contact", 4)),
          ],
        ),
        elevation: 10,
      ),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildTab(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {  
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.amber : Colors.white70,
              fontWeight:
                  _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
            overflow: TextOverflow.fade,
          ),
        ),
      ),
    );
  }
}
