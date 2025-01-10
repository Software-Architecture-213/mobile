import 'package:flutter/material.dart';
import '../../../constant/app_constant.dart';
import '../../../services/promotion_service.dart';

class PromotionCard extends StatefulWidget {
  final String promotionId;
  final String title;
  final String field;
  final String status;
  final String image;

  PromotionCard({
    required this.promotionId,
    required this.title,
    required this.field,
    required this.status,
    required this.image,
  });

  @override
  _PromotionCardState createState() => _PromotionCardState();
}

class _PromotionCardState extends State<PromotionCard> {
  final promotionService = PromotionService();
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: widget.image.isNotEmpty
                      ? NetworkImage(widget.image)
                      : NetworkImage(defaultImageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(Icons.category, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Expanded(child: Text(
                      widget.field,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4.0, bottom: 8.0),
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.red),
                  SizedBox(width: 4),
                  Text(
                      widget.status,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: isFavourite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () async {
                      try {
                        await promotionService.addFavourite(widget.promotionId);
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added to favourites')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add to favourites')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}