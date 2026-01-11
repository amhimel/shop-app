import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifierProvider>(context);
    productNotifier.getMaleSneaker();
    productNotifier.getFemaleSneaker();
    productNotifier.getKidsSneaker();

    var favoritesNotifier = Provider.of<FavoritesProviderNotifier>(
      context,
      listen: true,
    );
    favoritesNotifier.getFavorite();

    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: SizedBox(
        width: 360.w,
        height: 690.h,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
              height: 350.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/top_image.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 8.w, bottom: 15.h),
                width: 360.w,
                height: 690.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      style: appstyleWithHT(
                        42.w,
                        FontWeight.bold,
                        Colors.white,
                        1.5,
                      ),
                      text: 'Athletic Shoes',
                    ),
                    //SizedBox(height: 5.h),
                    ReusableText(
                      text: 'Collections',
                      style: appstyleWithHT(
                        36.w,
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
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 185.h),
              child: Container(
                padding: EdgeInsets.only(left: 12.w),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(
                      sneaker: productNotifier.menSneaker,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      sneaker: productNotifier.womenSneaker,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      sneaker: productNotifier.kidsSneaker,
                      tabIndex: 2,
                    ),
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
