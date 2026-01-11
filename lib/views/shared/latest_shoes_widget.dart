import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({super.key, required Future<List<Sneakers>> sneaker})
    : _sneaker = sneaker;

  final Future<List<Sneakers>> _sneaker;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
      future: _sneaker,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Data Found'));
        } else {
          final sneaker = snapshot.data;
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 20.w,
            itemCount: sneaker!.length,
            scrollDirection: Axis.vertical,

            staggeredTileBuilder: (index) => StaggeredTile.extent(
              (index % 2 == 0) ? 1 : 1,
              (index % 4 == 1 || index % 4 == 3) ? 0.35.sh : 0.30.sh,
            ),
            itemBuilder: (context, index) {
              final shoes = snapshot.data![index];
              return StaggerTile(
                imageUrl: shoes.imageUrl[1],
                name: shoes.name,
                price: shoes.price,
              );
            },
          );
        }
      },
    );
  }
}
