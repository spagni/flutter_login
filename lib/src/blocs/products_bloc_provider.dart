import 'package:flutter/material.dart';
import 'products_bloc.dart';
export 'products_bloc.dart';

class ProductsBlocProvider extends InheritedWidget {
  final bloc;

  ProductsBlocProvider({Key key, Widget child})
    : bloc = ProductsBloc(),
      super(key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ProductsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProductsBlocProvider) as ProductsBlocProvider).bloc;
  }
}