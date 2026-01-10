import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/favorites_provider.dart';
import 'package:shop_app/controllers/product_page_controller.dart';
import 'package:shop_app/models/sneakers_model.dart';
import 'package:shop_app/services/helper.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/shared/check_out_btn.dart';
import 'package:shop_app/views/ui/favorites.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  final _cartBox = Hive.box("cart_box");
  final _favBox = Hive.box('fav_box');
  late Future<Sneakers> _sneaker;

  //get data
  void getShoes() {
    if (widget.category == "Men's Shoes") {
      _sneaker = Helper().getMenSneakersByIds(widget.id);
    } else if (widget.category == "Women's Shoes") {
      _sneaker = Helper().getWomenSneakersByIds(widget.id);
    } else {
      _sneaker = Helper().getKidSneakersByIds(widget.id);
    }
  }

  // hive for local DB create cart
  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesProviderNotifier>(
      context,
      listen: true,
    );
    favoritesNotifier.getFavorite();
    return Scaffold(
      body: FutureBuilder<Sneakers>(
        future: _sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No Data Found'));
          } else {
            final sneakers = snapshot.data;
            return Consumer<ProductNotifierProvider>(
              builder: (context, productNotifierProvider, child) {
                return CustomScrollView(
                  //scrollDirection: Axis.vertical,
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                productNotifierProvider.shoeSizes.clear();
                              },
                              child: Icon(Ionicons.close, color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: Icon(
                                Ionicons.ellipsis_horizontal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              // iamge slider for detail page
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneakers!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  //use provider
                                  productNotifierProvider.activePage = page;
                                },
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.39,
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneakers.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                            0.1,
                                        right: 20,
                                        child: Consumer<FavoritesProviderNotifier>(
                                          builder:
                                              (
                                                context,
                                                favoritesProviderNotifier,
                                                child,
                                              ) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (favoritesProviderNotifier
                                                        .ids
                                                        .contains(widget.id)) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FavoritesPage(),
                                                        ),
                                                      );
                                                    } else {
                                                      favoritesNotifier.createFav({
                                                        "id": sneakers.id,
                                                        "name": sneakers.name,
                                                        "category":
                                                            sneakers.category,
                                                        "price": sneakers.price,
                                                        "imageUrl": sneakers
                                                            .imageUrl[0],
                                                      });

                                                      setState(() {});
                                                    }
                                                  },
                                                  child:
                                                      favoritesProviderNotifier
                                                          .ids
                                                          .contains(sneakers.id)
                                                      ? Icon(
                                                          Icons
                                                              .favorite_outline_rounded,
                                                          color: Colors.red,
                                                          size: 24,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .favorite_outline_rounded,
                                                          color: Colors.black,
                                                          size: 24,
                                                        ),
                                                );
                                              },
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneakers.imageUrl.length,
                                            (index) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 4,
                                              ),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    productNotifierProvider
                                                            .activePage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height *
                                      0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneakers.name,
                                            style: appstyle(
                                              40,
                                              FontWeight.bold,
                                              Colors.black,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneakers.category,
                                                style: appstyle(
                                                  20,
                                                  FontWeight.w500,
                                                  Colors.grey,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 1,
                                                    ),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: Colors.black,
                                                    ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${sneakers.price}',
                                                style: appstyle(
                                                  26,
                                                  FontWeight.w600,
                                                  Colors.black,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Colors",
                                                    style: appstyle(
                                                      18,
                                                      FontWeight.w500,
                                                      Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  SizedBox(width: 5),
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Select Sizes',
                                                    style: appstyle(
                                                      20,
                                                      FontWeight.w600,
                                                      Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  Text(
                                                    'View sizes guide',
                                                    style: appstyle(
                                                      20,
                                                      FontWeight.w600,
                                                      Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              //for sizes list
                                              SizedBox(
                                                height: 40,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: EdgeInsets.zero,
                                                  itemCount:
                                                      productNotifierProvider
                                                          .shoeSizes
                                                          .length,
                                                  itemBuilder: (context, index) {
                                                    final sizes =
                                                        productNotifierProvider
                                                            .shoeSizes[index];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: ChoiceChip(
                                                        label: Text(
                                                          sizes['size'],
                                                          style: appstyle(
                                                            18,
                                                            FontWeight.w500,
                                                            sizes['isSelected']
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                        selected:
                                                            sizes['isSelected'],
                                                        selectedColor:
                                                            Colors.black,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              vertical: 8,
                                                            ),
                                                        onSelected: (newState) {
                                                          //add selected size on list
                                                          if (productNotifierProvider
                                                              .sizes
                                                              .contains(
                                                                sizes['size'],
                                                              )) {
                                                            productNotifierProvider
                                                                .sizes
                                                                .remove(
                                                                  sizes['size'],
                                                                );
                                                          } else {
                                                            productNotifierProvider
                                                                .sizes
                                                                .add(
                                                                  sizes['size'],
                                                                );
                                                          }

                                                          print(
                                                            productNotifierProvider
                                                                .sizes,
                                                          );
                                                          productNotifierProvider
                                                              .toggleCheck(
                                                                index,
                                                              );
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                          side: BorderSide(
                                                            color: Colors.black,
                                                            width: 1,
                                                            style: BorderStyle
                                                                .solid,
                                                          ),
                                                        ),
                                                        disabledColor:
                                                            Colors.white,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.black,
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .80,
                                            child: Text(
                                              sneakers.title,
                                              style: appstyle(
                                                20,
                                                FontWeight.w700,
                                                Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            sneakers.description,
                                            style: appstyle(
                                              14,
                                              FontWeight.normal,
                                              Colors.black,
                                            ),
                                            maxLines: 4,
                                          ),
                                          SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: CheckOutButtonWidget(
                                                onTap: () async {
                                                  if (productNotifierProvider
                                                      .sizes
                                                      .isEmpty) {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          "Please select at least one size",
                                                        ),
                                                      ),
                                                    );
                                                    return;
                                                  }
                                                  _createCart({
                                                    "id": sneakers.id,
                                                    "name": sneakers.name,
                                                    "category":
                                                        sneakers.category,
                                                    "sizes": List<String>.from(
                                                      productNotifierProvider
                                                          .sizes,
                                                    ),

                                                    "imageUrl":
                                                        sneakers.imageUrl[0],
                                                    "price": sneakers.price,
                                                    "qty": 1,
                                                  });
                                                  productNotifierProvider.sizes
                                                      .clear();
                                                  Navigator.pop(context);
                                                },
                                                label: 'Add to cart',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
