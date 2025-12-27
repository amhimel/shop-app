import 'package:flutter/material.dart';
import 'package:shop_app/models/sneakers_model.dart';
import 'package:shop_app/services/helper.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/shared/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
              child: Container(
                padding: EdgeInsets.only(left: 8, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Athletic Shoes',
                      style: appstyleWithHT(
                        40,
                        FontWeight.bold,
                        Colors.white,
                        1.4,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Collections',
                      style: appstyleWithHT(
                        30,
                        FontWeight.bold,
                        Colors.white,
                        1.2,
                      ),
                    ),

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
            ),

            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.25,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(sneaker: _menSneaker),
                    HomeWidget(sneaker: _womenSneaker),
                    HomeWidget(sneaker: _kidsSneaker),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
