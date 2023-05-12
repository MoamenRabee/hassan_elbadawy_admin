import 'package:flutter/material.dart';

Widget homeCard({
  required IconData icon,
  required String title,
  required String count,
}) {
  return Container(
    width: 200,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    margin: const EdgeInsets.only(left: 10, bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 2),
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Icon(
          icon,
          size: 30,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              count,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
