


import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class ProductByCard extends StatefulWidget {
  const ProductByCard({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCard> createState() => _ProductByCardState();
}

class _ProductByCardState extends State<ProductByCard>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Initialize the futures once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productNotifier = Provider.of<ProductNotifierProvider>(
        context,
        listen: false,
      );
      productNotifier.getMaleSneaker();
      productNotifier.getFemaleSneaker();
      productNotifier.getKidsSneaker();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    "assets/images/adidas.jpg",
    'assets/images/gucci.jpg',
    'assets/images/jordan.jpg',
    'assets/images/nike.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifierProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: SizedBox(
        height: 1.sh,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
              height: 0.45.sh,
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
                    padding: EdgeInsets.fromLTRB(6.w, 12.h, 16.w, 18.h),
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
                    labelStyle: appstyle(24.sp, FontWeight.bold, Colors.white),
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
              padding: EdgeInsets.only(top: 0.185.sh, left: 16.w, right: 12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LatestShoes(sneaker: productNotifier.menSneaker),
                    LatestShoes(sneaker: productNotifier.womenSneaker),
                    LatestShoes(sneaker: productNotifier.kidsSneaker),
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
        height: 0.82.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              height: 5.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
            ),
            SizedBox(
              height: 0.70.sh,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'Filter',
                    style: appstyle(40.sp, FontWeight.bold, Colors.black),
                  ),
                  CustomSpacer(),
                  Text(
                    'Gender',
                    style: appstyle(20.sp, FontWeight.bold, Colors.black),
                  ),
                  SizedBox(height: 10.h),
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
                    style: appstyle(20.sp, FontWeight.w600, Colors.black),
                  ),
                  SizedBox(height: 10.h),
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
                    style: appstyle(20.sp, FontWeight.w600, Colors.black),
                  ),
                  SizedBox(height: 10.h),
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
                    style: appstyle(20.sp, FontWeight.w600, Colors.black),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: brand.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.r),
                              ),
                            ),
                            child: Image.asset(
                              brand[index],
                              height: 60.h,
                              width: 70.w,
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
