part of 'vanilla_widgets.dart';

class VanillaListener<Notifier extends VanillaNotifier<S>, S>
    extends StatefulWidget {
  final VanillaListenerCallback<S> listener;
  final VanillaSelectorCallback<S>? listenWhen;
  final Widget child;

  const VanillaListener({
    Key? key,
    required this.listener,
    required this.child,
    this.listenWhen,
  }) : super(key: key);

  @override
  State<VanillaListener<Notifier, S>> createState() =>
      _VanillaListenerState<Notifier, S>();
}

class _VanillaListenerState<Notifier extends VanillaNotifier<S>, S>
    extends State<VanillaListener<Notifier, S>> {
  S? previousState;

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
    final S currentState = context.read<Notifier>().state;
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
