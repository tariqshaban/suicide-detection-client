import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/constants.dart';
import '../../../providers/prediction_provider/prediction_provider.dart';

class PredictionLabel extends StatefulWidget {
  const PredictionLabel({super.key});

  @override
  State<PredictionLabel> createState() => _PredictionLabelState();
}

class _PredictionLabelState extends State<PredictionLabel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PredictionProvider>(
      builder: (context, predictionProvider, child) {
        return AnimatedOpacity(
          opacity: predictionProvider.isPredictionModelValid ? 1 : 0,
          duration: Constants.animationDuration,
          child: Text(
            predictionProvider.predictionModel?.getFormattedLabel() ?? '',
            style: TextStyle(
              color: predictionProvider.getColor(),
              fontSize: 40,
            ),
          ),
        );
      },
    );
  }
}
