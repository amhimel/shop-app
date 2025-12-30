import 'package:flutter/material.dart';
import 'package:shop_app/models/sneakers_model.dart';
import 'package:shop_app/services/helper.dart';
import 'package:shop_app/views/shared/appstyle.dart';
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
                          onTap: () {},
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
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.82,
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
                  CustomSpacer(),
                  Text(
                    'Filter',
                    style: appstyle(40, FontWeight.bold, Colors.black),
                  ),
                  CustomSpacer(),
                  Text(
                    'Gender',
                    style: appstyle(20, FontWeight.bold, Colors.black),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
