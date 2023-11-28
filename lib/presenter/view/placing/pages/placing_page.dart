import 'package:battle_shipper/domain/entities/index_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../common/utils/grid_utils.dart';
import '../../../../domain/entities/ship.dart';
import '../widgets/grid_area.dart';
import '../widgets/head_area.dart';
import '../widgets/ship_area.dart';

class PlacingPage extends StatefulWidget {
  const PlacingPage({super.key});

  @override
  State<PlacingPage> createState() => PlacingPageState();
}

class PlacingPageState extends State<PlacingPage> {
  List<Ship> ships = [];
  List<IndexInfo> placedIndexs = [];
  int selectedIndex = 0;
  int size = 0;
  List<int> selectedIndexs = [];
  Ship? shipTmp;

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
          HeadArea(
            resetOnPressed: () {
              setState(() {
                ships = List.generate(7, (index) => Ship.create(index));
                placedIndexs = [];
                selectedIndex = 0;
                selectedIndexs = [];
                size = 0;
              });
              },
            continueOnPressed: ships.isNotEmpty ? null : () {},
            randomizeOnPressed: () {
              setState(() {
                placedIndexs = GridUtils.randomizeShips();
                selectedIndexs = [];
                ships = [];
              });
              },
          ),
          ShipArea(
            selectedIndex: selectedIndex,
            placedIndexs: placedIndexs,
            ships: ships,
          ),
          GridArea(
            selectedIndexs: selectedIndexs,
            selectedIndex: selectedIndex,
            placedIndexs: placedIndexs,
            ships: ships,
          ),
        ],
      ),
    );
  }


}
