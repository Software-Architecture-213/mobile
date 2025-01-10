import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/promotion.dart';
import '../../viewmodels/brand_viewmodel.dart';

class PromotionDetailScreen extends StatelessWidget {
  final Promotion promotion;

  PromotionDetailScreen({required this.promotion});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Promotion Detail',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Invite Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundImage: AssetImage('assets/people1.png')),
                      SizedBox(width: 8),
                      CircleAvatar(
                          backgroundImage: AssetImage('assets/people4.png')),
                      SizedBox(width: 8),
                      CircleAvatar(
                          backgroundImage: AssetImage('assets/people2.png')),
                      SizedBox(width: 8),
                      Text("+20 Going"),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Invite",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Exp date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                    ),
                    onPressed: () {},
                    child: Text("See others"),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Related Games',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: promotion.games!.map((game) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(
                              game.imageUrl!,
                              width: 200,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(game.name),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Text(
                'Related Vouchers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/starbucks.png',
                            width: 200,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Starbucks Meeting"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Card(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/kfc.jpg',
                            height: 100,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("KFC Master Chef"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Description Section
              Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                promotion.description ??  "This voucher can be used for discounts on select items. "
                    "Ensure to redeem it before the expiration date.",
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Choose Game",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14),),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward,color: Colors.white,size: 16,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
