import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/current_user_notifier.dart';
import 'package:frontend/features/auth/view/pages/home_page.dart';
import 'package:frontend/features/auth/view/pages/signup_page.dart';
import 'package:frontend/core/theme/theme.dart';
import 'package:frontend/features/auth/viewmodel/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  await container.read(authViewModelProvider.notifier).initSharedPreferences();

  await container.read(authViewModelProvider.notifier).getData();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);

    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: currentUser == null ? SignUpPage() : HomePage(),
    );
  }
}
