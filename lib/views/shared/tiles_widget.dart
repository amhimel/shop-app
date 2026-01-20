import '../shared/export_packages.dart';

class TilesWidget extends StatelessWidget {
  final String title;
  final IconData leading;
  final VoidCallback onTap;

  const TilesWidget({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        leading,
        color: Colors.grey.shade700,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: title != "Settings"
          ? const Icon(
        AntDesign.right,
        size: 14,
      )
          : SvgPicture.asset(
        "assets/images/bng.svg",
        width: 15,
        height: 20,
      ),
    );
  }
}
