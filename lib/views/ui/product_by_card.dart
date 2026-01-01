import 'package:flutter/material.dart';
import 'package:shop_app/models/sneakers_model.dart';
import 'package:shop_app/services/helper.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/shared/category_btn.dart';
import 'package:shop_app/views/shared/custom_spacer.dart';
import 'package:shop_app/views/shared/latest_shoes_widget.dart';

class ProductByCard extends StatefulWidget {
  const ProductByCard({super.key});

  @override
  State<ProductByCard> createState() => _ProductByCardState();
}

class _ProductByCardState extends State<ProductByCard>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  late Future<List<Sneakers>> _menSneaker;
  late Future<List<Sneakers>> _womenSneaker;
  late Future<List<Sneakers>> _kidsSneaker;

  void getMaleSneaker() {
    _menSneaker = Helper().getMenSneakers();
  }

  void getFemaleSneaker() {
    _womenSneaker = Helper().getWomenSneakers();
  }

  void getKidsSneaker() {
    _kidsSneaker = Helper().getKidSneakers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMaleSneaker();
    getFemaleSneaker();
    getKidsSneaker();
  }

  List<String> brand = [
    "assets/images/adidas.jpg",
    'assets/images/gucci.jpg',
    'assets/images/jordan.jpg',
    'assets/images/nike.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/top_image.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: Icon(Icons.tune, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  //tab bar
                  TabBar(
                    padding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.white,
                    labelStyle: appstyle(24, FontWeight.bold, Colors.white),
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'Men Shoes'),
                      Tab(text: 'Women Shoes'),
                      Tab(text: 'Kids Shoes'),
                    ],
                  ),
                ],
              ),
            ),

            // Tab bar view
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.185,
                left: 16,
                right: 12,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LatestShoes(sneaker: _menSneaker),
                    LatestShoes(sneaker: _womenSneaker),
                    LatestShoes(sneaker: _kidsSneaker),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double value = 100.0;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.82,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text(
                    'Filter',
                    style: appstyle(40, FontWeight.bold, Colors.black),
                  ),
                  CustomSpacer(),
                  Text(
                    'Gender',
                    style: appstyle(20, FontWeight.bold, Colors.black),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: const [
                      CategoryBtn(btnColor: Colors.black, label: 'Men'),
                      CategoryBtn(btnColor: Colors.grey, label: 'Women'),
                      CategoryBtn(btnColor: Colors.grey, label: 'Kids'),
                    ],
                  ),
                  CustomSpacer(),
                  Text(
                    'Category',
                    style: appstyle(20, FontWeight.w600, Colors.black),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CategoryBtn(btnColor: Colors.black, label: 'Shoes'),
                      CategoryBtn(btnColor: Colors.grey, label: 'Apparrels'),
                      CategoryBtn(btnColor: Colors.grey, label: 'Accessories'),
                    ],
                  ),
                  CustomSpacer(),
                  Text(
                    'Price',
                    style: appstyle(20, FontWeight.w600, Colors.black),
                  ),
                  SizedBox(height: 10,),
                  Slider(
                    value: value,
                    activeColor: Colors.black,
                    thumbColor: Colors.black,
                    inactiveColor: Colors.grey,
                    max: 500,
                    divisions: 50,
                    label: value.toString(),
                    onChanged: (double value) {},
                  ),
                  
                  Text(
                    'Brand',
                    style: appstyle(20, FontWeight.w600, Colors.black),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: brand.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Image.asset(
                              brand[index],
                              height: 60,
                              width: 70,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
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
