import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

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
        SizedBox(height: 3.h),
        SizedBox(
          height: 0.40.sh,
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
              padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 20.h),
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
                    ReusableText(
                      text: 'Latest Shoes',
                      style: appstyle(22.sp, FontWeight.bold, Colors.black),
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: 'View All',
                          style: appstyle(22.sp, FontWeight.w500, Colors.black),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 22.sp,
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
          height: 0.13.sh,
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
                      padding: EdgeInsets.all(8.w),
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
