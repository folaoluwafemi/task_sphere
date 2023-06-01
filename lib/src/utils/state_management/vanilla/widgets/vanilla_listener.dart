part of 'vanilla_widgets.dart';

class VanillaListener<Notifier extends VanillaNotifier<T>,
    T extends VanillaState> extends StatefulWidget {
  final VanillaListenerCallback<T> listener;
  final VanillaSelectorCallback<T>? listenWhen;
  final Widget child;

  const VanillaListener({
    Key? key,
    required this.listener,
    required this.child,
    this.listenWhen,
  }) : super(key: key);

  @override
  State<VanillaListener<Notifier, T>> createState() =>
      _VanillaListenerState<Notifier, T>();
}

class _VanillaListenerState<Notifier extends VanillaNotifier<T>,
    T extends VanillaState> extends State<VanillaListener<Notifier, T>> {
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
    if (widget.listenWhen != null) {
      final bool shouldNotify = widget.listenWhen!(previousState, currentState);
      if (shouldNotify) {
        widget.listener(previousState, currentState);
      }
      return;
    }

    widget.listener(previousState, currentState);

    previousState = currentState;
  }

  @override
  void dispose() {
    context.read<Notifier>().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
