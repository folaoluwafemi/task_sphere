import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class ResponsivenessWrapper extends SingleChildStatelessWidget {
  final Size? screenSize;
  final Size designSize;
  final bool useMediaQuery;
  final Widget? child;

  const ResponsivenessWrapper({
    Key? key,
    this.screenSize,
    required this.designSize,
    required this.useMediaQuery,
    this.child,
  })  : assert(
          !useMediaQuery ? screenSize != null : true,
          'if [useMediaQuery] is set to false, screenSize must be provided',
        ),
        super(key: key);

  static Future<void> ensureUiLaidOut([
    FlutterView? window,
    Duration duration = const Duration(milliseconds: 10),
  ]) async {
    final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
    window ??= WidgetsBinding.instance.platformDispatcher.implicitView;

    if (window?.physicalGeometry.isEmpty == true) {
      return Future.delayed(duration, () async {
        binding.deferFirstFrame();
        await ensureUiLaidOut(window, duration);
        return binding.allowFirstFrame();
      });
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null, 'child must not be null');
    return FutureBuilder(
      future: ensureUiLaidOut(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            final Size screenSize_ = useMediaQuery
                ? Size(constraints.minWidth, constraints.minHeight)
                : screenSize!;
            ResponsivenessSizer().initializeWithSize(
              screenSize: screenSize_,
              designSize: designSize,
            );
            return child!;
          },
        );
      },
    );
  }
}

class ResponsivenessSizer {
  ResponsivenessSizer._();

  static final ResponsivenessSizer instance = ResponsivenessSizer._();

  factory ResponsivenessSizer() => instance;

  late double screenHeight;
  late double screenWidth;

  late Size designSize;
  bool initialized = false;

  void initializeWithSize({
    required Size screenSize,
    required Size designSize,
  }) {
    if (initialized && (screenHeight != 0 || screenWidth != 0)) return;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;

    this.designSize = designSize;
    initialized = true;
  }

  double get widthScale => screenWidth / designSize.width;

  double get heightScale => screenHeight / designSize.height;
}
