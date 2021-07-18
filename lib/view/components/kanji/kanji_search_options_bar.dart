import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';

//TODO: Make buttons have an effect

class KanjiSearchOptionsBar extends StatelessWidget {
  const KanjiSearchOptionsBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _IconButton(
            icon: Text(
              "部",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            onPressed: () =>
                BlocProvider.of<KanjiBloc>(context).add(ReturnToInitialState()),
          ),
          _IconButton(
            icon: Icon(Icons.category),
            onPressed: () =>
                BlocProvider.of<KanjiBloc>(context).add(ReturnToInitialState()),
          ),
          _IconButton(
            icon: Icon(Icons.mode),
            onPressed: () =>
                BlocProvider.of<KanjiBloc>(context).add(ReturnToInitialState()),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget icon;
  final Function onPressed;
  const _IconButton({this.icon, this.onPressed, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: icon);
  }
}
