import 'package:battle_shipper/common/theme/app_color.dart';
import 'package:battle_shipper/common/utils/grid_utils.dart';
import 'package:flutter/material.dart';

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
      ships = List.generate(5, (index) => Ship.create(index));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ships.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 30,
                  height: ships[index].image.height!,
                  child: Draggable<Ship>(
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
                          size = ships[selectedIndex].size;
                        }
                      });
                    },
                    feedback: Opacity(
                      opacity: 0.5,
                      child: SizedBox(
                        height:
                            ((120 * 33) / 100) + 30 * (ships[index].size - 1),
                        child: ships[index].image,
                      ),
                    ),
                    child: SizedBox(
                        height: (ships[index].image.height! * 33) / 100,
                        child: ships[index].image),
                  ),
                );
              },
            ),
          ),
          Expanded(
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
                      selectedIndexs = [];
                      setState(() {});
                    },
                    builder: (context, accepted, rejected) {
                      if (accepted.isNotEmpty) {
                        selectedIndexs = [];
                        for (int j = 0; j < size; j++) {
                          selectedIndexs.add(index + (10 * j));
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
                        flag = flag || placedShips.contains(index + (10 * j));
                      }

                      if (!flag) {
                        setState(() {
                          for (int j = 0; j < data.size; j++) {
                            placedShips.add(index + (10 * j));
                          }
                          ships.removeAt(selectedIndex);
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
