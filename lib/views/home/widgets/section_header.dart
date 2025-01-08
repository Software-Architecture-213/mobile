import 'package:flutter/material.dart';
import 'package:mobile/views/promotion/promotion_screen.dart';
import 'package:mobile/views/voucher/voucher_screen.dart';

import '../../brand/brand_screen.dart';


Widget buildSectionHeader(BuildContext context, String title, String actionText, String type) {
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
            if(type == 'branch'){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CampaignPage()),
              );
            }
            else if(type == 'promotion'){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PromotionPage()),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VoucherScreen()),
              );
            }
          }, child: Text(actionText,style: TextStyle(color: Colors.black,fontSize: 16),)),
          Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    ],
  );
}