import 'package:flutter/material.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:nigga_chat/app/app_constants.dart';
import 'package:nigga_chat/app/locator.dart';
import 'login_view_model/login_view_model.dart';



class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel _model;
  late String _value;

  @override
  void initState() {
    _model = locator<LoginViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (c) => _value = c,
            ),
            ModelConsumer<LoginViewState, LoginViewModel>(
              listener: (_, state) {
                if (state is LoadedState && !state.isNewUser)
                  Navigator.pushReplacementNamed(
                    context,
                    AppConstants.homeView
                  );
              },
              model: _model,
              builder: (context, state) {
                if (state is InitialState)
                  return ElevatedButton(
                      onPressed: () {
                        _model.add(
                          PhoneNumberVerifyEvent(phoneNumber: _value),
                        );
                      },
                      child: Text('Send Otp'));
                else if (state is LoadingState)
                  return CircularProgressIndicator();
                else if (state is AtOtpState)
                  return ElevatedButton(
                    onPressed: () {
                      _model.add(OtpVerifyEvent(otp: _value));
                    },
                    child: Text('Verify Otp'),
                  );
                  else if (state is LoadedState && state.isNewUser)
                  return ElevatedButton(
                    onPressed: () {
                      _model.add(SaveUserNameEvent(name: _value));
                    },
                    child: Text('Enter name'),
                  );
                else if (state is ErrorState)
                  return Text(state.error);
                else
                  return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
