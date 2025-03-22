import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
