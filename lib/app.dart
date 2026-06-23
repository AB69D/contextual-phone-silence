import 'package:flutter/material.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/app_theme.dart';

class ContextualSilenceApp extends StatelessWidget {
  const ContextualSilenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Contextual Silence',
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
