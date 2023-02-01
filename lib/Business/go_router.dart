import 'package:crypto_trade/UI/pages/currency_page.dart';
import 'package:crypto_trade/UI/pages/exchange_rate_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../UI/pages/main_menu.dart';
import '../UI/pages/not_found_page.dart';

class GoRouters {
  // GoRouter configuration
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: '/',
        builder: (context, state) {
          FlutterNativeSplash.remove();
          return MainMenu();
        },
      ),
      GoRoute(
        name: '/currency',
        path: '/currency',
        builder: (context, state) {
          return CurrencyPage();
        },
      ),
      GoRoute(
        name: '/exchange',
        path: '/exchange',
        builder: (context, state) {
          return ExchangeRatePage();
        },
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
