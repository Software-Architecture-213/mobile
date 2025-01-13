import 'package:flutter/material.dart';
import 'package:mobile/models/response/user_response.dart';
import 'package:provider/provider.dart';
import '../../models/promotion.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/brand_viewmodel.dart';

class ExchangeVoucherScreen extends StatefulWidget {
  final Promotion promotion;
  ExchangeVoucherScreen({required this.promotion});
  @override
  State<StatefulWidget> createState() => _ExchangeVoucherScreenState();
}

class _ExchangeVoucherScreenState extends State<ExchangeVoucherScreen> {
  UserResponse? user;
  bool canExchangeVoucher = false;
  @override
  void initState() {
    super.initState();
    user = Provider.of<AuthViewModel>(context, listen: false).user!;
    _initializeData();
  }
  Future<void> _initializeData() async {
    await Future.wait([
      Provider.of<BrandViewModel>(context, listen: false).getConversionRuleByPromotionId(widget.promotion.id),
      Provider.of<BrandViewModel>(context, listen: false).getItemUsersByUserIdAndPromotionId(user!.userId, widget.promotion.id),
    ]);
    canExchangeVoucher = Provider.of<BrandViewModel>(context, listen: false).canExchangeVoucher();
    print('canExchangeVoucher: $canExchangeVoucher');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Exchange Voucher',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Consumer<BrandViewModel>(
        builder: (context, brandViewModel, child) {
          final conversionRule = brandViewModel.conversionRule;
          if (conversionRule == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: conversionRule.requiredItems.isEmpty
                    ? Center(child: Text('No items available'))
                    : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: conversionRule.requiredItems.length,
                  itemBuilder: (context, index) {
                    if (index >= brandViewModel.items.length) {
                      return Center(child: Text('Invalid item index'));
                    }
                    final item = brandViewModel.items[index];
                    return GestureDetector(
                      onTap: () {
                        //showShareBottomSheet(context, item.item!);
                      },
                      child: item.item?.imageUrl == null
                          ? ClipRect(
                        child: Image.asset(
                          'assets/starbucks.png',
                          fit: BoxFit.fitWidth,
                          alignment: _calculateAlignment(index),
                        ),
                      )
                          : ClipRect(
                        child: Image.network(
                          item.item!.imageUrl!,
                          fit: BoxFit.fitWidth,
                          alignment: _calculateAlignment(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: canExchangeVoucher ? () {
                        String? voucherId = brandViewModel.conversionRule!.voucher.id;
                        List<String> itemIds = brandViewModel.items.map((item) => item.id).toList();
                        Provider.of<BrandViewModel>(context, listen: false).createUserVoucher(voucherId!);
                        Provider.of<BrandViewModel>(context, listen: false).deleteItemUserByUserIdAndListItemId(user!.userId, itemIds);
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Exchange Voucher",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14),),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward,color: Colors.white,size: 16,),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Alignment _calculateAlignment(int index) {
    int row = index ~/ 3;
    int col = index % 3;
    return Alignment(
      (col - 1) * 1.0,
      (row - 1) * 1.0,
    );
  }
}