import 'package:flutter/material.dart';
import 'package:mobile/models/quiz_game.dart';
import 'package:provider/provider.dart';
import '../../models/promotion.dart';
import '../../viewmodels/brand_viewmodel.dart';
import '../../viewmodels/game_viewmodel.dart';
import '../exchange_voucher/exchange_voucher_screen.dart';
import '../game/quiz/quiz_game.dart';
import '../game/shake/shake_game.dart';

class PromotionDetailScreen extends StatefulWidget {
  final Promotion promotion;
  PromotionDetailScreen({required this.promotion});
  @override
  State<StatefulWidget> createState() => _PromotionDetailScreenState();
}

class _PromotionDetailScreenState extends State<PromotionDetailScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BrandViewModel>(context, listen: false).getRandomVoucherByPromotionId(widget.promotion.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Promotion Detail',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Invite Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundImage: AssetImage('assets/people1.png')),
                      SizedBox(width: 8),
                      CircleAvatar(
                          backgroundImage: AssetImage('assets/people4.png')),
                      SizedBox(width: 8),
                      CircleAvatar(
                          backgroundImage: AssetImage('assets/people2.png')),
                      SizedBox(width: 8),
                      Text("+20 Going"),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Invite",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    "Exp date:  ${widget.promotion.endDate.toIso8601String().substring(0, 10)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    "Status:  ${widget.promotion.status}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Related Games',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.promotion.games!.map((game) {
                    return GestureDetector(
                      onTap: () async {
                        if (game.type == 'shake') {
                          // Move to Shake Game
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShakeGameApp(gameId: game.id,),
                            ),
                          );

                        } else if (game.type == 'quiz') {
                          // Call Quiz API
                          await Provider.of<GameViewModel>(context, listen: false).getQuizByGameId(game.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizGameApp(gameId: game.id,),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Card(
                          child: Column(
                            children: [
                              Image.network(
                                game.imageUrl!,
                                width: 200,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(game.name),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Related Vouchers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.promotion.vouchers!.map((voucher) {
                    return Container(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                voucher.imageUrl!,
                                width: 200,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  voucher.description ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Status: " + voucher.type),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),

              // Description Section
              Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                widget.promotion.description ??  "This voucher can be used for discounts on select items. "
                    "Ensure to redeem it before the expiration date.",
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExchangeVoucherScreen(promotion: widget.promotion),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("EXCHANGE VOUCHER",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 14),),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward,color: Colors.black,size: 16,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
