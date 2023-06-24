part of '../vanilla.dart';

class VanillaNotifierHolder<Notifier extends VanillaNotifier>
    extends StatefulWidget {
  final Notifier Function() createNotifier;
  final Widget child;

  const VanillaNotifierHolder({
    required this.createNotifier,
    required this.child,
    Key? key,
  }) : super(key: key);

  static T read<T extends VanillaNotifier>(BuildContext context) {
    try {
      return _elementOfType<T>(context)!.notifier;
    } catch (e, s) {
      throw Failure(
        message: 'Cannot find VanillaNotifierHolder<$T> in the widget tree',
        stackTrace: s,
      );
    }
  }

  static VanillaNotifierElement<Notifier>?
      _elementOfType<Notifier extends VanillaNotifier>(
    BuildContext context,
  ) {
    VanillaNotifierElement<Notifier>? element;

    context.visitAncestorElements((ancestor) {
      if (ancestor is VanillaNotifierElement<Notifier>) {
        element = ancestor;
        return false;
      }
      return true;
    });
    return element;
  }

  @override
  StatefulElement createElement() =>
      VanillaNotifierElement<Notifier>(this, createNotifier());

  @override
  State<VanillaNotifierHolder<Notifier>> createState() =>
      VanillaHolderState<Notifier>();
}

class VanillaHolderState<Notifier extends VanillaNotifier>
    extends State<VanillaNotifierHolder<Notifier>> {
  @override
  Widget build(BuildContext context) => widget.child;
}

class VanillaNotifierElement<Notifier extends ValueNotifier>
    extends StatefulElement {
  final Notifier notifier;

  VanillaNotifierElement(super.widget, this.notifier);
}
