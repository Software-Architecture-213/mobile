import 'package:flutter/material.dart';
import 'package:mobile/views/favourite_promotion/favourite_screen.dart';
import 'package:mobile/views/home/widgets/bottom_navigation_custom.dart';
import 'package:mobile/views/home/widgets/campaign_card.dart';
import 'package:mobile/views/home/widgets/invite_card.dart';
import 'package:mobile/views/home/widgets/section_header.dart';
import 'package:mobile/views/profile/profile_screen.dart';
import 'package:mobile/views/voucher/voucher_screen.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/brand_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BrandViewModel>(context, listen: false).getAllBrands();
    Provider.of<BrandViewModel>(context, listen: false).getAllPromotions();
    Provider.of<BrandViewModel>(context, listen: false).getAllVouchers();
  }
  Widget build(BuildContext context) {
    int selectedBottomNavigation = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
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
      body: SingleChildScrollView(
        child: Column(
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
                  buildSectionHeader(context,'Promotions', 'See all', 'promotion'),
                  SizedBox(height: 5),
                  Consumer<BrandViewModel>(
                    builder: (context, brandViewModel, child) {
                      if (brandViewModel.isLoadingPromotion) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: brandViewModel.promotions.map((promotion) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: buildCampaignCard(
                                promotion.name,
                                promotion.description ?? '',
                                promotion.status,
                                promotion.imageUrl!,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  buildInviteCard(),
                  SizedBox(height: 10),
                  buildSectionHeader(context,'Vouchers', 'See all', 'voucher'),
                  SizedBox(height: 10),
                  Consumer<BrandViewModel>(
                    builder: (context, brandViewModel, child) {
                      if (brandViewModel.isLoadingVoucher) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: brandViewModel.vouchers.map((voucher) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: buildCampaignCard(
                                voucher.code,
                                voucher.description ?? '',
                                voucher.status,
                                voucher.imageUrl!,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  buildSectionHeader(context,'Brands', 'See all', 'brand'),
                  SizedBox(height: 10),
                  Consumer<BrandViewModel>(
                    builder: (context, brandViewModel, child) {
                      if (brandViewModel.isLoadingBrand) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: brandViewModel.brands.map((brand) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: buildCampaignCard(
                                brand.displayName,
                                brand.field,
                                brand.status,
                                brand.imageUrl!,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: selectedBottomNavigation,
        onTap: (index) {
          _onTap(index);
        },
      ),
    );
  }
  void _onTap(int index) {
    if(index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()),
      );
    }else if(index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VoucherScreen()),
      );
    }
    else if(index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FavouriteScreen()),
      );
    }
    else if(index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen()),
      );
    }
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


}
