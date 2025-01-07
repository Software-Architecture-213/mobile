import 'package:flutter/material.dart';

Widget buildCampaignItem(String title, String date, String imageUrl) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl), // Replace with your assets
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(date),
    ),
  );
}