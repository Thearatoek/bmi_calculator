import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AppCircleChart extends StatefulWidget {
  final double? value;
  const AppCircleChart({
    super.key,
    required this.value,
  });

  @override
  State<AppCircleChart> createState() => _AppCircleChartState();
}

class _AppCircleChartState extends State<AppCircleChart> {
  @override

  /// Build method of your widget.

  Widget build(BuildContext context) {
    // Create animated radial gauge.
    // All arguments changes will be automatically animated.
    return SfRadialGauge(enableLoadingAnimation: true, animationDuration: 2000, axes: <RadialAxis>[
      RadialAxis(minimum: 0, maximum: 40, ranges: <GaugeRange>[
        GaugeRange(startValue: 0, endValue: 15.9, color: Colors.green),
        GaugeRange(startValue: 16, endValue: 16.9, color: Colors.orange),
        GaugeRange(startValue: 17, endValue: 18.4, color: Colors.red),
        GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.blue),
        GaugeRange(startValue: 25, endValue: 29.9, color: Colors.blue),
        GaugeRange(startValue: 30, endValue: 34.9, color: Colors.grey),
        GaugeRange(startValue: 35, endValue: 39.9, color: Colors.cyan),
        GaugeRange(startValue: 39.9, endValue: 40, color: Colors.deepOrange)
      ], pointers: <GaugePointer>[
        NeedlePointer(value: double.parse(widget.value.toString()))
      ], annotations: const <GaugeAnnotation>[])
    ]);
  }
}
