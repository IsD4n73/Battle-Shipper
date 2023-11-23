import 'package:flutter/material.dart';

import '../../../../domain/entities/ship.dart';

class ShipsItems extends StatefulWidget {
  List<Ship> ships;
  int selectedIndex;
  int size;
  void Function()? onDragCompleted;
  void Function()? onDragStarted;

  ShipsItems({
    super.key,
    required this.ships,
    this.onDragCompleted,
    required this.selectedIndex,
    required this.size,
    this.onDragStarted,
  });

  @override
  State<ShipsItems> createState() => _ShipsItemsState();
}

class _ShipsItemsState extends State<ShipsItems> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.ships.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 30,
            height: widget.ships[index].image.height!,
            child: Draggable<Ship>(
              onDragCompleted: widget.onDragCompleted,
              data: widget.ships[index],
              dragAnchorStrategy: pointerDragAnchorStrategy,
              onDragStarted: () {
                setState(() {
                  widget.selectedIndex = index;
                  if (widget.ships.isNotEmpty) {
                    widget.size = widget.ships[widget.selectedIndex].size;
                  }
                });
              },
              feedback: Opacity(
                opacity: 0.5,
                child: SizedBox(
                  height:
                      ((120 * 33) / 100) + 30 * (widget.ships[index].size - 1),
                  child: widget.ships[index].image,
                ),
              ),
              child: SizedBox(
                  height: (widget.ships[index].image.height! * 33) / 100,
                  child: widget.ships[index].image),
            ),
          );
        },
      ),
    );
  }
}
