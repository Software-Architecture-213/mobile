import 'package:flutter/material.dart';

Widget dealCard(BuildContext context,String imageUrl, String title, String description, String buttonText) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Container(
      width: MediaQuery.of(context).size.width *0.95,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                imageUrl,
                height: 100,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,

                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(description,maxLines: 3,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 8),

                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text(buttonText,style: TextStyle(color: Colors.black),),
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
    ),
  );
}