import 'package:flutter/material.dart';
import 'package:mobile/models/voucher.dart';
import 'package:mobile/viewmodels/brand_viewmodel.dart';
import 'package:mobile/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class VoucherGift extends StatefulWidget {
  @override
  _VoucherGiftState createState() => _VoucherGiftState();
}

class _VoucherGiftState extends State<VoucherGift> {
  Voucher? voucherGift;
  @override
  void initState() {
    super.initState();
    voucherGift = Provider.of<BrandViewModel>(context, listen: false).randomVoucher;
    Provider.of<BrandViewModel>(context, listen: false).createUserVoucher(voucherGift!.id!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              icon:Icon(Icons.arrow_back_outlined), color: Colors.black),
          title: Text(
            'Congratulations!',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),
          )
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(voucherGift!.imageUrl!,
              height: 200,
              width: 300,
              fit: BoxFit.fitWidth,),
            SizedBox(height: 10),
            Text(voucherGift!.code, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
