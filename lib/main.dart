import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_strings.dart';
import 'core/providers/database_providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MotorShopManagerApp(),
    ),
  );
}

class MotorShopManagerApp extends ConsumerWidget {
  const MotorShopManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final settingsAsync = ref.watch(businessSettingsStreamProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: settingsAsync.value?.shopName ?? strings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
