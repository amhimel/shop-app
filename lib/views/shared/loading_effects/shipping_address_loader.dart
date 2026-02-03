import '../export_packages.dart';
import 'loading_component.dart';

class ShippingAddressLoader extends StatelessWidget {
  const ShippingAddressLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.fromLTRB(8.w, 0, 20.w, 0),
          child: Container(
            height: 85.h,
            width: 360.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  /// 📍 Icon shimmer
                  LoadingComponent(width: 34, height: 34),

                  SizedBox(width: 10.w),

                  /// 📄 Address text shimmer
                  LoadingComponent(width: 0.55.sw, height: 16),

                  SizedBox(width: 8.w),

                  /// ✏️ Edit icon shimmer
                  LoadingComponent(width: 18, height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
