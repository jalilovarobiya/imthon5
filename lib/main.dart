import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imthon5/core/routes/app_routes.dart';

const apiKey = "AIzaSyCGuk4NBdYIvrKeGDQtcPDBgVnFsHitiTU";

void main() {
  Gemini.init(apiKey: apiKey);
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
    );
  }
}
