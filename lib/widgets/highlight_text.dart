import 'package:flutter/material.dart';

Widget highlightText(String text, String query) {
  if (query.isEmpty) {
    return Text(text);
  }

  final lowerText = text.toLowerCase();
  final lowerQuery = query.toLowerCase();

  if (!lowerText.contains(lowerQuery)) {
    return Text(text);
  }

  final startIndex = lowerText.indexOf(lowerQuery);
  final endIndex = startIndex + lowerQuery.length;

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text.substring(0, startIndex),
          style: const TextStyle(color: Colors.white),
        ),
        TextSpan(
          text: text.substring(startIndex, endIndex),
          style: const TextStyle(
            color: Colors.black,
            backgroundColor: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: text.substring(endIndex),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
