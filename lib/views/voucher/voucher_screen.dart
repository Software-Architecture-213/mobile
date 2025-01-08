import 'package:flutter/material.dart';
import 'package:mobile/viewmodels/brand_viewmodel.dart';
import 'package:provider/provider.dart';

import '../constant/deal_card.dart';
import '../constant/menu_item.dart';
import '../voucher_detail/voucher_detail_screen.dart';

class VoucherScreen extends StatelessWidget {
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
            SizedBox(height: 8),
            //Menu options
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8,right: 8),
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
                       if (brandViewModel.isLoadingVoucher) {
                         return Center(child: CircularProgressIndicator());
                       }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: brandViewModel.vouchers.map((voucher) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VoucherDetailPage(voucher: voucher,),
                                    ),
                                  );
                                },
                                child: dealCard(context, voucher.imageUrl!, voucher.code, voucher.description ?? '', "Thu thập"));
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
