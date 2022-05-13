import 'package:array_object_adapter/array_object_adapter.dart';
import 'package:flutter/material.dart';

import 'sample_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Array Any Adapter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Array Any Adapter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ArrayObjectAdapter _adapter;

  @override
  void initState() {
    _adapter = ArrayObjectAdapter(
        presenterSelector: ClassPresenterSelector()
          ..addClassPresenter(SampleItemA, SampleAPresenter())
          ..addClassPresenter(SampleItemB, SampleBPresenter())
          ..addClassPresenter(SampleItemC, SampleCPresenter(onItemClicked)));
    _seedAdapter();
    super.initState();
  }

  void onItemClicked(dynamic item){
    print("item has been clicked: $item");
  }

  void _seedAdapter() {
    final items = <dynamic>[];
    for (int i = 0; i < 100; i++) {
      if(i % 2 == 0){
        items.add(SampleItemA(i, 'A $i'));
      } else if(i % 3 == 0) {
        items.add(SampleItemC(i, 'C $i'));
      } else {
        items.add(SampleItemB(i, i));
      }
    }
    _adapter.setItems(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ListView.separated(
            itemCount: _adapter.itemCount(),
            itemBuilder: (BuildContext context, int index) {
              final item = _adapter.get(index);
              final presenter = _adapter.getPresenter(item);
              return presenter.createView(context, item);
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
          ),
        ));
  }
}

class SampleAPresenter extends Presenter {
  @override
  Widget createView(BuildContext context, Object item) {
    final value = item as SampleItemA;
    return Text(
      value.value,
      style: TextStyle(color: Colors.green),
    );
  }
}

class SampleBPresenter extends Presenter {
  @override
  Widget createView(BuildContext context, Object item) {
    final value = item as SampleItemB;
    return Text(
      value.value.toString(),
      style: TextStyle(color: Colors.blue),
    );
  }
}

typedef EventHandler = void Function(dynamic item);

class SampleCPresenter extends Presenter {

  SampleCPresenter(this.callback);

  EventHandler callback;

  @override
  Widget createView(BuildContext context, Object item) {
    final value = item as SampleItemC;
    return GestureDetector(
      onTap: () => callback.call(item),
      child: Text(
        value.value,
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
