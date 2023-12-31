import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user_provider.dart';
import '../components/text_and_color.dart';
import '../widgets/common_bars.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);
    return Scaffold(
      appBar: CommonAppBarWidget(),
      bottomNavigationBar: const CommonbottomBarWidget(),
      backgroundColor: blueBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            asyncUser.when(
              data: (user) {
                return (user != null)
                    ? Column(
                        children: [
                          Text('You are now logged in as anonymous user',
                              style: menuSubTitleTextStyle),
                          const SizedBox(height: 40),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.login),
                            label: const Text('Logout'),
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text('You are currently logged out',
                              style: menuSubTitleTextStyle),
                          const SizedBox(height: 10),
                          Text(
                              'Press login to create, delete and add favourite recipes',
                              style: hintTextStyle),
                          const SizedBox(height: 40),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.login),
                            label: const Text('Login'),
                            onPressed: () async {
                              await FirebaseAuth.instance.signInAnonymously();
                            },
                          ),
                        ],
                      );
              },
              error: (error, stackTrace) {
                return const Center(child: Text("Something went wrong.."));
              },
              loading: () {
                return const Center(child: Text("Loading..."));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.home),
              label: const Text('Home'),
              onPressed: () async {
                context.go('/');
              },
            )
          ],
        ),
      ),
    );
  }
}
