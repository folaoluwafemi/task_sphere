part of '../vanilla.dart';

class InheritedVanilla<Notifier extends VanillaNotifier>
    extends InheritedWidget {
  final Notifier Function() createNotifier;

  const InheritedVanilla({
    required this.createNotifier,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  @override
  InheritedVanillaElement createElement() => InheritedVanillaElement<Notifier>(
        this,
        createNotifier(),
      );
}

class InheritedVanillaElement<Notifier extends VanillaNotifier>
    extends InheritedElement {
  final Notifier notifier;

  @override
  void unmount() {
    notifier.dispose();
    super.unmount();
  }

  InheritedVanillaElement(super.widget, this.notifier);
}
