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
import 'package:array_object_adapter/src/base_observable.dart';
import 'package:array_object_adapter/src/no_presenter.dart';
import 'package:array_object_adapter/src/presenter.dart';
import 'package:array_object_adapter/src/presenter_selector.dart';
import 'package:array_object_adapter/src/single_presenter_selector.dart';
import 'package:flutter/widgets.dart';

/// Provides access to a data model and is
/// decoupled from the presentation of the items via [PresenterSelector].
class ArrayObjectAdapter extends BaseObservable<dynamic> {
  ArrayObjectAdapter({@required PresenterSelector presenterSelector})
      : _presenterSelector = presenterSelector;

  ArrayObjectAdapter.from({@required Presenter presenter})
      : _presenterSelector = SinglePresenterSelector(presenter);

  final PresenterSelector _presenterSelector;

  final List<dynamic> _items = [];

  int itemCount() => _items.length;

  Type getItemViewType(int index) {
    var item = get(index);
    return item.runtimeType;
  }

  dynamic get(int position) {
    return _items[position];
  }

  void setItems(List<dynamic> newItems) {
    _items.clear();
    _items.addAll(newItems);
  }

  void insert(int index, dynamic item) {
    _items.insert(index, item);
  }

  void addItem(dynamic item) {
    _items.add(item);
    add(_items);
  }

  void clear() {
    _items.clear();
    add(_items);
  }

  Presenter getPresenter(dynamic item) =>
      _presenterSelector.getPresenter(item) ?? NoPresenter();
}
