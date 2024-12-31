import 'package:flutter/material.dart';
import 'package:mobile/views/home/widgets/bottom_navigation_custom.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current locations',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            Text(
              'Store 1, 260/61, An Duong Vuong, Ho Chi Minh City, Vietnam',
              style: TextStyle(fontSize: 16, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications, color: Colors.white),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '5',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search People & Places',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryButton('Restaurant', Icons.restaurant, Colors.green),
                _buildCategoryButton('Car', Icons.directions_car, Colors.blue),
                _buildCategoryButton('Shopping', Icons.shopping_bag, Colors.yellow),
                _buildCategoryButton('...', Icons.more_horiz, Colors.purple),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Newest Campaigns', 'See all'),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCampaignCard('Sale 8/8', 'Nha Trang, Khanh Hoa', '20 Going', Icons.favorite),
                    SizedBox(width: 8),
                    _buildCampaignCard('Starbucks', 'Hanoi', '15 Going', Icons.favorite),
                    SizedBox(width: 8),
                    _buildCampaignCard('Starbucks', 'Hanoi', '15 Going', Icons.favorite),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildInviteCard(),
            ],
                      ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
      currentIndex: 0,
      onTap: (index) {

      },
    ),
    );
  }

  Widget _buildCategoryButton(String label, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            TextButton(onPressed: () {}, child: Text(actionText,style: TextStyle(color: Colors.black,fontSize: 16),)),
            Icon(Icons.arrow_forward, size: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildCampaignCard(String title, String location, String status, IconData icon) {
    return Container(
      width: 200,
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
                image: AssetImage('assets/starbucks.png'), // Replace with your image
                fit: BoxFit.cover,
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
                Icon(Icons.location_on, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Expanded(child: Text(location, style: TextStyle(fontSize: 12, color: Colors.grey))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(icon, size: 14, color: Colors.red),
                SizedBox(width: 4),
                Text(status, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInviteCard() {
    return Container(
      height: 170,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Invite your friends', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Get \$20 for ticket'),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            child: Text('INVITE'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
}
