import 'package:shop_app/views/shared/export_packages.dart';

class BottmNavWidget extends StatelessWidget {
  const BottmNavWidget({super.key, this.onTap, this.icon});

  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
