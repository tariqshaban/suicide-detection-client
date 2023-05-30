import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/api_request_state_provider/api_request_state_provider.dart';
import '../providers/prediction_provider/prediction_provider.dart';
import '../providers/text_input_field_provider/text_input_field_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<APIRequestStateProvider>(
    create: (context) => APIRequestStateProvider(),
  ),
  ChangeNotifierProxyProvider<APIRequestStateProvider, PredictionProvider>(
    create: (_) => PredictionProvider(),
    update: (_, apiRequestStateProvider, predictionProvider) =>
        predictionProvider!..update(apiRequestStateProvider),
    lazy: false,
  ),
  ChangeNotifierProvider<TextInputFieldProvider>(
    create: (context) => TextInputFieldProvider(),
  ),
];
