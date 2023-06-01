part of '../vanilla.dart';

class VanillaNotifierHolder<Notifier extends VanillaNotifier>
    extends SingleChildStatefulWidget {
  final Notifier notifier;

  const VanillaNotifierHolder({
    required super.child,
    required this.notifier,
    Key? key,
  }) : super(key: key);

  static T read<T extends VanillaNotifier>(BuildContext context) {
    try {
      return context
          .findAncestorWidgetOfExactType<VanillaNotifierHolder<T>>()!
          .notifier;
    } catch (e) {
      throw Exception(
        'Cannot find VanillaNotifierHolder<$T> in the widget tree',
      );
    }
  }

  @override
  State<VanillaNotifierHolder<Notifier>> createState() =>
      VanillaHolderState<Notifier>();
}

class VanillaHolderState<Notifier extends VanillaNotifier>
    extends SingleChildState<VanillaNotifierHolder<Notifier>> {
  @override
  Widget buildWithChild(BuildContext context, Widget? child) => child!;
}
