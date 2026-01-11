import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.id,
  });
  final String name;
  final String category;
  final String image;
  final String price;
  final String id;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesProviderNotifier>(
      context,
      listen: true,
    );
    favoritesNotifier.getFavorite();
    bool selected = true;
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 20.w, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        child: Container(
          height: 1.sh,
          width: 0.6.sw,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1.w, 1.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 0.23.sh,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: GestureDetector(
                      onTap: () async {
                        if (favoritesNotifier.ids.contains(widget.id)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritesPage(),
                            ),
                          );
                        } else {
                          favoritesNotifier.createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image,
                          });

                          setState(() {});
                        }
                      },
                      child: favoritesNotifier.ids.contains(widget.id)
                          ? Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.red,
                              size: 24.sp,
                            )
                          : Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.black,
                              size: 24.sp,
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: ReusableText(
                        text: widget.name,
                        style: appstyleWithHT(
                          30.sp,
                          FontWeight.bold,
                          Colors.black,
                          1.1,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    ReusableText(
                      text: widget.category,
                      style: appstyleWithHT(
                        20.sp,
                        FontWeight.bold,
                        Colors.grey,
                        1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: '\$${widget.price}',
                      style: appstyle(25.sp, FontWeight.bold, Colors.black),
                    ),
                    SizedBox(width: 5.w),
                    Row(
                      children: [
                        ReusableText(
                          text: 'Colors',
                          style: appstyle(18.sp, FontWeight.w500, Colors.grey),
                        ),
                        SizedBox(width: 5.w),
                        ClipOval(
                          child: Container(
                            height: 25.h,
                            width: 25.w,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ChoiceChip(
                              label: Text(''),
                              selected: selected,
                              visualDensity: VisualDensity.compact,
                              selectedColor: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
