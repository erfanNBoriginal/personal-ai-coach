import 'package:flutter/material.dart';

class ScrollableTabview extends StatelessWidget {
  final List<Widget> pages;

  const ScrollableTabview({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SizedBox(width: 44);
      },
      separatorBuilder: (context, index) {
        return pages[index];
      },
      itemCount: pages.length,
    );
  }
}
