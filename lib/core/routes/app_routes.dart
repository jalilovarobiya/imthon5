import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:imthon5/feature/auth/presentation/screen/login_page.dart';
import 'package:imthon5/feature/auth/presentation/screen/register_page.dart';
import 'package:imthon5/feature/auth/presentation/screen/splash_screen.dart';
import 'package:imthon5/feature/chat/presentation/screen/gimini_screen.dart';

class AppRoutes {
  static String splash = '/splash';
  static String register = '/register';
  static String login = '/login';
  static String main = '/main';
  // static String details = "/home/details/:id";
  // static String settings = "/login/settings";

  static final router = GoRouter(
    initialLocation: splash,

    // errorBuilder: (context, state) => ErrorScreen(),
    routes: [
      GoRoute(
        path: splash,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: SplashScreen(),
              transitionsBuilder: (context, animation, animation2, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
      ),
      GoRoute(
        path: register,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: RegisterPage(),
              transitionsBuilder: (context, animation, animation2, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
      ),
      GoRoute(
        path: login,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: LoginPage(),
              transitionsBuilder: (context, animation, animation2, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
      ),
      GoRoute(
        path: main,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: GiminiScreen(),
              transitionsBuilder: (context, animation, animation2, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
      ),
    ],
  );

  // GoRoute(
  //   path: details,
  //   builder: (context, state) {
  //     final id = state.pathParameters['id']!;
  //     return DetailsScreen(id: id);
  //   },
  // ),

  // GoRoute(
  //   path: settings,
  //   pageBuilder:
  //       (context, state) => CustomTransitionPage(
  //         key: state.pageKey,
  //         child: SettingsScreen(),
  //         transitionsBuilder: (context, animation, animation2, child) {
  //           return FadeTransition(opacity: animation, child: child);
  //         },
  //       ),
  // ),
}
