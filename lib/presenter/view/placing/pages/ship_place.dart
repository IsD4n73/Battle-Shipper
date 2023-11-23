import 'package:battle_shipper/common/utils/enums.dart';
import 'package:battle_shipper/presenter/view/widget/battle_ship_continue_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../common/theme/app_color.dart';
import '../../../../common/utils/grid_utils.dart';
import '../../../../domain/entities/ship.dart';

class DraggableShip extends StatefulWidget {
  const DraggableShip({super.key});

  @override
  State<DraggableShip> createState() => _DraggableShipState();
}

class _DraggableShipState extends State<DraggableShip> {
  List<Ship> ships = [];
  List<int> placedShips = [];
  int selectedIndex = 0;
  int size = 0;
  List<int> selectedIndexs = [];

  @override
  void initState() {
    setState(() {
      ships = List.generate(7, (index) => Ship.create(index));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place your ships").tr(),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  ships.length,
                  (index) => Draggable<Ship>(
                    onDragCompleted: () {
                      selectedIndexs = [];
                      setState(() {});
                    },
                    data: ships[index],
                    dragAnchorStrategy: pointerDragAnchorStrategy,
                    onDragStarted: () {
                      setState(() {
                        selectedIndex = index;
                        if (ships.isNotEmpty) {
                          size = ships[index].size;
                        }
                      });
                    },
                    feedback: Opacity(
                      opacity: 0.5,
                      child: RotatedBox(
                        quarterTurns: ships[index].isVertical ? 0 : 1,
                        child: SizedBox(
                          height:
                              ((120 * 33) / 100) + 30 * (ships[index].size - 1),
                          child: ships[index].image,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          ships[index].isVertical = !ships[index].isVertical;
                        });
                      },
                      child: RotatedBox(
                        quarterTurns: ships[index].isVertical ? 0 : 1,
                        child: SizedBox(
                          height:
                              ((120 * 33) / 100) + 30 * (ships[index].size - 1),
                          child: ships[index].image,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: GridUtils.gridSize * GridUtils.gridSize,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: GridUtils.gridSize,
              ),
              itemBuilder: (context, index) {
                return DragTarget<Ship>(
                  onLeave: (data) {
                    selectedIndexs = [];
                    setState(() {});
                  },
                  onWillAccept: (data) {
                    bool flag = false;

                    if (data == null) {
                      return flag;
                    }

                    if (data.isVertical) {
                      for (int j = 0; j < size; j++) {
                        if (index + (GridUtils.gridSize * j) > 99) {
                          return flag;
                        }
                      }
                    } else {
                      for (int j = 0; j < size; j++) {
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
                            placedShips
                                .contains(index + (GridUtils.gridSize * j));
                      } else {
                        flag = flag || placedShips.contains(index + (1 * j));
                      }
                    }

                    return !flag;
                  },
                  builder: (context, accepted, rejected) {
                    if (accepted.isNotEmpty) {
                      for (int j = 0; j < size; j++) {
                        int cell = ships[selectedIndex].isVertical
                            ? index + (GridUtils.gridSize * j)
                            : index + (1 * j);
                        selectedIndexs.add(cell);
                      }
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => setState(() {}));
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: placedShips.contains(index)
                            ? AppColor.secondaryColor
                            : Colors.transparent,
                        border: Border.all(
                          color: selectedIndexs.contains(index)
                              ? AppColor.terziaryColor
                              : placedShips.contains(index)
                                  ? AppColor.secondaryColor
                                  : AppColor.primaryColor,
                        ),
                      ),
                    );
                  },
                  onAccept: (Ship data) {
                    bool flag = false;

                    for (int j = 0; j < data.size; j++) {
                      if (data.isVertical) {
                        flag = flag ||
                            placedShips
                                .contains(index + (GridUtils.gridSize * j));
                      } else {
                        flag = flag || placedShips.contains(index + (1 * j));
                      }
                    }

                    if (!flag) {
                      setState(() {
                        for (int j = 0; j < data.size; j++) {
                          if (data.isVertical) {
                            placedShips.add(index + (GridUtils.gridSize * j));
                          } else {
                            placedShips.add(index + (1 * j));
                          }
                        }
                        ships.removeAt(selectedIndex);
                      });
                    }
                  },
                );
              },
            ),
          ),
          BattleShipContinueButton(
            text: "Continue".tr(),
            buttonType: BattleShipButtonType.dark,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
