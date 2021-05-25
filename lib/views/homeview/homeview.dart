import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/views/homeview/home_view_model/homeviewmodel.dart';

class HomeView extends StatelessWidget {
  final Homeviewmodel _model = locator<Homeviewmodel>();
  @override
  Widget build(BuildContext context) {
    return ModelListener<HomeviewmodelState, Homeviewmodel>(
      listener: (_, state) {
        if (state is HomeviewLoadedwithData) log(state.model.length.toString());
      },
      model: _model,
      child: Scaffold(
        body: Center(
          child: ModelBuilder<HomeviewmodelState, Homeviewmodel>(
              model: _model,
              builder: (context, state) {
                if (state is HomeviewmodelLoading)
                  return CircularProgressIndicator();
                else
                  return Icon(Icons.home);
              }),
        ),
      ),
    );
  }
}
