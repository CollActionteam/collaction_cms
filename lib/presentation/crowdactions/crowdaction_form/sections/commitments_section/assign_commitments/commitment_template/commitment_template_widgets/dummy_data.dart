import 'package:collaction_cms/presentation/core/icons/collaction_icons.dart';
import 'package:flutter/material.dart';

class DummyModel {
  final String label;
  final List<String> tags;
  final String description;
  final String points;
  final IconData commitmentIcon;

  DummyModel(this.label, this.tags, this.description, this.points,
      this.commitmentIcon);
}

List<DummyModel> dummyData = <DummyModel>[
  DummyModel(
      "1 days per week",
      ["Days", "Veganuary", "Diet"],
      "Commit to eating a vegan diet 4 day per week",
      "10",
      CollactionIcons.vegan),
  DummyModel(
      "2 days per week",
      ["Days", "Veganuary", "Diet"],
      "Commit to eating a vegan diet 4 day per week",
      "20",
      CollactionIcons.vegan),
  DummyModel(
      "3 days per week",
      ["Days", "Veganuary", "Diet"],
      "Commit to eating a vegan diet 4 day per week",
      "30",
      CollactionIcons.vegan),
  DummyModel(
      "4 days per week",
      ["Days", "Veganuary", "Diet"],
      "Commit to eating a vegan diet 4 day per week",
      "40",
      CollactionIcons.vegan),
  DummyModel(
      "5 days per week",
      ["Days", "Veganuary", "Diet"],
      "Commit to eating a vegan diet 4 day per week",
      "50",
      CollactionIcons.vegan),
];
