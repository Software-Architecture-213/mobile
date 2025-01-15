import 'package:flutter/material.dart';
import 'package:mobile/viewmodels/brand_viewmodel.dart';
import 'package:provider/provider.dart';
import '../constant/deal_card.dart';
import '../constant/menu_item.dart';
import '../promotion_detail/promotion_detail_screen.dart';

class PromotionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF1DFC7),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 8.0,right: 8,left: 8),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_outlined,size: 26,),
              color: Colors.black),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Tìm kiếm ưu đãi...",
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.notifications, color: Colors.black,size: 26,),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            Container(
              padding: EdgeInsets.all(16),
              color:Color(0xFFF1DFC7),
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
              color: Color(0xFFF1DFC7),
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
                  Consumer<BrandViewModel>(
                      builder: (context, brandViewModel, child) {
                      if (brandViewModel.isLoadingPromotion) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: brandViewModel.promotions.map((promotion) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PromotionDetailScreen(promotion: promotion),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: dealCard(
                                  context,
                                  promotion.imageUrl!,
                                  promotion.name,
                                  promotion.description ?? '',
                                  "Thu thập",
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
