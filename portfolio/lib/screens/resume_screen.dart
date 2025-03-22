import 'package:flutter/material.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle('Profile'),
            sectionContent(
                'Mathematics and technology enthusiast with strong problem-solving skills, analytical thinking, and a passion for developing scalable digital solutions. Experienced in building and maintaining applications, integrating payment APIs, and optimizing database performance. Always eager to learn, innovate, and contribute to fintech advancements.'),
            sectionTitle('Skills & Competencies'),
            sectionContent(
                '• Programming Languages: Dart (Flutter), Python, JavaScript, and Golang\n'
                '• Database Management: SQL (MySQL, MariaDB) – Querying, Optimization, and Design\n'
                '• Version Control: Git, GitHub, Bitbucket\n'
                '• Operating Systems: Arch Linux, Windows\n'
                '• Fintech & Payment Integration: M-Pesa Daraja API, Mobile Money Systems, and Stripe\n'
                '• Software Development: API Development, Backend-Frontend Integration'),
            sectionTitle('Experience'),
            sectionContent(
                'Flutter Developer | Fintech & Open-Source Projects\n'
                '• Developed an e-commerce application using Flutter & Flask, integrating M-Pesa Daraja API for seamless transactions between customers and website backend.\n'
                '• Managed GitHub and Bitbucket repositories, ensuring version control best practices and collaborative development.'),
            sectionTitle('Education'),
            sectionContent(
                'University of Nairobi – BSc Mathematics (Second Class Lower) (Sep 2023)\n'
                'Aga Khan High School – KCSE: B+ (Nov 2015)'),
            sectionTitle('Languages'),
            sectionContent('• English (Fluent)\n• Swahili (Fluent)'),
            sectionTitle('Additional Information'),
            sectionContent(
                '• Passionate about fintech solutions, AI in financial modeling, and automation in digital payments.\n'
                '• Actively contributing to open-source projects on GitHub.\n'
                '• Enthusiastic about using technology to improve financial inclusion in Africa.'),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
      ),
    );
  }

  Widget sectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
    );
  }
}
