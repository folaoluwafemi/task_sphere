part of 'extensions.dart';

extension ListExtension<T> on List<T> {
  List<String> toEachString() => map<String>((e) => e.toString()).toList();

  int get lastIndex => length - 1;

  bool everyAfter(
    int index,
    bool Function(T element) test,
  ) {
    final List<T> nextList = sublist(index + 1);
    return nextList.every(test);
  }

  List<E> mapWithIndex<E>(E Function(int index, T element) test) {
    final List<E> nextList = [];
    for (int i = 0; i < length; i++) {
      nextList.add(test(i, this[i]));
    }
    return nextList;
  }

  bool everyBetween(int start, int end, bool Function(T element) test) {
    final List<T> nextList = sublist(start, end);
    return nextList.every(test);
  }

  bool anyAfter(
    int index,
    bool Function(T element) test,
  ) {
    final List<T> nextList = sublist(index + 1);
    return nextList.any(test);
  }

  bool anyBetween(int start, int end, bool Function(T element) test) {
    final List<T> nextList = sublist(start, end);
    return nextList.any(test);
  }

  bool anyBefore(
    int index,
    bool Function(T element) test,
  ) {
    final List<T> nextList = sublist(0, index);
    return nextList.any(test);
  }

  void forEachWhere(
    bool Function(T element) test,
    void Function(T element) action,
  ) {
    for (T element in this) {
      if (test(element)) {
        action(element);
      }
    }
  }

  void forEachWhereAfter({
    required int index,
    required bool Function(T element) where,
    required void Function(T element) action,
  }) {
    final List<T> nextList = sublist(index + 1);
    nextList.forEachWhere(where, action);
  }

  void forEachWhereBefore({
    required int index,
    required bool Function(T element) where,
    required void Function(T element) action,
  }) {
    final List<T> nextList = sublist(0, index);
    nextList.forEachWhere(where, action);
  }

  void forEachWhereBeforeWithIndex({
    required int index,
    required bool Function(T element) where,
    required void Function(int index) action,
  }) {
    final List<T> nextList = sublist(0, index);

    for (int i = 0; i < nextList.length; i++) {
      if (where(nextList[i])) {
        action(i);
      }
    }
  }

  void forEachAfter(
    int index,
    void Function(T element) action,
  ) {
    final List<T> nextList = sublist(index + 1);
    nextList.forEach(action);
  }

  List<T> operator *(int times) {
    if (isEmpty) return [];

    final List<T> nextList = [];
    for (int i = 0; i < times; i++) {
      nextList.addAll(this);
    }

    return nextList;
  }

  bool containsAll(Iterable<T> it) {
    for (T item in it) {
      if (!contains(item)) return false;
    }
    return true;
  }

  void addWhereAbsent(Iterable<T> it) {
    for (T item in it) {
      if (!contains(item)) {
        add(item);
      }
    }
  }

  bool isFirst(T element, [bool Function(T? element)? test]) {
    if (isEmpty) return false;
    return test?.call(first) ?? first == element;
  }

  T? elementAtOrNull(int index) {
    try {
      return this[index];
    } catch (e) {
      return null;
    }
  }

  bool hasElementAfter(T element) {
    if (!contains(element)) throw StateError('test element is not in list');

    if (isLast(element)) return false;

    return true;
  }

  bool isLast(T element, [bool Function(T? element)? test]) {
    if (isEmpty) return false;
    return test?.call(last) ?? last == element;
  }

  bool containsWhere(bool Function(T element) test) {
    for (T element in this) {
      bool satisfied = test(element);
      if (satisfied) {
        return true;
      }
    }
    return false;
  }

  void pushFront(T element) {
    return insert(0, element);
  }

  T get lastItem {
    if (isEmpty) throw StateError('List is Empty');
    return this[length - 1];
  }

  List<T> operator +(List<T> other) {
    final List<T> tempList = [];
    tempList.addAll(this);
    tempList.addAll(other);
    return tempList;
  }

  bool isEachEqual(List<T> other) {
    if (length != other.length) return false;
    if (isEmpty && other.isEmpty) return true;
    if (isEmpty ^ other.isEmpty) return false;
    bool isEqual = false;
    for (int i = 0; i < length; i++) {
      isEqual = [i] == other[i];
    }
    return isEqual;
  }

  void replaceWhere(Iterable<T> replacement, bool Function(T element) test) {
    int index = indexWhere(test);

    if (index == -1) throw StateError('index not found in $this');
    replaceRange(index, index + 1, replacement);
  }

  void replaceLast(Iterable<T> replacement) {
    if (length == 0) throw StateError('List is empty');
    replaceRange(length - 1, length, replacement);
  }

  void addIfAbsent(T element) {
    if (contains(element)) return;
    add(element);
  }

  void replaceFirst(Iterable<T> replacement) {
    if (length == 0) throw StateError('List is empty');
    replaceRange(0, 1, replacement);
  }
}
