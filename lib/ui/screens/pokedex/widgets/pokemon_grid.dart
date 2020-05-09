part of '../pokedex.dart';

class _PokemonGrid extends StatelessWidget {
  _PokemonGrid({
    Key key,
    @required this.fetchState,
    @required this.controller,
    @required this.onRefresh,
  }) : super(key: key);

  final ScrollController controller;
  final FetchState fetchState;
  final Future Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final state = fetchState;

    // show when opening screen
    if (state == null || state is InitialState) {
      return Center(child: CircularProgressIndicator());
    }

    // show when the data is loaded
    if (state is SuccessState) {
      final bottomOffset = MediaQuery.of(context).padding.bottom;
      final paddingBottom = max(bottomOffset, 28);

      return CustomScrollView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
          SliverPadding(
            padding: EdgeInsets.all(28),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => PokemonCard(
                  state.data[index],
                  index: index,
                  onPress: () =>
                      AppNavigator.push(Routes.pokemonInfo, state.data[index]),
                ),
                childCount: state.data?.length ?? 0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: state.canLoadMore
                ? Container(
                    padding: EdgeInsets.only(bottom: paddingBottom),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(),
          ),
        ],
      );
    }

    // show when no data to display
    if (state is EmptyState) {
      return Text('No data');
    }

    // show when any error occured
    if (state is ErrorState) {
      return Center(
        child: Text('Error'),
      );
    }

    // default case
    return Center(
      child: Text('Unknown Error'),
    );
  }
}
