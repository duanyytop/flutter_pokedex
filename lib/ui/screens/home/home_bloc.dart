import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/bloc.dart';
import '../../../core/bloc_state.dart';

part 'blocs/app_bar.dart';

@injectable
class HomeBloc extends Bloc {
  final _AppBarState appBar = _AppBarState();

  @override
  void dispose() {
    appBar.dispose();
  }
}
