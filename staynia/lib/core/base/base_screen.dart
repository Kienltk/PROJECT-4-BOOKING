import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/log.dart';

abstract class BaseScreen<W extends StatefulWidget> extends State<W>
    with WidgetsBindingObserver {
  Map<Type, BaseCubit Function()> get cubitFactories => {};
  late final Map<Type, BaseCubit> _cubitInstances;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubitInstances = {
      for (final entry in cubitFactories.entries) entry.key: entry.value(),
    };
    onScreenCreated();
  }

  void onScreenCreated() => debug("CREATED");
  void debug(value) => Log.d(value, name: runtimeType.toString());
  T getCubit<T extends BaseCubit>() {
    final cubit = _cubitInstances[T];
    if (cubit == null) {
      throw Exception("Cubit $T chưa được khai báo trong cubitFactories.");
    }
    return cubit as T;
  }

  @override
  Widget build(BuildContext context) {
    if (_cubitInstances.isEmpty) {
      return buildScreen(context);
    }

    return MultiBlocProvider(
      providers: _cubitInstances.values
          .map((cubit) => BlocProvider<BaseCubit>.value(value: cubit))
          .toList(),
      child: Builder(
        builder: (context) {
          return buildScreen(context);
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debug(state);
  }

  @override
  void dispose() {
    for (final cubit in _cubitInstances.values) {
      cubit.close();
    }
    WidgetsBinding.instance.removeObserver(this);
    debug("DISPOSE");
    super.dispose();
  }

  Widget buildScreen(BuildContext context);
 
}
