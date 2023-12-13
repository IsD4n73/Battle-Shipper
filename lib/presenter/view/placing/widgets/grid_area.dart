import 'package:flutter/material.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/utils/grid_utils.dart';
import '../../../../domain/entities/index_info.dart';
import '../../../../domain/entities/ship.dart';
import '../pages/placing_page.dart';
import 'letters.dart';
import 'numbers.dart';

class GridArea extends StatefulWidget {
  int selectedIndex;
  List<int> selectedIndexs;
  List<Ship> ships;
  List<IndexInfo> placedIndexs;

  GridArea({
    super.key,
    required this.selectedIndexs,
    required this.selectedIndex,
    required this.ships,
    required this.placedIndexs,
  });

  @override
  State<GridArea> createState() => _GridAreaState();
}

class _GridAreaState extends State<GridArea> {
  @override
  Widget build(BuildContext context) {
    double gridWidth = MediaQuery.of(context).size.height / 2;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: gridWidth,
        child: Column(
          children: [
            const Letters(),
            const SizedBox(height: 5),
            Row(
              children: [
                const Numbers(),
                Flexible(
                  flex: 10,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: GridUtils.gridSize * GridUtils.gridSize,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: GridUtils.gridSize,
                    ),
                    itemBuilder: (context, index) {
                      var ancestralState =
                          context.findAncestorStateOfType<PlacingPageState>();
                      return DragTarget<Ship>(
                        onMove: (details) {},
                        onLeave: (data) {
                          setState(() {
                            widget.selectedIndexs.clear();
                          });
                        },
                        onWillAccept: (data) {
                          bool flag = false;

                          if (data == null) {
                            return flag;
                          }

                          if (data.isVertical) {
                            for (int j = 0; j < ancestralState!.size; j++) {
                              if (index + (GridUtils.gridSize * j) > 99) {
                                return flag;
                              }
                            }
                          } else {
                            for (int j = 0; j < ancestralState!.size; j++) {
                              if (index + (1 * j) >=
                                  ((index / GridUtils.gridSize) + 1).toInt() *
                                      GridUtils.gridSize) {
                                return flag;
                              }
                            }
                          }

                          for (int j = 0; j < data.size; j++) {
                            if (data.isVertical) {
                              flag = flag ||
                                  widget.placedIndexs.any((e) =>
                                      e.index ==
                                      index + (GridUtils.gridSize * j));
                            } else {
                              flag = flag ||
                                  widget.placedIndexs
                                      .any((e) => e.index == index + (1 * j));
                            }
                          }

                          return !flag;
                        },
                        builder: (context, accepted, rejected) {
                          if (ancestralState != null) {
                            if (accepted.isNotEmpty && accepted.first is Ship) {
                              for (int j = 0; j < ancestralState.size; j++) {
                                int cell;
                                if (ancestralState.shipTmp != null) {
                                  cell = ancestralState.shipTmp!.isVertical
                                      ? index + (GridUtils.gridSize * j)
                                      : index + (1 * j);
                                } else {
                                  cell = 0;
                                }
                                widget.selectedIndexs.add(cell);
                              }
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) => setState(() {}));
                            }
                          }

                          if (widget.placedIndexs
                              .any((e) => e.index == index)) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              child: RotatedBox(
                                quarterTurns: widget
                                        .placedIndexs[GridUtils.getIndex(
                                            index, widget.placedIndexs)]
                                        .ship
                                        .isVertical
                                    ? 0
                                    : 3,
                                child: Image.asset(
                                    "assets/images/ship_${widget.placedIndexs[GridUtils.getIndex(index, widget.placedIndexs)].ship.size}_${widget.placedIndexs[GridUtils.getIndex(index, widget.placedIndexs)].position}.png"),
                              ),
                            );
                          }

                          return Container(
                            decoration: BoxDecoration(
                              color: widget.placedIndexs.any(
                                (e) => e.index == index,
                              )
                                  ? AppColor.secondaryColor
                                  : Colors.transparent,
                              border: Border.all(
                                color: widget.selectedIndexs.contains(index)
                                    ? AppColor.terziaryColor
                                    : widget.placedIndexs.any(
                                        (e) => e.index == index,
                                      )
                                        ? AppColor.secondaryColor
                                        : AppColor.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: Text(index.toString(),
                                  style: TextStyle(color: Colors.grey[500])),
                            ),
                          );
                        },
                        onAccept: (Ship data) {
                          setState(() {
                            for (int j = 0; j < data.size; j++) {
                              if (data.isVertical) {
                                widget.placedIndexs.add(IndexInfo(data,
                                    index + (GridUtils.gridSize * j), j + 1));
                              } else {
                                widget.placedIndexs.add(
                                    IndexInfo(data, index + (1 * j), j + 1));
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
