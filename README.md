# Array Object Adapter

Adapter that is similar to the ObjectAdapter (ArrayObjectAdapter) from the Android Leanback support library.

## Getting started
You should ensure that you add the `array_object_adapter` as a dependency in your flutter project.

``` yml
dependencies:
    array_object_adapter: ^0.0.2
```
 
You should then run flutter packages upgrade or update your packages in IntelliJ.

## Example Project

There is a pretty sweet example project in the example folder. Check it out. Otherwise, keep reading to get up and running.

## Adapter 

An array-based data source that provides access to a data model and is decoupled from the presentation of the items via Presenter/PresenterSelector.
As the adapter implements the dart stream interface, you can simply observe the data set.
```dart 
adapter.listen((_) { 
    // data set changed
});
```

```dart

@override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _adapter,
      builder: (context, snapshot) {},);
  } 
```

## Presenter

Split presenter logic from adapter logic. Presenter that will create Views/Widgets and bind object.

```dart
/// A simple example where a string is represented as a text widget.
/// But imagine for example a user object, which is represented with a thumbnail, name and address etc.
class TextPresenter extends Presenter {
  
  @override
  Widget createView(BuildContext context, Object item) {
    final value = item as String;
    return Text(value);
  }
}
```

To use multiple viewTypes use PresenterSelector.

```dart
final classPresenterSelector = ClassPresenterSelector()
      ..addClassPresenter(int, IntPresenter())
      ..addClassPresenter(String, TextPresenter());

final adapter = ArrayObjectAdapter(presenterSelector: classPresenterSelector);

final items = <dynamic>[];
// create your content
...

adapter.setItems(items);
```

Attach an adapter for the data to displayed to your view

````dart
@override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: adapter.itemCount(),
      itemBuilder: (BuildContext context, int index) {
        final item = adapter.get(index);
        final presenter = adapter.getPresenter(item);
        return presenter.createView(context, item);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }
````






