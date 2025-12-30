import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/views/shared/appstyle.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });
  final String name;
  final String price;
  final String imageUrl;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.175,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              padding: EdgeInsets.only(top: 12),
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: appstyleWithHT(20, FontWeight.w700, Colors.black, 1),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$${widget.price}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appstyleWithHT(20, FontWeight.w500, Colors.black, 1),
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
