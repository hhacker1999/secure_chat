import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nigga_chat/app/app_constants.dart';
import 'package:nigga_chat/views/chat_view/chat_view.dart';
import 'package:nigga_chat/views/homeview/homeview.dart';
import 'package:nigga_chat/views/login_view/login_view.dart';
import 'package:nigga_chat/views/startup_view/startup_view.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppConstants.startUpView:
      return MaterialPageRoute(builder: (context) => StartupView());
    case AppConstants.loginView:
      return MaterialPageRoute(builder: (context) => LoginView());
    case AppConstants.homeView:
      return MaterialPageRoute(builder: (context) => HomeView());
    case AppConstants.chatView:
      {
        log('chat view route called');
        ChatViewArguments _args = settings.arguments as ChatViewArguments;
        return MaterialPageRoute(
            builder: (context) => ChatView(
                  other: _args.other,
                  otherName: _args.otherName,
                ));
      }
    default:
      return MaterialPageRoute(builder: (context) => StartupView());
  }
}
