import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });
  final String name;
  final String price;
  final String imageUrl;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
              height: 0.175.sh,
              width: 1.sw,
            ),
            Container(
              padding: EdgeInsets.only(top: 12.h),
              height: 70.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: widget.name,
                    style: appstyleWithHT(
                      20.sp,
                      FontWeight.w700,
                      Colors.black,
                      1,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  ReusableText(
                    text: '\$${widget.price}',
                    style: appstyleWithHT(
                      20.sp,
                      FontWeight.w500,
                      Colors.black,
                      1,
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
