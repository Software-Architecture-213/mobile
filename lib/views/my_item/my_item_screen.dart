import 'package:flutter/material.dart';
import 'package:mobile/models/item_user.dart';
import 'package:mobile/models/response/user_response.dart';
import 'package:mobile/viewmodels/game_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../constant/bottom_sheet.dart';

class MyItemScreen extends StatefulWidget {
  const MyItemScreen({super.key});
  @override
  State<StatefulWidget> createState() => _MyItemScreenState();
}
class _MyItemScreenState extends State<MyItemScreen> {
  @override
  void initState() {
    super.initState();
    UserResponse user = Provider.of<AuthViewModel>(context, listen: false).user!;
    if(user.userId != null){
      Provider.of<GameViewModel>(context, listen: false).getItemsByUserId(user.userId);
    }
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
        title: const Text('My items', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFFF4D7AB),
      ),
      body: Consumer<GameViewModel>(
          builder: (context, gameViewModel, child) {
            return GestureDetector(
              onTap: () {
                showPuzzleBottomSheet(context, 1);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${gameViewModel.items.length} item",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: gameViewModel.items.length,
                        itemBuilder: (context, index) {
                          ItemUser item = gameViewModel.items[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Image
                                  if (item.item?.imageUrl != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item.item!.imageUrl!,
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
                                        if (item.item?.name != null)
                                          Text(
                                            "${item.item?.name} ",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        if (item.item?.description != null)
                                          Text(
                                            item.item!.description.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black87,
                                            ),
                                          ),
                                        const SizedBox(height: 4),
                                        // Piece name
                                        if (item.item?.tradable != null)
                                          Text(
                                            "Tradable: ${item.item!.tradable}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        const SizedBox(height: 4),
                                        // Time
                                        if (item.item?.rarity != null)
                                          Text(
                                            "Rarity: ${item.item!.rarity}",
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
              ),
            );
          }
      ),
    );
  }
}
