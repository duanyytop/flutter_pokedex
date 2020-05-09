import 'dart:math' show max;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/fetch_state.dart';
import '../../../di/injection.dart';
import '../../../routes.dart';
import '../../widgets/fab.dart';
import '../../widgets/poke_container.dart';
import '../../widgets/pokemon_card.dart';
import 'modals/generation_modal.dart';
import 'modals/search_modal.dart';
import 'pokedex_bloc.dart';

part 'widgets/fab_menu.dart';
part 'widgets/fab_overlay_background.dart';
part 'widgets/header_app_bar.dart';
part 'widgets/pokemon_grid.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen();

  @override
  State<StatefulWidget> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen>
    with SingleTickerProviderStateMixin {
  static const double endReachedThreshold = 200;

  PokedexBloc _bloc;
  Animation<double> _fabAnimation;
  AnimationController _fabAnimationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    _fabAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _fabAnimationController,
    ));

    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_bloc == null) {
      _bloc = getIt<PokedexBloc>();
      _bloc.getPokemons();
      _bloc.fabMenu.stream.listen((isShowFab) {
        if (isShowFab) {
          _fabAnimationController.forward();
        } else {
          _fabAnimationController.reverse();
        }
      });
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    _fabAnimationController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final thresholdReached =
        _scrollController.position.extentAfter < endReachedThreshold;
    final state = _bloc.pokemonState.value;
    final isLoading = _bloc.pokemonState.loading;

    // Load more!
    if (thresholdReached &&
        !isLoading &&
        state is! EmptyState &&
        state is! ErrorState) {
      _bloc.getPokemons();
    }
  }

  Future _onRefresh() async {
    await _bloc.getPokemons(reset: true);
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchBottomModal(),
    );
  }

  void _showGenerationModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GenerationModal(),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 18, left: 26, right: 26, bottom: 4),
      child: Text(
        'Pokedex',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPokemonGrid() {
    return Expanded(
      child: StreamBuilder(
        stream: _bloc.pokemonState.stream,
        builder: (_, snapshot) => _PokemonGrid(
          fetchState: snapshot.data,
          controller: _scrollController,
          onRefresh: _onRefresh,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PokeballBackground(
        buildChildren: (props) {
          final appBarTop =
              props.size / 2 + props.top - IconTheme.of(context).size / 2;

          return [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _HeaderAppBar(top: appBarTop),
                _buildTitle(),
                _buildPokemonGrid(),
              ],
            ),
            _FabOverlayBackground(
              animation: _fabAnimation,
              onPressOut: _bloc.fabMenu.toggle,
            ),
          ];
        },
      ),
      floatingActionButton: _FabMenu(
        animation: _fabAnimation,
        toggle: _bloc.fabMenu.toggle,
        onAllGenPress: _showGenerationModal,
        onSearchPress: _showSearchModal,
      ),
    );
  }
}
