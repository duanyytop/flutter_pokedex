part of '../pokedex_bloc.dart';

class _FabMenuBlocState extends BlocState<bool> {
  _FabMenuBlocState() : super(defaultValue: false);

  bool get isShowFab => value;

  void toggle() => add(!isShowFab);
}
