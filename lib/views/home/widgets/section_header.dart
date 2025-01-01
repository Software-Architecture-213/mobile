import 'package:flutter/material.dart';
import 'package:mobile/views/promotion/promotion_screen.dart';

import '../../branch/branch_screen.dart';

Widget buildSectionHeader(BuildContext context, String title, String actionText, int type) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          TextButton(onPressed: () {
            if(type == 1){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CampaignPage()),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PromotionPage()),
              );
            }
          }, child: Text(actionText,style: TextStyle(color: Colors.black,fontSize: 16),)),
          Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    ],
  );
}