part of 'vanilla_widgets.dart';

class VanillaBuilder<Notifier extends VanillaNotifier<S>, S>
    extends StatefulWidget {
  final VanillaWidgetBuilder<S> builder;
  final VanillaSelectorCallback<S>? buildWhen;

  const VanillaBuilder({
    Key? key,
    required this.builder,
    this.buildWhen,
  }) : super(key: key);

  @override
  State<VanillaBuilder<Notifier, S>> createState() =>
      _VanillaBuilderState<Notifier, S>();
}

class _VanillaBuilderState<Notifier extends VanillaNotifier<T>, T>
    extends State<VanillaBuilder<Notifier, T>> {
  Notifier? notifier;

  T? previousState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startListening();
  }

  void startListening() {
    if (notifier != null) {
      notifier!.removeListener(listener);
    }
    notifier = context.read<Notifier>();
    notifier?.addListener(listener);
  }

  /// listener is called whenever the state changes.
  ///
  /// If [listenWhen] is provided, it is used to check if listener should be called.
  void listener() {
    if (!mounted) return;

    final T currentState = notifier!.state;

    if (currentState == previousState) return;

    if (widget.buildWhen != null) {
      final bool shouldNotify = widget.buildWhen!(previousState, currentState);
      if (shouldNotify) {
        update();
      }
      return;
    }

    update();

    previousState = currentState;
  }

  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant VanillaBuilder<Notifier, T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    notifier?.removeListener(listener);
    startListening();
  }

  @override
  void dispose() {
    notifier?.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      previousState ?? notifier!.state,
    );
  }
}
