import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/brand_viewmodel.dart';

class CampaignPage extends StatefulWidget {
  CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  void initState() {
    super.initState();
    _fetchBrands();
  }

  void _fetchBrands() async {
    final brandViewModel = Provider.of<BrandViewModel>(context, listen: false);
    await brandViewModel.getAllBrands();
  }

  @override
  Widget build(BuildContext context) {
    final brandViewModel = Provider.of<BrandViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaigns", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Places",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Tab buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryButton('Food', Colors.red),
                _buildCategoryButton('Music', Colors.orange),
                _buildCategoryButton('Restaurant', Colors.green),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Campaigns List
          Expanded(
            child: brandViewModel.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: brandViewModel.brands.length,
              itemBuilder: (context, index) {
                final brand = brandViewModel.brands[index];
                return _buildCampaignItem(
                  brand.displayName,
                  brand.field,
                  brand.imageUrl!, // Replace with appropriate image
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String title, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCampaignItem(String title, String date, String imageUrl) {
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
}