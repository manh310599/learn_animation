import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BuilderAndTransform extends StatefulWidget {
  const BuilderAndTransform({super.key});

  @override
  State<BuilderAndTransform> createState() => _BuilderAndTransformState();
}

class _BuilderAndTransformState extends State<BuilderAndTransform> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(
                child: Animate().custom(
                  begin: 0,
                  end: 100,
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Text(
                      '${value.round()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ),
              Animate().custom(
                begin: 1,
                end: 100,
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return CustomPaint(
                    size: const Size(100, 100),
                    painter: ProgressPainter(value.round()),
                  );
                },
              )
            ],
          )),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final int percentage;

  ProgressPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.width == size.height, 'error');
    canvas.drawArc(
      Offset.zero & size,
      -pi / 2,
      -percentage / 100 * 2 * pi,
      false,
      Paint()
        ..color = Colors.blue
        ..strokeWidth = 10
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate is ProgressPainter && percentage != percentage;
  }
}
