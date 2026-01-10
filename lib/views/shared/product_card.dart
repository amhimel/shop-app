import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/favorites_provider.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/ui/favorites.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.id,
  });
  final String name;
  final String category;
  final String image;
  final String price;
  final String id;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final _favBox = Hive.box('fav_box');

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesProviderNotifier>(
      context,
      listen: true,
    );
    favoritesNotifier.getFavorite();
    bool selected = true;
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (favoritesNotifier.ids.contains(widget.id)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritesPage(),
                            ),
                          );
                        } else {
                          favoritesNotifier.createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image,
                          });

                          setState(() {});
                        }
                      },
                      child: favoritesNotifier.ids.contains(widget.id)
                          ? Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.red,
                              size: 24,
                            )
                          : Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        widget.name,
                        style: appstyleWithHT(
                          30,
                          FontWeight.bold,
                          Colors.black,
                          1.1,
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      widget.category,
                      style: appstyleWithHT(
                        20,
                        FontWeight.bold,
                        Colors.grey,
                        1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${widget.price}',
                      style: appstyle(25, FontWeight.bold, Colors.black),
                    ),
                    const SizedBox(width: 5),
                    Row(
                      children: [
                        Text(
                          'Colors',
                          style: appstyle(18, FontWeight.w500, Colors.grey),
                        ),
                        const SizedBox(width: 5),
                        ClipOval(
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ChoiceChip(
                              label: Text(''),
                              selected: selected,
                              visualDensity: VisualDensity.compact,
                              selectedColor: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
