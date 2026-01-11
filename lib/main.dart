import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("cart_box");
  await Hive.openBox("fav_box");
  runApp(
    //method that initialize app
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainScreenNotifierProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ProductNotifierProvider()),
        ChangeNotifierProvider(
          create: (context) => FavoritesProviderNotifier(),
        ),
        ChangeNotifierProvider(create: (context) => CartProviderNotifier()),
      ],
      child: MyApp(),
    ),
  );
}
