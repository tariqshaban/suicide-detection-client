import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/text_input_field_provider/text_input_field_provider.dart';
import '../../../services/sample_api_issue_service.dart';

class SampleButton extends StatefulWidget {
  const SampleButton({super.key});

  @override
  State<SampleButton> createState() => _SampleButtonState();
}

class _SampleButtonState extends State<SampleButton> {
  late TextInputFieldProvider _textInputFieldProvider;

  @override
  void initState() {
    super.initState();

    _textInputFieldProvider = context.read<TextInputFieldProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onSampleButtonPressed,
      child: const Text(
        'Sample',
        style: TextStyle(
          fontSize: 32,
        ),
      ),
    );
  }

  Future<void> _onSampleButtonPressed() async {
    _textInputFieldProvider.text = (await SampleApiIssueService.sampleText(
      context,
    ))
        .text;
  }
}
