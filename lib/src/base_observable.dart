/*
 * Copyright (C) 2020 Michael Krause
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class BaseObservable<T> extends Stream<T> implements Sink<T> {
  BaseObservable({required T value})
      : _valueStreamController = BehaviorSubject.seeded(value);

  final BehaviorSubject<T> _valueStreamController;

  @override
  void add(T data) => _valueStreamController.add(data);

  @override
  Future<void> close() async => await _valueStreamController.close();

  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _valueStreamController.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
