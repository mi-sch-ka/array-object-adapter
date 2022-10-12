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

abstract class BaseItem<T> {
  BaseItem({required this.id, required this.value});

  int id;
  T value;
}

class SampleItemA extends BaseItem<String> {
  SampleItemA(int id, String value) : super(id: id, value: value);
}

class SampleItemB extends BaseItem<int> {
  SampleItemB(int id, int value) : super(id: id, value: value);
}

class SampleItemC extends BaseItem<String> {
  SampleItemC(int id, String value) : super(id: id, value: value);
}
