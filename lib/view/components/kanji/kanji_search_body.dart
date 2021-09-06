import 'package:flutter/material.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:jisho_study_tool/services/kanji_suggestions.dart';

import 'package:jisho_study_tool/view/components/kanji/kanji_search_body/kanji_grid.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_search_body/kanji_search_bar.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_search_body/kanji_search_options_bar.dart';

class KanjiSearchBody extends StatefulWidget {
  KanjiSearchBody({Key? key}) : super(key: key);

  @override
  _KanjiSearchBodyState createState() => _KanjiSearchBodyState();
}

class _KanjiSearchBodyState extends State<KanjiSearchBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _searchbarMovementAnimation;
  final FocusNode focus = FocusNode();
  final GlobalKey<KanjiSearchBarState> _kanjiSearchBarState =
      GlobalKey<KanjiSearchBarState>();
  List<String> suggestions = [];

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
    return WillPopScope(
      onWillPop: () async {
        if (_controller.value == 1) {
          focus.unfocus();
          _kanjiSearchBarState.currentState!.clearText();
          return false;
        }
        return true;
      },
      child: GestureDetector(
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
                      focusNode: focus,
                      onFocusChange: (hasFocus) {
                        if (hasFocus)
                          _controller.forward();
                        else
                          _controller.reverse();
                      },
                      child: KanjiSearchBar(
                        key: _kanjiSearchBarState,
                        onChanged: (text) => setState(() {
                          this.suggestions = kanjiSuggestions(text);
                        }),
                      ),
                    ),
                    AnimatedSizeAndFade(
                      vsync: this,
                      child: _controller.value == 1
                          ? KanjiGrid(this.suggestions)
                          : KanjiSearchOptionsBar(),
                      fadeDuration: const Duration(milliseconds: 200),
                      sizeDuration: const Duration(milliseconds: 300),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
