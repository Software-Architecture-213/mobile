import 'package:flutter/material.dart';
import 'package:mobile/viewmodels/brand_viewmodel.dart';
import 'package:provider/provider.dart';
import '../constant/deal_card.dart';
import '../constant/menu_item.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[100],
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
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Favorite Promotions",
                style: TextStyle(
                  fontSize: 20,
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
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: dealCard(
                              context,
                              promotion.imageUrl!,
                              promotion.name,
                              promotion.description ?? '',
                              "Thu thập",
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }


}
