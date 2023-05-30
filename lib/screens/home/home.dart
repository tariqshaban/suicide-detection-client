import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suicide_detection_client/config/constants.dart';
import 'package:suicide_detection_client/screens/home/prediction_confidence/prediction_confidence.dart';
import 'package:suicide_detection_client/screens/home/prediction_label/prediction_label.dart';
import 'package:suicide_detection_client/screens/home/title/title.dart';

import '../../providers/prediction_provider/prediction_provider.dart';
import '../../widgets/liquid_progress_indicator/src/liquid_linear_progress_indicator.dart';
import 'sample_button/sample_button.dart';
import 'text_input_field/text_input_field.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageTitle(),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: SampleButton(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: double.maxFinite,
                        child: TextInputField(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 50),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(50),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: const Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Prediction',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: PredictionLabel(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            Consumer<PredictionProvider>(
                              builder: (context, predictionProvider, child) {
                                return Expanded(
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                        begin: 0,
                                        end: predictionProvider
                                                .isPredictionModelValid
                                            ? predictionProvider
                                                    .predictionModel?.score ??
                                                0
                                            : -0.5),
                                    duration: Constants.animationDuration,
                                    curve: Curves.easeInOut,
                                    builder: (context, value, _) {
                                      return LiquidLinearProgressIndicator(
                                        borderRadius: 20,
                                        borderWidth: 0,
                                        borderColor: Colors.transparent,
                                        value: value,
                                        valueColor: AlwaysStoppedAnimation(
                                          predictionProvider.predictionModel
                                                  ?.getColorWithOpacity() ??
                                              Colors.transparent,
                                        ),
                                        backgroundColor: Colors.transparent,
                                        direction: Axis.vertical,
                                        center: Container(
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.all(50),
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: const Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  'Confidence',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 40,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: PredictionConfidence(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
