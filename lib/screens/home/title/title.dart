import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suicide_detection_client/providers/api_request_state_provider/api_request_state_provider.dart';

import '../../../config/constants.dart';
import '../../../enums/api_request_state.dart';

class PageTitle extends StatefulWidget {
  const PageTitle({super.key});

  @override
  State<PageTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> with TickerProviderStateMixin {
  late APIRequestStateProvider _apiRequestStateProvider;
  late AnimationController _opacityAnimationController;
  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();

    _apiRequestStateProvider = context.read<APIRequestStateProvider>();

    _opacityAnimationController = AnimationController(
      duration: Constants.animationDuration,
      value: 1,
      vsync: this,
    );

    _colorAnimationController = AnimationController(
      duration: Constants.animationDuration,
      vsync: this,
    );

    _colorTween = ColorTween(
      begin: Colors.white,
      end: Colors.red,
    ).animate(_colorAnimationController);
  }

  @override
  void dispose() {
    _opacityAnimationController.dispose();
    _colorAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<APIRequestStateProvider>(
        builder: (context, apiRequestStateProvider, child) {
      _updateAnimationBasedOnApiRequestState();
      return AnimatedBuilder(
        animation: _opacityAnimationController,
        builder: (context, child) {
          return AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimationController.value,
                  child: Text(
                    'Suicide Detection',
                    style: TextStyle(
                      color: _colorTween.value,
                      fontWeight: FontWeight.bold,
                      fontSize: 56,
                    ),
                  ),
                );
              });
        },
      );
    });
  }

  void _updateAnimationBasedOnApiRequestState() {
    switch (_apiRequestStateProvider.apiRequestState) {
      case APIRequestState.awaiting:
        _stopFadeAnimation();
        _revertColorAnimation();
        break;
      case APIRequestState.pending:
        _startFadeAnimation();
        _revertColorAnimation();
        break;
      case APIRequestState.success:
        _stopFadeAnimation();
        _revertColorAnimation();
        break;
      case APIRequestState.failed:
        _stopFadeAnimation();
        _errorColorAnimation();
        break;
    }
  }

  void _stopFadeAnimation() {
    _opacityAnimationController.animateTo(1);
  }

  void _startFadeAnimation() {
    _opacityAnimationController
      ..reverse()
      ..addListener(() {
        if (_opacityAnimationController.isDismissed) {
          _opacityAnimationController.repeat(reverse: true);
        }
      });
  }

  void _revertColorAnimation() {
    _colorAnimationController.animateTo(0);
  }

  Future<void> _errorColorAnimation() async {
    _colorAnimationController
      ..forward()
      ..addListener(() {
        if (_colorAnimationController.value == 1) {
          _colorAnimationController.repeat(reverse: true);
        }
      });
  }
}
