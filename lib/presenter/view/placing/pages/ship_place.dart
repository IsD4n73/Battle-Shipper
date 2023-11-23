import 'dart:math';

import 'package:battle_shipper/common/utils/converter.dart';
import 'package:battle_shipper/common/utils/enums.dart';
import 'package:battle_shipper/domain/entities/index_info.dart';
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
  List<IndexInfo> placedIndexs = [];
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
    double gridWidth = MediaQuery.of(context).size.height / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place your ships").tr(),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Click on ships to rotate them").tr(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BattleShipContinueButton(
                text: "Reset".tr(),
                buttonType: BattleShipButtonType.dark,
                onPressed: () {
                  setState(() {
                    ships = List.generate(7, (index) => Ship.create(index));
                    placedIndexs = [];
                    selectedIndex = 0;
                    size = 0;
                    selectedIndexs = [];
                  });
                },
              ),
              BattleShipContinueButton(
                text: "Randomize".tr(),
                buttonType: BattleShipButtonType.light,
                onPressed: () {
                  setState(() {
                    placedIndexs = _randomizeShips();
                    ships = [];
                  });
                },
              ),
              BattleShipContinueButton(
                text: "Continue".tr(),
                buttonType: BattleShipButtonType.dark,
                onPressed: ships.isNotEmpty ? null : () {},
              ),
            ],
          ),
          SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Center(
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
                          quarterTurns: ships[index].isVertical ? 0 : 3,
                          child: SizedBox(
                            height: ((120 * 33) / 100) +
                                30 * (ships[index].size - 1),
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
                          quarterTurns: ships[index].isVertical ? 0 : 3,
                          child: SizedBox(
                            height: ((120 * 33) / 100) +
                                30 * (ships[index].size - 1),
                            child: ships[index].image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: gridWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      ...List.generate(GridUtils.gridSize,
                          (index) => Text(Converter.indexToLetter(index))),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
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
                      ),
                      Flexible(
                        flex: 10,
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: GridUtils.gridSize * GridUtils.gridSize,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                        ((index / GridUtils.gridSize) + 1)
                                                .toInt() *
                                            GridUtils.gridSize) {
                                      return flag;
                                    }
                                  }
                                }

                                for (int j = 0; j < data.size; j++) {
                                  if (data.isVertical) {
                                    flag = flag ||
                                        placedIndexs.any((e) =>
                                            e.index ==
                                            index + (GridUtils.gridSize * j));
                                  } else {
                                    flag = flag ||
                                        placedIndexs.any(
                                            (e) => e.index == index + (1 * j));
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
                                  WidgetsBinding.instance.addPostFrameCallback(
                                      (_) => setState(() {}));
                                }
                                if (placedIndexs.any((e) => e.index == index)) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      border: Border.all(
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                    child: RotatedBox(
                                      quarterTurns:
                                          placedIndexs[getIndex(index)]
                                                  .ship
                                                  .isVertical
                                              ? 0
                                              : 3,
                                      child: Image.asset(
                                          "assets/images/ship_${placedIndexs[getIndex(index)].ship.size}_${placedIndexs[getIndex(index)].position}.png"),
                                    ),
                                  );
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    color: placedIndexs.any(
                                      (e) => e.index == index,
                                    )
                                        ? AppColor.secondaryColor
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: selectedIndexs.contains(index)
                                          ? AppColor.terziaryColor
                                          : placedIndexs.any(
                                              (e) => e.index == index,
                                            )
                                              ? AppColor.secondaryColor
                                              : AppColor.primaryColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(index.toString(),
                                        style:
                                            TextStyle(color: Colors.grey[500])),
                                  ),
                                );
                              },
                              onAccept: (Ship data) {
                                setState(() {
                                  for (int j = 0; j < data.size; j++) {
                                    if (data.isVertical) {
                                      placedIndexs.add(IndexInfo(
                                          data,
                                          index + (GridUtils.gridSize * j),
                                          j + 1));
                                    } else {
                                      placedIndexs.add(IndexInfo(
                                          data, index + (1 * j), j + 1));
                                    }
                                  }
                                  ships.removeAt(selectedIndex);
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
          ),
        ],
      ),
    );
  }

  int getIndex(int index) {
    for (int i = 0; i < placedIndexs.length; i++) {
      if (placedIndexs[i].index == index) {
        return i;
      }
    }
    return 0;
  }

  List<IndexInfo> _randomizeShips() {
    print("ENTRATA | Random index: ${placedIndexs}");
    var random = Random();
    placedIndexs = [];
    print("random index pulita");

    //placedIndexs.any((element) => element.index == randomCell)

    var ships = List.generate(
        7, (index) => Ship.create(index)..isVertical = random.nextBool());

    bool flag = false;

    for (Ship ship in ships) {
      List<IndexInfo> list = [];
      flag = false;
      int randomCell;
      bool stopper = false;

      do {
        do {
          randomCell = random.nextInt(99);
          stopper = ship.isVertical
              ? ((randomCell + ((ship.size - 1) * 10)) > 99)
              : ((randomCell + ship.size - 1) >=
                  ((randomCell / GridUtils.gridSize) + 1).toInt() *
                      GridUtils.gridSize);
        } while (stopper);
        list = [];
        for (int i = 0; i < ship.size; i++) {
          if (ship.isVertical) {
            // verticale
            if (placedIndexs
                .any((element) => element.index == randomCell + (i * 10))) {
              flag = true;
              list.clear();
              break;
            } else {
              flag = false;
            }
            IndexInfo info = IndexInfo(ship, randomCell + (i * 10), i + 1);
            list.add(info);
          } else {
            // horizontal
            if (placedIndexs
                .any((element) => element.index == randomCell + i)) {
              flag = true;
              list.clear();
              break;
            } else {
              flag = false;
            }
            IndexInfo info = IndexInfo(ship, randomCell + i, i + 1);
            list.add(info);
          }
        }
      } while (flag);
      placedIndexs.addAll(list);
    }

    return placedIndexs;
  }
}
