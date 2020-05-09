import 'package:flutter/material.dart';

import 'configs/colors.dart';
import 'routes.dart';

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'CircularStd',
        textTheme: theme.textTheme.apply(
          fontFamily: 'CircularStd',
          displayColor: AppColors.black,
        ),
        scaffoldBackgroundColor: AppColors.lightGrey,
        primarySwatch: Colors.blue,
      ),
      navigatorKey: AppNavigator.instance().navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
    );
  }
}
