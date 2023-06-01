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
  T? previousState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startListening();
  }

  void startListening() {
    context.read<Notifier>().addListener(listener);
  }

  /// listener is called whenever the state changes.
  ///
  /// If [listenWhen] is provided, it is used to check if listener should be called.
  void listener() {
    final T currentState = context.read<Notifier>().state;
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
  void dispose() {
    context.read<Notifier>().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      previousState ?? context.read<Notifier>().state,
    );
  }
}
