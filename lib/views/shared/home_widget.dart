import 'package:flutter/material.dart';
import 'package:shop_app/models/sneakers_model.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/shared/new_shoes.dart';
import 'package:shop_app/views/shared/product_card.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required Future<List<Sneakers>> sneaker})
    : _menSneaker = sneaker;

  final Future<List<Sneakers>> _menSneaker;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 3),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: FutureBuilder<List<Sneakers>>(
            future: _menSneaker,
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
                    return ProductCard(
                      name: sneaker.name,
                      category: sneaker.category,
                      image: sneaker.imageUrl[0],
                      price: sneaker.price,
                      id: sneaker.id,
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
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          child: FutureBuilder<List<Sneakers>>(
            future: _menSneaker,
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
