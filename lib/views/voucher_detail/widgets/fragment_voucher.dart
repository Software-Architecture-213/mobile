import 'package:flutter/material.dart';
import 'package:mobile/views/constant/bottom_sheet.dart';
class PuzzleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Puzzle Game',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.brown.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 cột
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: 9, // Tổng cộng 9 mảnh
            itemBuilder: (context, index) {
              // // Mảnh trống ở vị trí index = 4
              // if (index == 4) {
              //   return Container(
              //     color: Colors.brown.shade100, // Màu nền của mảnh trống
              //   );
              // }
              return GestureDetector(
                onTap: () {
                  // Xử lý khi người dùng chọn mảnh
                  showPuzzleBottomSheet(context, index);
                },
                child: ClipRect(
                  child: Image.asset(
                    'assets/kfc.jpg', // Thay thế bằng đường dẫn ảnh của bạn
                    fit: BoxFit.cover,
                    alignment: _calculateAlignment(index),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Hàm tính toán vị trí của từng mảnh trong ảnh lớn
  Alignment _calculateAlignment(int index) {
    // Xác định hàng và cột
    int row = index ~/ 3; // Hàng (0, 1, 2)
    int col = index % 3; // Cột (0, 1, 2)

    // Tính toán alignment dựa trên hàng và cột
    return Alignment(
      (col - 1) * 1.0, // -1, 0, 1
      (row - 1) * 1.0, // -1, 0, 1
    );
  }
}
