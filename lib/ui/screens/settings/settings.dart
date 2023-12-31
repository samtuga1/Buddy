import 'package:Buddy/injectable/injection.dart';
import 'package:Buddy/interfaces/shared_preferences.interface.dart';
import 'package:Buddy/router/routes.dart';
import 'package:Buddy/utils/utils.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () => UiUtils.customDialog(
                  context,
                  title: 'Are you sure you want to logout ?',
                  'You will be required to log in when you open Buddy app again',
                  onTap: () {
                    getIt<ISharedPreference>().clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.signin_signup,
                      (route) => false,
                    );
                  },
                ),
            child: const Text('sign out')),
      ],
    );
  }
}
