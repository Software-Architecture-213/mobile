import 'package:flutter/material.dart';
import 'package:mobile/services/notification.dart';
import 'package:mobile/views/brand/widgets/campaign_item.dart';
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
    _notification();
    _fetchBrands();
  }

  void _notification() async {
    final WebSocketService webSocketService = WebSocketService();
    webSocketService.connectToWebSocket('123');
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
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.black, onPressed: () {
          Navigator.pop(context);
        },),
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
                _buildCategoryButton('All', Colors.red),
                _buildCategoryButton('Food', Colors.yellow),
                _buildCategoryButton('Music', Colors.orange),
                _buildCategoryButton('Restaurant', Colors.green),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Campaigns List
          Expanded(
            child: brandViewModel.isLoadingBrand
                ? Center(child: CircularProgressIndicator())
                : Consumer<BrandViewModel>(
                    builder: (context, itemProvider, child){
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: brandViewModel.brands.length,
                      itemBuilder: (context, index) {
                      final brand = brandViewModel.brands[index];
                      return buildCampaignItem(
                        brand.displayName,
                        brand.field,
                        brand.imageUrl!,
                      );
                    },
                  );
                  }
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


}