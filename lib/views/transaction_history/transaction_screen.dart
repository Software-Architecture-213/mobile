import 'package:flutter/material.dart';
import 'package:mobile/models/item_transaction.dart';
import 'package:mobile/models/response/user_response.dart';
import 'package:mobile/viewmodels/game_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});
  @override
  State<StatefulWidget> createState() => _TransactionHistoryState();
}
class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  void initState() {
    super.initState();
    UserResponse user = Provider.of<AuthViewModel>(context, listen: false).user!;
    if(user.userId != null){
      Provider.of<GameViewModel>(context, listen: false).getItemTransactionsByUserId(user.userId);
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
        title: const Text('Transaction History', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFFF4D7AB),
      ),
      body: Consumer<GameViewModel>(
          builder: (context, gameViewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${gameViewModel.itemTransactions.length} transaction",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: gameViewModel.itemTransactions.length,
                      itemBuilder: (context, index) {
                        ItemTransaction itemTransaction = gameViewModel.itemTransactions[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Image
                                if (itemTransaction.item?.imageUrl != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      itemTransaction.item!.imageUrl!,
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
                                      if (itemTransaction.item?.name != null)
                                        Text(
                                          "${itemTransaction.item?.name} ",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      if (itemTransaction.senderId != null)
                                        Text(
                                          "Sender ID: ${itemTransaction.senderId}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      const SizedBox(height: 4),
                                      // Piece name
                                      if (itemTransaction.receiverId != null)
                                        Text(
                                          "Receiver ID: ${itemTransaction.receiverId}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      const SizedBox(height: 4),
                                      // Time
                                      if (itemTransaction.createdAt != null)
                                        Text(
                                          "Time: ${itemTransaction.createdAt.toIso8601String().substring(0,10)}",
                                          style: const TextStyle(
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
