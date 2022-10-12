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
import 'package:array_object_adapter/src/presenter.dart';
import 'package:array_object_adapter/src/presenter_selector.dart';

/// A [PresenterSelector] that always returns the same [Presenter].
/// Useful for rows of items of the same type that are all rendered the same way.
class SinglePresenterSelector implements PresenterSelector {
  SinglePresenterSelector(this._presenter);

  final Presenter _presenter;

  @override
  List<Presenter> get presenters => [_presenter];

  @override
  Presenter getPresenter(item) => _presenter;
}
