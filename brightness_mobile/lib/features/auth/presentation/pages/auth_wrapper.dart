import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigation/main_navigation_controller.dart';
import '../../data/sources/auth_remote_data_source.dart';
import 'login_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late final Future<bool> _isLoggedInFuture;

  @override
  void initState() {
    super.initState();
    _isLoggedInFuture = _checkLoginStatus();
  }

  Future<bool> _checkLoginStatus() {
    final authDataSource = Provider.of<AuthRemoteDataSource>(context, listen: false);
    return authDataSource.isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedInFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return const MainNavigationController();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
