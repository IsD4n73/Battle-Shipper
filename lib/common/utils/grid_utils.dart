import 'dart:math';

import '../../domain/entities/index_info.dart';
import '../../domain/entities/ship.dart';

class GridUtils {
  static int gridSize = 10;



  static int getIndex(int index, List<IndexInfo> placedIndexs) {
    for (int i = 0; i < placedIndexs.length; i++) {
      if (placedIndexs[i].index == index) {
        return i;
      }
    }
    return 0;
  }



  static List<IndexInfo> randomizeShips() {
    var random = Random();
    List<IndexInfo> placedIndexs = [];

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
