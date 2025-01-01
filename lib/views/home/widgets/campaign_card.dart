import 'package:flutter/material.dart';
import '../../../constant/app_constant.dart';

Widget buildCampaignCard(String title, String field, String status, String image) {
  return Container(
    width: 200,
    height: 210,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            image: DecorationImage(
              image: image.isNotEmpty
                  ? NetworkImage(image)
                  : NetworkImage(defaultImageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Icon(Icons.category, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              Expanded(child: Text(field, style: TextStyle(fontSize: 12, color: Colors.grey))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.access_time, size: 14, color: Colors.red),
              SizedBox(width: 4),
              Text(status, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    ),
  );
}