import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/constants.dart';
import '../../../providers/prediction_provider/prediction_provider.dart';
import '../../../providers/text_input_field_provider/text_input_field_provider.dart';
import '../../../services/predict_api_issue_service.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({super.key});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late TextInputFieldProvider _textInputFieldProvider;
  late PredictionProvider _predictionProvider;
  String prevText = '';
  late TextEditingController _textEditingController;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _predictionProvider = context.read<PredictionProvider>();
    _textInputFieldProvider = context.read<TextInputFieldProvider>();

    _textEditingController = TextEditingController(
      text: _textInputFieldProvider.text,
    );

    _textEditingController.addListener(() {
      if (_textEditingController.text != prevText) {
        prevText = _textEditingController.text;
        _onTextInputFieldChanged(_textEditingController.text);
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TextInputFieldProvider>(
      builder: (context, textInputFieldProvider, child) {
        _checkForExternalChanges();
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: TextField(
            autofocus: true,
            focusNode: _focusNode,
            maxLines: null,
            controller: _textEditingController,
            style: const TextStyle(fontSize: 48),
            cursorColor: Colors.black,
            decoration: const InputDecoration.collapsed(
              hintText: 'Insert sentence to predict...',
              border: InputBorder.none,
            ),
            onTapOutside: _onTapOutside,
          ),
        );
      },
    );
  }

  void _onTapOutside(PointerDownEvent event) {
    _focusNode.requestFocus();
  }

  bool _shouldPredictInputFieldValue() {
    String text = _textEditingController.text;

    return text.length > 5 && text.split(' ').length >= 3;
  }

  void _onTextInputFieldChanged(String value) {
    _predictionProvider.isPredictionModelValid = false;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (_shouldPredictInputFieldValue()) {
      _debounce = Timer(Constants.userIdleInputDelay, () {
        _predictInputFieldValue();
      });
    }
  }

  Future<void> _predictInputFieldValue() async {
    _predictionProvider.predictionModel =
        await PredictApiIssueService.predictText(
      context,
      text: _textEditingController.text,
    );
  }

  void _checkForExternalChanges() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_textEditingController.text != _textInputFieldProvider.text) {
        _textEditingController.text = _textInputFieldProvider.text;
        _textEditingController.selection = TextSelection.collapsed(
          offset: _textEditingController.text.length,
        );
      }
    });
  }
}
