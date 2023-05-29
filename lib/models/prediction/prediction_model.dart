import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prediction_model.g.dart';

@JsonSerializable()
class PredictionModel {
  @JsonKey(name: 'label')
  String label;
  @JsonKey(name: 'score')
  double score;

  PredictionModel(
    this.label,
    this.score,
  );

  String getFormattedLabel() {
    if (label == 'suicide') {
      return 'Suicide';
    } else {
      return 'Non Suicide';
    }
  }

  String getFormattedScore() {
    return (score * 100).toStringAsFixed(2);
  }

  Color getColor() {
    if (label == 'suicide') {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  Color getColorWithOpacity() {
    double opacity = Curves.easeOutCirc.transform(score);

    return getColor().withOpacity(opacity);
  }

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      _$PredictionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionModelToJson(this);
}
