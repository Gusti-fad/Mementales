import 'package:flutter/material.dart';

class SpaceModel {
  final String id;
  final String title;
  final String description;
  final double budget;
  final String budgetPeriod;
  final Color color;

  SpaceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.budgetPeriod,
    required this.color,
  });
}