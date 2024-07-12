import 'package:flutter/material.dart';
import '../../../utils/styles.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.itemName,
    this.onTap,
    this.leading,
  });

  final String itemName;
  final Function()? onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: Text(
              itemName,
              style: AppStyles.tsFS16C00W400,
            ),
            leading: leading ?? const SizedBox(),
            onTap: onTap),
        const Divider(),
      ],
    );
  }
}
