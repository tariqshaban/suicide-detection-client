import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:suicide_detection_client/config/constants.dart';
import 'package:suicide_detection_client/enums/api_request_state.dart';
import 'package:suicide_detection_client/enums/snack_bar_type.dart';

import '../helpers/snack_bar_helper.dart';
import '../models/prediction/prediction_model.dart';
import '../providers/api_request_state_provider/api_request_state_provider.dart';

class PredictApiIssueService {
  static Future<PredictionModel> predictText(
    BuildContext context, {
    required String text,
  }) async {
    APIRequestStateProvider apiRequestStateProvider =
        context.read<APIRequestStateProvider>();

    Response? response;

    try {
      apiRequestStateProvider.apiRequestState = APIRequestState.pending;

      response = await Dio().get(
        Constants.predictionAPIEndpoint,
        queryParameters: {
          'text': text,
        },
      );

      apiRequestStateProvider.apiRequestState = APIRequestState.success;
    } catch (e) {
      apiRequestStateProvider.apiRequestState = APIRequestState.failed;

      SnackBarHelper.showSnackBar(
        context,
        title: 'Could not contact the server',
        snackBarType: SnackBarType.error,
      );
    }

    return PredictionModel.fromJson(response?.data);
  }
}
