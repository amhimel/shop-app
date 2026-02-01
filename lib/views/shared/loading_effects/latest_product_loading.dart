import '../export_packages.dart';
import 'loading_component.dart';

class LatestProductLoading extends StatelessWidget {
  const LatestProductLoading({super.key});

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
            width: 0.30.sw,
            height: 0.14.sh,
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
            child: LoadingComponent(width: 0.30.sw, height: 0.14.sh),
          ),
        ),
      ),
    );
  }
}
