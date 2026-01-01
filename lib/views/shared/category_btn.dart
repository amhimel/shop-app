import 'package:flutter/material.dart';
import 'package:shop_app/views/shared/appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    this.onPressed,
    required this.btnColor,
    required this.label,
  });
  final void Function()? onPressed;
  final Color btnColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: btnColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: Center(child: FittedBox(child: Text(label, style: appstyle(20, FontWeight.w600, btnColor)))),
      ),
    );
  }
}
