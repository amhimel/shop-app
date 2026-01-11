
import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesProviderNotifier>(
      context,
      listen: true,
    );
    var cartNotifier = Provider.of<CartProviderNotifier>(context, listen: true);
    var productNotifier = Provider.of<ProductNotifierProvider>(context);
    favoritesNotifier.getFavorite();
    productNotifier.getShoes(widget.category, widget.id);
    return Scaffold(
      body: FutureBuilder<Sneakers>(
        future: productNotifier.sneaker,
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
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
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
                      expandedHeight: 1.sh,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: 0.5.sh,
                              width: 1.sw,
                              // image slider for detail page
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
                                        height: 0.39.sh,
                                        width: 1.sw,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneakers.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0.1.sh,
                                        right: 20.w,
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
                                                      favoritesNotifier
                                                          .createFav({
                                                            "id": sneakers.id,
                                                            "name":
                                                                sneakers.name,
                                                            "category": sneakers
                                                                .category,
                                                            "price":
                                                                sneakers.price,
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
                                                          size: 24.sp,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .favorite_outline_rounded,
                                                          color: Colors.black,
                                                          size: 24.sp,
                                                        ),
                                                );
                                              },
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height: 0.3.sh,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneakers.imageUrl.length,
                                            (index) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 4.w,
                                              ),
                                              child: CircleAvatar(
                                                radius: 5.r,
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
                              bottom: 30.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r),
                                ),
                                child: Container(
                                  height: 0.645.sh,
                                  width: 1.sw,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReusableText(
                                            text: sneakers.name,
                                            style: appstyle(
                                              40.sp,
                                              FontWeight.bold,
                                              Colors.black,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              ReusableText(
                                                text: sneakers.category,
                                                style: appstyle(
                                                  20.sp,
                                                  FontWeight.w500,
                                                  Colors.grey,
                                                ),
                                              ),
                                              SizedBox(width: 20.w),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22.sp,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 1.w,
                                                    ),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                      Icons.star,
                                                      size: 18.sp,
                                                      color: Colors.black,
                                                    ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ReusableText(
                                                text: '\$${sneakers.price}',
                                                style: appstyle(
                                                  26.sp,
                                                  FontWeight.w600,
                                                  Colors.black,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ReusableText(
                                                    text: "Colors",
                                                    style: appstyle(
                                                      18.sp,
                                                      FontWeight.w500,
                                                      Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  CircleAvatar(
                                                    radius: 7.r,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  CircleAvatar(
                                                    radius: 7.r,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.h),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  ReusableText(
                                                    text: 'Select Sizes',
                                                    style: appstyle(
                                                      20.sp,
                                                      FontWeight.w600,
                                                      Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w),
                                                  ReusableText(
                                                    text: 'View sizes guide',
                                                    style: appstyle(
                                                      20.sp,
                                                      FontWeight.w600,
                                                      Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10.h),
                                              //for sizes list
                                              SizedBox(
                                                height: 40.h,
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
                                                          EdgeInsets.symmetric(
                                                            horizontal: 8.w,
                                                          ),
                                                      child: ChoiceChip(
                                                        label: ReusableText(
                                                          text: sizes['size'],
                                                          style: appstyle(
                                                            18.sp,
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
                                                              vertical: 8.h,
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
                                                                20.r,
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
                                          SizedBox(height: 10.h),
                                          Divider(
                                            indent: 10.w,
                                            endIndent: 10.w,
                                            color: Colors.black,
                                          ),
                                          SizedBox(height: 10.h),
                                          SizedBox(
                                            width: 0.80.sw,
                                            child: ReusableText(
                                              text: sneakers.title,
                                              style: appstyle(
                                                20.sp,
                                                FontWeight.w700,
                                                Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Text(
                                            sneakers.description,
                                            style: appstyle(
                                              14.sp,
                                              FontWeight.normal,
                                              Colors.black,
                                            ),
                                            maxLines: 4,
                                          ),
                                          SizedBox(height: 10.h),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: 12.h,
                                              ),
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
                                                  cartNotifier.createCart({
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
