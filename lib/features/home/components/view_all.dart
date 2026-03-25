import 'package:flutter/material.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            child: Text(
              "View all",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
