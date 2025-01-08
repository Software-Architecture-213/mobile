import 'package:flutter/material.dart';

class MyGiftHistory extends StatelessWidget {
  const MyGiftHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final List<Map<String, String>> historyItems = List.generate(
      12,
          (index) => {
        "image": "assets/reward1.png",
        "title": "Bạn vừa nhận một mảnh ghép từ",
        "email": "a@g.com",
        "piece": "piece_${index + 1}",
        "time": index < 2
            ? "Thursday, March 9th 2023, 2:${17 - index}:27 am"
            : "Wednesday, March 8th 2023, 10:23:00 pm",
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gift History'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "12 Items",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  final item = historyItems[index];
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
                            child: Image.asset(
                              item["image"]!,
                              width: 50,
                              height: 50,
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
                                RichText(
                                  text: TextSpan(
                                    text: "${item["title"]} ",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: item["email"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Piece name
                                Text(
                                  item["piece"]!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Time
                                Text(
                                  item["time"]!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
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
      ),
    );
  }
}
