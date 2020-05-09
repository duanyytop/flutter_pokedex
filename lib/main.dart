import 'package:flutter/material.dart';

import 'app.dart';
import 'data/source/local/local_datasource.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection();

  await LocalDataSource.initialize();

  runApp(PokedexApp());
}
