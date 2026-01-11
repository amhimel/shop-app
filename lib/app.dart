

import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp(
          title: 'Shop App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Mainscreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
