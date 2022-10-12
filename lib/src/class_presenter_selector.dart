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
import 'dart:collection';

import 'package:array_object_adapter/src/no_presenter.dart';
import 'package:array_object_adapter/src/presenter.dart';
import 'package:array_object_adapter/src/presenter_selector.dart';

/// A ClassPresenterSelector selects a [Presenter] based on the item's type.
class ClassPresenterSelector implements PresenterSelector {
  final List<Presenter> _presenters = [];

  final HashMap<Type, Object> _typeMap = HashMap();

  /// Sets a presenter to be used for the given type.
  ClassPresenterSelector addClassPresenter(Type type, Presenter presenter) {
    _typeMap[type] = presenter;
    if (!_presenters.contains(presenter)) {
      _presenters.add(presenter);
    }
    return this;
  }

  /// Sets a presenter selector to be used for the given class.
  ClassPresenterSelector addClassPresenterSelector(
      Type type, PresenterSelector presenterSelector) {
    _typeMap[type] = presenterSelector;
    var innerPresenters = presenterSelector.presenters;
    innerPresenters.forEach((presenter) {
      if (!_presenters.contains(presenter)) {
        _presenters.add(presenter);
      }
    });
    return this;
  }

  @override
  List<Presenter> get presenters => _presenters;

  @override
  Presenter? getPresenter(item) {
    var type = item.runtimeType;
    var presenter;
    do {
      presenter = _typeMap[type];
      if (presenter is PresenterSelector) {
        var innerPresenter = presenter.getPresenter(item);
        if (innerPresenter is! NoPresenter) {
          return innerPresenter;
        }
      }
    } while (presenter == null);
    presenter = presenter ?? NoPresenter();
    return presenter as Presenter;
  }
}
