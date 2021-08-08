import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';

import 'package:jisho_study_tool/view/components/kanji/kanji_grid.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_search_bar.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_search_options_bar.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _searchbarMovementAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _searchbarMovementAnimation = AlignmentTween(
      begin: Alignment.center,
      end: Alignment.topCenter,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: AnimatedBuilder(
          animation: _searchbarMovementAnimation,
          builder: (BuildContext context, _) {
            return Container(
              alignment: _searchbarMovementAnimation.value,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus)
                        _controller.forward();
                      else
                        _controller.reverse();
                    },
                    child: KanjiSearchBar(),
                  ),
                  BlocBuilder<KanjiBloc, KanjiState>(
                    builder: (context, state) {
                      return AnimatedSizeAndFade(
                        vsync: this,
                        child: _controller.value == 1
                            ? KanjiGrid((state is KanjiSearchKeyboard)
                                ? state.kanjiSuggestions
                                : [])
                            // ? Container()
                            : KanjiSearchOptionsBar(),
                        fadeDuration: const Duration(milliseconds: 200),
                        sizeDuration: const Duration(milliseconds: 300),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}