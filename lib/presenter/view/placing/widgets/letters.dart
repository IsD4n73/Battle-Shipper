
import 'package:flutter/material.dart';

import '../../../../common/utils/converter.dart';
import '../../../../common/utils/grid_utils.dart';

class Letters extends StatelessWidget {
  const Letters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          width: 10,
        ),
        ...List.generate(GridUtils.gridSize,
                (index) => Text(Converter.indexToLetter(index))),
      ],
    );
  }
}
