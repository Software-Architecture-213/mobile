  import 'package:flutter/material.dart';
import 'package:mobile/models/user_voucher.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/brand_viewmodel.dart';

class MyVoucherScreen extends StatefulWidget {
  const MyVoucherScreen({super.key});
  @override
  State<StatefulWidget> createState() => _MyVoucherScreenState();
}
class _MyVoucherScreenState extends State<MyVoucherScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BrandViewModel>(context, listen: false).getAllMyVouchers();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:Icon(Icons.arrow_back_outlined), color: Colors.black),
        title: const Text('My Vouchers', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFFF4D7AB),
      ),
      body: Consumer<BrandViewModel>(
        builder: (context, brandViewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    brandViewModel.myVouchers.length.toString() + " voucher",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: brandViewModel.myVouchers.length,
                    itemBuilder: (context, index) {
                      UserVoucher voucher = brandViewModel.myVouchers[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  voucher.voucher.imageUrl!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Text content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title + email
                                    Text(
                                    "${voucher.voucher.type} ",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      voucher.voucher.description.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Piece name
                                    Text(
                                      "Code: " + voucher.voucher.code.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Time
                                    Text(
                                      "Status: " + voucher.voucher.status,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
