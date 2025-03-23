import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';

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

  //late final WebViewController webViewController;

  // @override
  // void initState() {
  //   super.initState();
  //   webViewController = WebViewController()
  //     ..loadRequest(Uri.parse(
  //         'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15955.251031229525!2d36.8164896!3d-1.2863898!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x182f10b70baf66e1%3A0x4c2e0d1a3f59a7ff!2sNairobi!5e0!3m2!1sen!2ske!4v1699986123456'));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark Theme Background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Embedded Google Map (Nairobi)
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(16),
            //   child: SizedBox(
            //     height: 250,
            //     child: WebViewWidget(controller: webViewController),
            //   ),
            // ),
            // const SizedBox(height: 20),

            // Contact Form
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
                  ContactTextField(
                      controller: nameController, hint: 'Full Name'),
                  ContactTextField(
                      controller: emailController, hint: 'Email Address'),
                  ContactTextField(
                      controller: subjectController, hint: 'Subject'),
                  ContactTextField(
                      controller: messageController,
                      hint: 'Your Message',
                      maxLines: 4),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                    ),
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text(
                      'Send Message',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission logic
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
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
      {super.key,
      required this.controller,
      required this.hint,
      this.maxLines = 1});

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
        validator: (value) =>
            value!.isEmpty ? 'This field cannot be empty' : null,
      ),
    );
  }
}
