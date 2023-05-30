class Constants {
  static const String rootAPIEndpoint = 'http://127.0.0.1:5000';
  static const String predictionAPIEndpoint = '$rootAPIEndpoint/predict';
  static const String sampleAPIEndpoint = '$rootAPIEndpoint/sample';
  static const Duration userIdleInputDelay = Duration(seconds: 1);
  static const Duration animationDuration = Duration(milliseconds: 600);
}
