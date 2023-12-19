import 'package:flutter/material.dart';
import '../../../../domain/entities/ship.dart';

class PlacingShip extends StatelessWidget {
  final int index;
  final List<Ship> ships;
  final void Function(Velocity, Offset)? onDraggableCanceled;
  final void Function()? onDragStarted;
  final void Function()? onTap;
  final void Function()? onDragCompleted;

  const PlacingShip({
    super.key,
    required this.ships,
    required this.index,
    this.onDraggableCanceled,
    this.onDragStarted,
    this.onTap,
    this.onDragCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<Ship>(
      onDraggableCanceled: onDraggableCanceled,
      onDragEnd: (details) {
        if (!details.wasAccepted) {}
      },
      onDragUpdate: (details) {},
      onDragCompleted: onDragCompleted,
      data: ships[index],
      dragAnchorStrategy: pointerDragAnchorStrategy,
      onDragStarted: onDragStarted,
      feedback: Opacity(
        opacity: 0.5,
        child: RotatedBox(
          quarterTurns: ships[index].isVertical ? 0 : 3,
          child: SizedBox(
            height: ((120 * 33) / 100) + 30 * (ships[index].size - 1),
            child: ships[index].image,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: RotatedBox(
          quarterTurns: ships[index].isVertical ? 0 : 3,
          child: SizedBox(
            height: ((120 * 33) / 100) + 30 * (ships[index].size - 1),
            child: ships[index].image,
          ),
        ),
      ),
    );
  }
}
