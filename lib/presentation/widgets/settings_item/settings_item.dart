import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final VoidCallback onClick;
  final String text;

  const SettingsItem({super.key, required this.onClick, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Color(0xFFCAC4D0),
            width: 1,
          ),
        ),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).cardColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleSmall
            ),
            Icon(
              Icons.navigate_next,
              color: Color(0xFFCAC4D0),
              size: 30,
            ),
          ],
        )
      ),
    );
  }
}
