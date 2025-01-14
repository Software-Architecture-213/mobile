import 'package:flutter/material.dart';
import 'package:mobile/models/voucher.dart';
import 'package:mobile/views/constant/game_screen.dart';

class VoucherDetailScreen extends StatelessWidget {
  final Voucher voucher;

  VoucherDetailScreen({required this.voucher});
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
          'Voucher Detail',
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

              // Coupon Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'COUPON',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'SAVE ${voucher.value}%',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Code: ${voucher.code}',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          height: 50,
                          width: 100,
                          child: Center(child: Text('QR Code',style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Remaining Voucher Info
              Row(
                children: [
                  Icon(Icons.videogame_asset, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    "Remain Voucher: ${voucher.createdCounts}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    "Exp date: ${voucher.expiredAt.toIso8601String().substring(0,10)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Related Voucher Section
              Text(
                'Related Voucher',
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
                            child: Text(
                              "Starbucks Meeting",
                            ),
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
                voucher.description ??  "This voucher can be used for discounts on select items. "
                    "Ensure to redeem it before the expiration date.",
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameButtonsScreen( voucher: voucher,),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Play Game",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 14),),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward,color: Colors.black,size: 16,),
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
