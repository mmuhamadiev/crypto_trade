import 'package:crypto_trade/Business/go_router.dart';
import 'package:crypto_trade/Business/token_receiver_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Data/constraints.dart';
import 'package:riverpod/riverpod.dart';
import 'Data/models/token_list_model.dart';

final riverpodTokenProvider = StateProvider<TokenReceiverRiverpod>((ref) => TokenReceiverRiverpod());
final riverpodSelectedTokensProvider = StateProvider<SelectedTokens>((ref) => SelectedTokens());
final riverpodStateProvider = StateProvider((ref) => false);
final riverpodSelectedCurrencyProvider = StateProvider((ref) => '');
final riverpodDateProvider = StateProvider((ref) => '');
final riverpodExchangeRateProvider = StateProvider<TokenExchangeRateRiverpod>((ref) => TokenExchangeRateRiverpod());
final riverpodRateAProvider = StateProvider((ref) => '');
final riverpodRateBProvider = StateProvider((ref) => '');

final listOfTokens = FutureProvider<List<TokenModel>>((ref) async{
  final data = ref.watch(riverpodTokenProvider).getDataDio();
  return data;
});

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouters route = GoRouters();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: materialButtonColor,
      ),
      routerConfig: route.router,
    );
  }
}

