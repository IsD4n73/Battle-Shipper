import 'package:flutter/material.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/utils/grid_utils.dart';
import '../../../../domain/entities/ship.dart';

class PlaceGrid extends StatefulWidget {
  List<Ship> ships;
  List<int> placedShips;
  List<int> selectedIndexs;
  int selectedIndex;
  int size;
  PlaceGrid({
    super.key,
    required this.ships,
    required this.placedShips,
    required this.selectedIndexs,
    required this.selectedIndex,
    required this.size,
  });

  @override
  State<PlaceGrid> createState() => _PlaceGridState();
}

class _PlaceGridState extends State<PlaceGrid> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: GridUtils.gridSize * GridUtils.gridSize,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: GridUtils.gridSize,
          ),
          itemBuilder: (context, index) {
            return DragTarget<Ship>(
              onLeave: (data) {
                widget.selectedIndexs = [];
                setState(() {});
              },
              builder: (context, accepted, rejected) {
                if (accepted.isNotEmpty) {
                  widget.selectedIndexs = [];
                  for (int j = 0; j < widget.size; j++) {
                    widget.selectedIndexs.add(index + (GridUtils.gridSize * j));
                  }
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => setState(() {}));
                }
                return Container(
                  decoration: BoxDecoration(
                    color: widget.placedShips.contains(index)
                        ? AppColor.secondaryColor
                        : Colors.transparent,
                    image: widget.placedShips.contains(index)
                        ? DecorationImage(
                            image: AssetImage(
                                "assets/images/ship_${widget.size}_${index + 1}.png"),
                            fit: BoxFit.cover,
                          )
                        : null,
                    border: Border.all(
                      color: widget.selectedIndexs.contains(index)
                          ? AppColor.terziaryColor
                          : widget.placedShips.contains(index)
                              ? AppColor.secondaryColor
                              : AppColor.primaryColor,
                    ),
                  ),
                );
              },
              onAccept: (Ship data) {
                bool flag = false;

                for (int j = 0; j < data.size; j++) {
                  flag = flag ||
                      widget.placedShips
                          .contains(index + (GridUtils.gridSize * j));
                }

                if (!flag) {
                  setState(() {
                    for (int j = 0; j < data.size; j++) {
                      widget.placedShips.add(index + (GridUtils.gridSize * j));
                    }
                    widget.ships.removeAt(widget.selectedIndex);
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }
}
