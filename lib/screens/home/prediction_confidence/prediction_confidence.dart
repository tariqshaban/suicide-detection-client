import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suicide_detection_client/config/constants.dart';

import '../../../providers/prediction_provider/prediction_provider.dart';

class PredictionConfidence extends StatefulWidget {
  const PredictionConfidence({super.key});

  @override
  State<PredictionConfidence> createState() => _PredictionConfidenceState();
}

class _PredictionConfidenceState extends State<PredictionConfidence> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PredictionProvider>(
      builder: (context, predictionProvider, child) {
        return AnimatedOpacity(
          opacity: predictionProvider.isPredictionModelValid ? 1 : 0,
          duration: Constants.animationDuration,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: predictionProvider.predictionModel == null ? '' : '%',
                ),
                TextSpan(
                  text:
                      predictionProvider.predictionModel?.getFormattedScore() ??
                          '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
