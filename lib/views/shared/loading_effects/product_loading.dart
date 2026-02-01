import '../export_packages.dart';
import 'loading_component.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (_, __) => Padding(
        padding: EdgeInsets.fromLTRB(8.w, 0, 20.w, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            width: 0.6.sw,
            decoration: BoxDecoration(
              color: Colors.white,
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
                /// IMAGE
                LoadingComponent(width: double.infinity, height: 0.23.sh),

                SizedBox(height: 8.h),

                /// NAME + CATEGORY
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingComponent(width: 0.45.sw, height: 18.h),
                      SizedBox(height: 6.h),
                      LoadingComponent(width: 0.30.sw, height: 14.h),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),

                /// PRICE + COLOR
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoadingComponent(width: 0.20.sw, height: 18.h),
                      Row(
                        children: [
                          LoadingComponent(width: 0.18.sw, height: 14.h),
                          SizedBox(width: 6.w),
                          ClipOval(
                            child: LoadingComponent(width: 24.w, height: 24.h),
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
      ),
    );
  }
}
