import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:soccer_life/core/errors/failures.dart';

/// Base provider that handles the repetitive loading / error / data lifecycle
/// shared by all data-fetching providers.
abstract class AsyncProvider<T> extends ChangeNotifier {
  List<T> _data = [];
  bool _isLoading = false;
  String? _error;

  List<T> get data => _data;
  bool get isLoading => _isLoading;
  String? get error => _error;

  @protected
  Future<void> run(Future<Either<Failure, List<T>>> future) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await future;
    result.fold((f) => _error = f.message, (d) => _data = d);

    _isLoading = false;
    notifyListeners();
  }
}
