import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/product_page_controller.dart';
import 'package:shop_app/models/sneakers_model.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/shared/new_shoes.dart';
import 'package:shop_app/views/shared/product_card.dart';
import 'package:shop_app/views/ui/product_by_card.dart';
import 'package:shop_app/views/ui/product_page.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> sneaker,
    required this.tabIndex,
  }) : _sneaker = sneaker;

  final Future<List<Sneakers>> _sneaker;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifierProvider = Provider.of<ProductNotifierProvider>(context);
    return Column(
      children: [
        SizedBox(height: 3),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: FutureBuilder<List<Sneakers>>(
            future: _sneaker,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Data Found'));
              } else {
                final sneakers = snapshot.data;
                return ListView.builder(
                  itemCount: sneakers!.length,
                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context, index) {
                    final shoe = sneakers[index];
                    return GestureDetector(
                      onTap: () {
                        productNotifierProvider.shoeSizes = shoe.sizes;
                        //print(productNotifierProvider.shoeSizes);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              id: shoe.id,
                              category: shoe.category,
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        name: shoe.name,
                        category: shoe.category,
                        image: shoe.imageUrl[0],
                        price: shoe.price,
                        id: shoe.id,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductByCard(tabIndex: tabIndex),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Latest Shoes',
                      style: appstyle(22, FontWeight.bold, Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          'View All',
                          style: appstyle(22, FontWeight.w500, Colors.black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 22,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          child: FutureBuilder<List<Sneakers>>(
            future: _sneaker,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Data Found'));
              } else {
                final menSneaker = snapshot.data;
                return ListView.builder(
                  itemCount: menSneaker!.length,
                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context, index) {
                    final sneaker = menSneaker[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewShoes(imageUrl: sneaker.imageUrl[1]),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
