import 'package:flutter/material.dart';

/// This is somewhat of a hack.
/// Wrapping the AspectRatio inside an UnconstrainedBox and IntrinsicHeight will
/// result in the AspectRatio having an unbounded width and intrinsic height.
/// That makes the AspectRatio size the widget with respect to the height
/// (essentially stretch the width out to match the height)
class Square extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;

  const Square({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: UnconstrainedBox(
          child: IntrinsicHeight(
            child: AspectRatio(
              aspectRatio: 1,
              child: child,
            ),
          ),
        ),
      );
}
