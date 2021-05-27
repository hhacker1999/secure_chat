import 'package:flutter/material.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:nigga_chat/app/app_constants.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/views/startup_view/startup_view_model/startupviewmodel.dart';
import 'package:sizerutil/sizerutil.dart';

class StartupView extends StatelessWidget {
  final _model = locator<StartupViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeUtility.init(MediaQuery.of(context));
    return Scaffold(
      body: Center(
        child: ModelConsumer<StartupViewmodelState, StartupViewModel>(
          listener: (context, state) {
            if (state is StartupViewModelLoaded && state.isAuthenticated)
              Navigator.pushReplacementNamed(context, AppConstants.homeView);
            else if (state is StartupViewModelLoaded && !state.isAuthenticated)
              Navigator.pushReplacementNamed(context, AppConstants.loginView);
          },
          model: _model,
          builder: (_, state) => LinearProgressIndicator(),
        ),
      ),
    );
  }
}
