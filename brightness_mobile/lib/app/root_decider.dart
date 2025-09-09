import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';

class RootDecider extends StatefulWidget {
  const RootDecider({super.key});

  @override
  State<RootDecider> createState() => _RootDeciderState();
}

class _RootDeciderState extends State<RootDecider> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _decideAndNavigate();
    });
  }

  void _decideAndNavigate() {
    final login = context.read<LoginController>();

    // TODO: extend with persisted token/onboarding flag when available.
    final bool isLoggedIn = login.token != null;

    final target = isLoggedIn ? '/home' : '/home'; // default Home first

    Navigator.of(context).pushReplacementNamed(target);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}