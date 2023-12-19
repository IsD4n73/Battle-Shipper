import 'package:flutter/material.dart';

class Numbers extends StatelessWidget {
  const Numbers({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 10,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 2, crossAxisCount: 1),
        itemBuilder: (context, index) =>
            Center(child: Text((index + 1).toString())),
      ),
    );
  }
}
