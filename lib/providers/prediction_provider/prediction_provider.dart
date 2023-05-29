import 'package:flutter/material.dart';
import 'package:suicide_detection_client/models/prediction/prediction_model.dart';
import 'package:suicide_detection_client/providers/api_request_state_provider/api_request_state_provider.dart';

import '../../enums/api_request_state.dart';

class PredictionProvider extends ChangeNotifier {
  late APIRequestStateProvider _apiRequestStateProvider;

  PredictionModel? _predictionModel;

  bool _isPredictionModelValid = false;

  PredictionModel? get predictionModel => _predictionModel;

  set predictionModel(PredictionModel? value) {
    _predictionModel = value;
    _isPredictionModelValid = true;
    notifyListeners();
  }

  bool get isPredictionModelValid => _isPredictionModelValid;

  set isPredictionModelValid(bool value) {
    _apiRequestStateProvider.apiRequestState = APIRequestState.awaiting;
    _isPredictionModelValid = value;
    notifyListeners();
  }

  update(APIRequestStateProvider apiRequestStateProvider) {
    _apiRequestStateProvider = apiRequestStateProvider;
  }

  Color getColor() {
    return _predictionModel?.getColor() ?? Colors.transparent;
  }

  Color getColorWithOpacity() {
    return _predictionModel?.getColorWithOpacity() ?? Colors.transparent;
  }
}
