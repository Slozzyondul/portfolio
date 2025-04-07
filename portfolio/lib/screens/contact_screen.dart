

import 'package:emailjs/emailjs.dart' as EmailJS;
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Future<void> sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await EmailJS.send(
        'service_15c0npb', 
        'template_gy6yfm1', 
        {
          'user_name': nameController.text,
          'user_email': emailController.text,
          'user_subject': subjectController.text,
          'user_message': messageController.text,
        },
        EmailJS.Options(
          publicKey: '-oOcIrl2yEOUrDR2G', 
          privateKey: 'your_private_key', // If required
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Message sent successfully! We'll get back to you."),
          backgroundColor: Colors.green,
        ),
      );

      // Clear input fields after successful send
      nameController.clear();
      emailController.clear();
      subjectController.clear();
      messageController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send message: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Get in Touch',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
        
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ContactTextField(controller: nameController, hint: 'Full Name'),
                    ContactTextField(controller: emailController, hint: 'Email Address'),
                    ContactTextField(controller: subjectController, hint: 'Subject'),
                    ContactTextField(controller: messageController, hint: 'Your Message', maxLines: 4),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      ),
                      icon: const Icon(Icons.send, color: Colors.white),
                      label: const Text(
                        'Send Message',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: sendEmail,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Contact Text Field Widget
class ContactTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  const ContactTextField(
      {super.key, required this.controller, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.black45,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value!.isEmpty ? 'This field cannot be empty' : null,
      ),
    );
  }
}
