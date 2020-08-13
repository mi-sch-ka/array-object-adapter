# Array Object Adapter

Adapter that is similar to the ObjectAdapter (ArrayObjectAdapter) from the Android Leanback support library.

## Getting started
You should ensure that you add the `array_object_adapter` as a dependency in your flutter project.

``` yml
dependencies:
    array_object_adapter: ^0.0.1
```
 
You should then run flutter packages upgrade or update your packages in IntelliJ.

## Example Project

There is a pretty sweet example project in the example folder. Check it out. Otherwise, keep reading to get up and running.

## Presenter

Split presenter logic from adapter logic. Presenter that will create Views/Widgets and bind object.

## Adapter 

An array-based data source that provides access to a data model and is decoupled from the presentation of the items via Presenter/PresenterSelector.