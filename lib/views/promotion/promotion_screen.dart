import 'package:flutter/material.dart';

class PromotionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
              icon: Icon(Icons.arrow_back_outlined),
              color: Colors.black),
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: "Tìm kiếm ưu đãi...",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          Icon(Icons.notifications, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.pink[50],
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tiệc deal cuối năm",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Các ưu đãi hấp dẫn dành cho bạn",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tặng thêm đến 900 Xu",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "50%",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Menu options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  menuOption(Icons.percent, "Nhập mã"),
                  menuOption(Icons.card_giftcard, "Quà của bạn"),
                  menuOption(Icons.money, "Thanh toán"),
                  menuOption(Icons.star, "VOU Rewards"),
                  menuOption(Icons.location_on, "Thổ địa VOU"),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Deals
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              color: Colors.pink[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chớt nắm thêm nghìn deal ngon!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dealCard(
                          context,
                          "assets/kfc.jpg",
                            "Cà phê muối Chú Long", "Ưu đãi 30%", "Thu thập"),
                        dealCard(context,"assets/kfc.jpg","Tiệm bánh Liha", "Giảm 30%", "Thu thập"),
                        dealCard(
                          context,
                            "assets/kfc.jpg",
                            "Cà phê muối Chú Long", "Ưu đãi 30%", "Thu thập"),
                        dealCard(
                          context,
                            "assets/kfc.jpg",
                            "Cà phê muối Chú Long", "Ưu đãi 30%", "Thu thập"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget menuOption(IconData icon, String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.pink[50],
          child: Icon(icon, color: Colors.pink),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget dealCard(BuildContext context,String imageUrl, String title, String subtitle, String buttonText) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width *0.9,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  imageUrl,
                  height: 100,
                  width: 100,
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
                    Text(subtitle),
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

}
