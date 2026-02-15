import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Debug-only Riverpod observer that logs provider lifecycle events.
class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('[Riverpod] CREATED: ${provider.name ?? provider.runtimeType}');
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint(
        '[Riverpod] DISPOSED: ${provider.name ?? provider.runtimeType}',
      );
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint(
        '[Riverpod] UPDATED: ${provider.name ?? provider.runtimeType}',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint(
        '[Riverpod] ERROR: ${provider.name ?? provider.runtimeType} -> $error',
      );
    }
  }
}
