import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;
  final T model;
  final Function(T model) onModelReady;
  final VoidCallback onDispose;
  final VoidCallback onRefresh;

  const BaseView(
      {Key key,
      @required this.onModelReady,
      this.onDispose,
      @required this.builder,
      @required this.model,
      this.onRefresh})
      : super(key: key);
  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Store> extends State<BaseView<T>> {
  T model;
  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) widget.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, model);
  }
}
