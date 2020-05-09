import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../configs/images.dart';
import '../../../../routes.dart';
import '../../../widgets/animated_rotation.dart';
import '../../../widgets/animated_slide.dart';
import '../../../widgets/pokemon_type.dart';
import 'decoration_box.dart';

class PokemonOverallInfo extends StatefulWidget {
  const PokemonOverallInfo();

  @override
  _PokemonOverallInfoState createState() => _PokemonOverallInfoState();
}

class _PokemonOverallInfoState extends State<PokemonOverallInfo>
    with TickerProviderStateMixin {
  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;

  static const double _appBarBottomPadding = 22.0;
  static const double _appBarHorizontalPadding = 28.0;
  static const double _appBarTopPadding = 60.0;

  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();
  PageController _pageController;
  AnimationController _rotateController;
  AnimationController _slideController;

  @override
  void didChangeDependencies() {
    if (_pageController == null) {
      // PokemonModel pokemonModel = PokemonModel.of(context);

      // _pageController = PageController(viewportFraction: 0.6, initialPage: pokemonModel.index);
      // _pageController.addListener(() {
      //   int next = _pageController.page.round();

      //   if (pokemonModel.index != next) {
      //     pokemonModel.setSelectedIndex(next);
      //   }
      // });
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _slideController?.dispose();
    _rotateController?.dispose();
    _pageController?.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 360));
    _slideController.forward();

    _rotateController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _rotateController.repeat();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final RenderBox targetTextBox = _targetTextKey.currentContext.findRenderObject();
    //   final targetTextPosition = targetTextBox.localToGlobal(Offset.zero);

    //   final currentTextBox =
    //       _currentTextKey.currentContext.findRenderObject() as RenderBox;
    //   final currentTextPosition = currentTextBox.localToGlobal(Offset.zero);

    //   textDiffLeft = targetTextPosition.dx - currentTextPosition.dx;
    //   textDiffTop = targetTextPosition.dy - currentTextPosition.dy;
    // });

    super.initState();
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.only(
        left: _appBarHorizontalPadding,
        right: _appBarHorizontalPadding,
        top: _appBarTopPadding,
        bottom: _appBarBottomPadding,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: Icon(Icons.arrow_back, color: Colors.white),
                onTap: AppNavigator.pop,
              ),
              Icon(Icons.favorite_border, color: Colors.white),
            ],
          ),
          // This widget just sit here for easily calculate the new position of
          // the pokemon name when the card scroll up
          Text(
            'Bulbasaur',
            key: _targetTextKey,
            style: TextStyle(
              color: Colors.transparent,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonName() {
    // final cardScrollController = Provider.of<AnimationController>(context);
    // final fadeAnimation =
    //     Tween(begin: 1.0, end: 0.0).animate(cardScrollController);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            // animation: cardScrollController,
            animation: ScrollController(),
            builder: (context, child) {
              // final double value = cardScrollController.value ?? 0.0;
              final value = 0.0;

              return Transform.translate(
                offset: Offset(textDiffLeft * value, textDiffTop * value),
                child: Hero(
                  tag: 'Pokemon name',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Bulbasaur', //pokemon.name,
                      key: _currentTextKey,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 36 - (36 - 22) * value,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // AnimatedFade(
          // animation: ScrollController(),
          // AnimatedSlide(
          // animation: _slideController,
          Hero(
            tag: '#001',
            child: Material(
              color: Colors.transparent,
              child: Text(
                '#001',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          // ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPokemonTypes() {
    // final cardScrollController = Provider.of<AnimationController>(context);
    // final fadeAnimation =
    //     Tween(begin: 1.0, end: 0.0).animate(cardScrollController);

    // return AnimatedFade(
    // animation: fadeAnimation,
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: ['Water', 'Dark']
                .map(
                  (type) => Hero(
                    tag: type,
                    child: PokemonType(type, large: true),
                  ),
                )
                .toList(),
          ),
          AnimatedSlide(
            animation: _slideController,
            child: Text(
              'Seed pokemon',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      // ),
    );
  }

  Widget _buildPokemonSlider() {
    final screenSize = MediaQuery.of(context).size;
    // final cardScrollController = Provider.of<AnimationController>(context);
    // final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(
    //   CurvedAnimation(
    //     parent: cardScrollController,
    //     curve: Interval(
    //       0.0,
    //       0.5,
    //       curve: Curves.ease,
    //     ),
    //   ),
    // );

    // final selectedIndex = PokemonModel.of(context).index;
    final selectedIndex = 0;

    // return AnimatedFade(
    // animation: fadeAnimation,
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.24,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedRotation(
              animation: _rotateController,
              child: Image(
                image: AppImages.pokeball,
                width: screenSize.height * 0.24,
                height: screenSize.height * 0.24,
                color: Colors.white.withOpacity(0.14),
              ),
            ),
          ),
          PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: 1,
            onPageChanged: (index) {
              // PokemonModel.of(context).setSelectedIndex(index);
            },
            itemBuilder: (context, index) => Hero(
              tag: 'pokemons[index].image',
              child: AnimatedPadding(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeOutQuint,
                padding: EdgeInsets.only(
                  top: selectedIndex == index ? 0 : screenSize.height * 0.04,
                  bottom: selectedIndex == index ? 0 : screenSize.height * 0.04,
                ),
                child: CachedNetworkImage(
                  imageUrl: 'pokemons[index].image',
                  imageBuilder: (context, image) => Image(
                    image: image,
                    width: screenSize.height * 0.28,
                    height: screenSize.height * 0.28,
                    alignment: Alignment.bottomCenter,
                    color: selectedIndex == index ? null : Colors.black26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }

  List<Widget> _buildDecorations() {
    final screenSize = MediaQuery.of(context).size;

    // final cardScrollController = Provider.of<AnimationController>(context);
    // final dottedAnimation =
    //     Tween(begin: 1.0, end: 0.0).animate(cardScrollController);

    final pokeSize = screenSize.width * 0.448;
    final pokeTop =
        -(pokeSize / 2 - (IconTheme.of(context).size / 2 + _appBarTopPadding));
    final pokeRight = -(pokeSize / 2 -
        (IconTheme.of(context).size / 2 + _appBarHorizontalPadding));

    return [
      // Positioned(
      //   top: pokeTop,
      //   right: pokeRight,
      //   child: AnimatedFade(
      //     // animation: cardScrollController,
      //     child: AnimatedRotation(
      //       animation: _rotateController,
      //       child: Image(
      //         image: AppImages.pokeball,
      //         width: pokeSize,
      //         height: pokeSize,
      //         color: Colors.white.withOpacity(0.26),
      //       ),
      //     ),
      //   ),
      // ),
      Positioned(
        top: -screenSize.height * 0.055,
        left: -screenSize.height * 0.055,
        child: DecorationBox(),
      ),
      // Positioned(
      //   top: 4,
      //   left: screenSize.height * 0.3,
      //   child: AnimatedFade(
      //     // animation: dottedAnimation,
      //     child: Image(
      //       image: AppImages.dotted,
      //       width: screenSize.height * 0.07,
      //       height: screenSize.height * 0.07 * 0.54,
      //       color: Colors.white.withOpacity(0.3),
      //     ),
      //   ),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // _buildAppBar(),
        SizedBox(height: 9),
        _buildPokemonName(),
        SizedBox(height: 9),
        _buildPokemonTypes(),
        SizedBox(height: 25),
        // _buildPokemonSlider(),
      ],
    );
  }
}
