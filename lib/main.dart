import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poked3x/common/utils/color_utils.dart';
import 'package:poked3x/presentation/viewmodels/main_viewmodel.dart';
import 'package:poked3x/route_config.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainViewmodel()..fetchPokemonList(),
      child: MaterialApp.router(
        title: 'Pokedex',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: fromHex("#6C79DB")),
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme()),
        routerConfig: routeConfig,
      ),
    );
  }
}
