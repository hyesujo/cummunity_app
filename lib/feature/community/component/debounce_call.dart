import 'dart:async';
import 'dart:collection';

class DebouncedCall {
  const DebouncedCall._();

  static final _syncKeys = HashSet<int>();

  /// [hashCode]는 기능을 막고 싶은 범위에 해당하는 위젯의 hashcode이다.
  /// [blockingTime] 동안 [func]의 재호출을 막아준다.
  /// 그 동안 재호출될 경우, null을 반환한다.
  static FutureOr<T>? processSync<T>(
    final FutureOr<T>? Function() func,
    final int hashCode, {
    final Duration blockingTime = const Duration(milliseconds: 300),
  }) {
    if (_syncKeys.contains(hashCode)) {
      return null;
    }
    _syncKeys.add(hashCode);
    Timer(blockingTime, () => _syncKeys.remove(hashCode));
    return func();
  }
}
