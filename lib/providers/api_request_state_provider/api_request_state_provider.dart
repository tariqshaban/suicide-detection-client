import 'package:flutter/material.dart';

import '../../enums/api_request_state.dart';

class APIRequestStateProvider extends ChangeNotifier {
  APIRequestState _apiRequestState = APIRequestState.awaiting;

  APIRequestState get apiRequestState => _apiRequestState;

  set apiRequestState(APIRequestState value) {
    _apiRequestState = value;
    notifyListeners();
  }
}
