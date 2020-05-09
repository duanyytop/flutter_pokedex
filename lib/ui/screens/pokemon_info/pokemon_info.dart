import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../configs/colors.dart';
import '../../../di/injection.dart';
import '../../../domain/entities/pokemon.dart';
import 'pokemon_info_bloc.dart';
import 'widgets/decoration_box.dart';
import 'widgets/info.dart';
import 'widgets/tab.dart';

class PokemonInfo extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonInfo(this.pokemon);

  @override
  _PokemonInfoState createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo>
    with TickerProviderStateMixin {
  static const double _pokemonSlideOverflow = 20;

  final GlobalKey _pokemonInfoKey = GlobalKey();

  PokemonInfoBloc _bloc;
  AnimationController _cardController;
  AnimationController _cardHeightController;
  double _cardMinHeight = 0.0;

  @override
  void dispose() {
    _cardController.dispose();
    _cardHeightController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _cardController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _cardHeightController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 220),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;

      final RenderBox pokemonInfoBox =
          _pokemonInfoKey.currentContext.findRenderObject();

      _cardMinHeight = screenHeight - pokemonInfoBox.size.height;

      _cardHeightController.forward();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = getIt<PokemonInfoBloc>();
      _bloc.currentPokemon.add(widget.pokemon);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        StreamBuilder<Pokemon>(
          stream: _bloc.currentPokemon.stream,
          builder: (context, snapshot) => Container(
            width: 200,
            height: 200,
            constraints: BoxConstraints.expand(),
            color: snapshot?.data?.color ?? AppColors.teal,
          ),
        ),
        Positioned(
          top: -screenHeight * 0.055,
          left: -screenHeight * 0.055,
          child: DecorationBox(),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Test'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            // leading: Padding(
            //   padding: EdgeInsets.only(left: 28),
            //   child: Icon(Icons.arrow_back),
            // ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 28),
                child: Icon(Icons.favorite_border),
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: _cardHeightController,
                child: PokemonTabInfo(),
                builder: (context, child) {
                  final appBarHeight = Scaffold.of(context).appBarMaxHeight;
                  final cardMinHeight = max(_cardMinHeight - appBarHeight, 0);
                  final cardMaxHeight = screenHeight - appBarHeight;

                  return SlidingUpPanel(
                    minHeight: cardMinHeight * _cardHeightController.value,
                    maxHeight: cardMaxHeight,
                    boxShadow: null,
                    color: Colors.transparent,
                    panel: child,
                    // onPanelSlide: (position) => _cardHeightController.animateTo(position),
                  );
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  key: _pokemonInfoKey,
                  child: PokemonOverallInfo(),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // return Scaffold(
    //   body: StreamBuilder<Pokemon>(
    //     stream: _bloc.currentPokemon.stream,
    //     builder: (context, snapshot) {
    //       final pokemon = snapshot.data;

    //       if (pokemon == null) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }

    //       return Container(
    //         color: pokemon.color,
    //         child: Stack(
    //           children: <Widget>[
    //             // AnimatedBuilder(
    //             //   animation: _cardHeightController,
    //             //   child: PokemonTabInfo(),
    //             //   builder: (context, child) {
    //             //     return SlidingUpPanel(
    //             //       controller: ,
    //             //       minHeight: _cardMinHeight * _cardHeightController.value,
    //             //       maxHeight: _cardMaxHeight,_cardController
    //             //       child: child,
    //             //     );
    //             //   },
    //             // ),
    //             IntrinsicHeight(
    //               key: _pokemonInfoKey,
    //               child: PokemonOverallInfo(),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
