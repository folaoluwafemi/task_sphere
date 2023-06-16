part of '../vanilla.dart';

class VanillaNotifierHolder<Notifier extends VanillaNotifier>
    extends SingleChildStatefulWidget {
  final Notifier Function() createNotifier;

  const VanillaNotifierHolder({
    required this.createNotifier,
    super.child,
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
  SingleChildStatefulElement createElement() =>
      VanillaNotifierElement<Notifier>(this, createNotifier());

  @override
  State<VanillaNotifierHolder<Notifier>> createState() =>
      VanillaHolderState<Notifier>();
}

class VanillaHolderState<Notifier extends VanillaNotifier>
    extends SingleChildState<VanillaNotifierHolder<Notifier>> {
  asdf() {}

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => child!;
}

class VanillaNotifierElement<Notifier extends ValueNotifier>
    extends SingleChildStatefulElement {
  final Notifier notifier;

  VanillaNotifierElement(super.widget, this.notifier);
}
