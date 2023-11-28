import 'package:battle_shipper/presenter/view/placing/widgets/placing_ship.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/index_info.dart';
import '../../../../domain/entities/ship.dart';
import '../pages/placing_page.dart';

class ShipArea extends StatefulWidget {
  int selectedIndex;
  List<Ship> ships;
  List<IndexInfo> placedIndexs;

  ShipArea({
    super.key,
    required this.selectedIndex,
    required this.ships,
    required this.placedIndexs,
  });

  @override
  State<ShipArea> createState() => _ShipAreaState();
}

class _ShipAreaState extends State<ShipArea> {
  Ship? shipTmp;
  late int selectedIndex;
  late List<Ship> ships;
  late List<IndexInfo> placedIndexs;


  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    placedIndexs = widget.placedIndexs;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ships = widget.ships;

    return SizedBox(
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
                    (index) => PlacingShip(
                  index: index,
                  ships: ships,
                  onDragCompleted: (){
                    setState(() {});
                  },
                  onDraggableCanceled: (velocity, offset) {
                    setState(() {
                      var ancestralState = context.findAncestorStateOfType<PlacingPageState>();
                      ancestralState!.setState(() {
                        if (selectedIndex >= ships.length) {
                          ships.add(ancestralState.shipTmp!);
                        } else {
                          ships.insert(selectedIndex, ancestralState.shipTmp!);
                        }
                      });
                    });
                  },
                  onTap: () {
                    setState(() {
                      ships[index].isVertical = !ships[index].isVertical;
                    });
                  },
                  onDragStarted: () {
                    setState(() {
                      selectedIndex = index;
                      var ancestralState = context.findAncestorStateOfType<PlacingPageState>();
                      ancestralState!.setState(() {
                      if (ships.isNotEmpty) {
                          ancestralState.size = ships[index].size;
                          ancestralState.shipTmp = ships.removeAt(index);
                        }
                      });
                    });
                  },
                )),
          ),
        ),
      ),
    );
  }

}
