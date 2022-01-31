import 'package:flutter/material.dart';

class ModeItemModel {
  const ModeItemModel({
    required this.name,
    required this.minutes,
    required this.color,
  });

  final String name;
  final int minutes;
  final Color color;
}
