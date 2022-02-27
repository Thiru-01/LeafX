import "package:flutter/material.dart";

class CustomContainer extends StatelessWidget {
  final height;
  final color;
  final child;
  const CustomContainer({Key? key, this.height, this.color, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: BezierClipper(),
        child: Container(
            height: height,
            color: color,
            child: Center(
              child: child,
            )));
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 392;
    final double _yScaling = size.height / 300;
    path.lineTo(0 * _xScaling, 0 * _yScaling);
    path.cubicTo(
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      257.568 * _yScaling,
      0 * _xScaling,
      257.568 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      257.568 * _yScaling,
      62.53699999999998 * _xScaling,
      160.729 * _yScaling,
      203.291 * _xScaling,
      257.568 * _yScaling,
    );
    path.cubicTo(
      344.045 * _xScaling,
      354.40700000000004 * _yScaling,
      392.46500000000003 * _xScaling,
      257.568 * _yScaling,
      392.46500000000003 * _xScaling,
      257.568 * _yScaling,
    );
    path.cubicTo(
      392.46500000000003 * _xScaling,
      257.568 * _yScaling,
      392.46500000000003 * _xScaling,
      0 * _yScaling,
      392.46500000000003 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      392.46500000000003 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
