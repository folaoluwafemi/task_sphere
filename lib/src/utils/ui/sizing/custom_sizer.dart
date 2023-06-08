import 'dart:ui';

import 'package:flutter/material.dart';

class ResponsivenessWrapper extends StatefulWidget {
  final Size? screenSize;
  final Size designSize;
  final bool useMediaQuery;
  final WidgetBuilder builder;

  const ResponsivenessWrapper({
    Key? key,
    this.screenSize,
    required this.designSize,
    required this.useMediaQuery,
    required this.builder,
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
  State<ResponsivenessWrapper> createState() => _ResponsivenessWrapperState();
}

class _ResponsivenessWrapperState extends State<ResponsivenessWrapper> {
  Future<void> initialize() async {
    await ResponsivenessWrapper.ensureUiLaidOut().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ResponsivenessSizer().initializeWithSize(
          screenSize: widget.screenSize ?? MediaQuery.of(context).size,
          designSize: widget.designSize,
        );
        setState(() {});
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size screenSize_ = widget.useMediaQuery
            ? Size(constraints.minWidth, constraints.minHeight)
            : widget.screenSize!;
        ResponsivenessSizer().initializeWithSize(
          screenSize: screenSize_,
          designSize: widget.designSize,
        );
        return widget.builder(context);
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
  bool _initialized = false;

  void initializeWithSize({
    required Size screenSize,
    required Size designSize,
  }) {
    if (_initialized && (screenHeight != 0 || screenWidth != 0)) return;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;

    this.designSize = designSize;
    _initialized = true;
  }

  double get widthScale => screenWidth / designSize.width;

  double get heightScale => screenHeight / designSize.height;
}
