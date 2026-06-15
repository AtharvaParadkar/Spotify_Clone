import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/current_user_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text('data')),
      backgroundColor: Colors.black,
      body: Center(child: Text("$user")),
    );
  }
}
