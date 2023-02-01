import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Data/constraints.dart';
import '../Data/models/token_list_model.dart';
import '../main.dart';

class SelectedTokens {
  Set<TokenModel> selectedTokenA = {};
  Set<TokenModel> selectedTokenB = {};

  void addValueToSelectedTokenA(value, BuildContext context, WidgetRef ref) {
    if (selectedTokenA.isEmpty) {
      if (selectedTokenB.isEmpty) {
        selectedTokenA.clear();
        selectedTokenA.add(value);
        ref.read(riverpodStateProvider.notifier).update((state) => !state);
        Navigator.of(context).pop();
      } else {
        if (selectedTokenB.first.symbol !=
            value.symbol) {
          selectedTokenA.clear();
          selectedTokenA.add(value);
          ref.read(riverpodStateProvider.notifier).update((state) => !state);
          Navigator.of(context).pop();
        } else {
          return;
        }
      }
    } else if (selectedTokenA.isNotEmpty &&
        selectedTokenB.isEmpty) {
      if (selectedTokenA.first.symbol!= value.symbol) {
        selectedTokenA.clear();
        selectedTokenA.add(value);
        ref.read(riverpodStateProvider.notifier).update((state) => !state);
        Navigator.of(context).pop();
      } else {
        return;
      }
    } else if (selectedTokenA.isNotEmpty &&
        selectedTokenB.isNotEmpty) {
      if (selectedTokenA.first.symbol != value.symbol) {
        if (selectedTokenB.first.symbol !=
            value.symbol) {
          selectedTokenA.clear();
          selectedTokenA.add(value);
          ref.read(riverpodStateProvider.notifier).update((state) => !state);
          Navigator.of(context).pop();
        } else {
          return;
        }
      } else {
        return;
      }
    }
  }

  void addValueToSelectedTokenB(value, BuildContext context, WidgetRef ref) {
    if (selectedTokenB.isEmpty) {
      if (selectedTokenA.isEmpty) {
        selectedTokenB.clear();
        selectedTokenB.add(value);
        ref.read(riverpodStateProvider.notifier).update((state) => !state);
        Navigator.of(context).pop();
      } else {
        if (selectedTokenA.first.symbol !=
            value.symbol) {
          selectedTokenB.clear();
          selectedTokenB.add(value);
          ref.read(riverpodStateProvider.notifier).update((state) => !state);
          Navigator.of(context).pop();
        } else {
          return;
        }
      }
    } else if (selectedTokenB.isNotEmpty &&
        selectedTokenA.isEmpty) {
      if (selectedTokenB.first.symbol != value.symbol) {
        selectedTokenB.clear();
        selectedTokenB.add(value);
        ref.read(riverpodStateProvider.notifier).update((state) => !state);
        Navigator.of(context).pop();
      } else {
        return;
      }
    } else if (selectedTokenA.isNotEmpty &&
        selectedTokenB.isNotEmpty) {
      if (selectedTokenB.first.symbol != value.symbol) {
        if (selectedTokenA.first.symbol !=
            value.symbol) {
          selectedTokenB.clear();
          selectedTokenB.add(value);
          ref.read(riverpodStateProvider.notifier).update((state) => !state);
          Navigator.of(context).pop();
        } else {
          return;
        }
      } else {
        return;
      }
    }
  }
}

class TokenReceiverRiverpod {

  final Dio _dio = Dio();

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  Future<List<TokenModel>> getDataDio() async {
    isLoading = true;
    List<TokenModel> tokens = [];
    try {
      final response = await _dio.get(tokenListUrl);
      var res = response.data;
      var data = res['tokens'] as List;
      tokens =
          data.map<TokenModel>((token) => TokenModel.fromJson(token)).toList();
      isLoading = false;
      return tokens;
    } on DioError catch (e) {
      errorMessage = e.response!.data['message'];
      hasError = true;
      isLoading = false;
    }
      isLoading = false;
    return tokens;
  }

}

class TokenExchangeRateRiverpod {

  double? exchangeRateA;
  double? exchangeRateB;
  final Dio _dio = Dio();
  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  Future<Set<double>> getDataDio(String addressA, String addressB, currency) async {
    var tokenAddress = 'contract_addresses=';
    var exchangeCurrency = '&vs_currencies=';
    late double exchangeResultA;
    late double exchangeResultB;

    Set<double> exchangeRates = {};

      isLoading = true;
    try {
      final responseA = await _dio.get(exchangeRateUrl +
          tokenAddress +
          addressA +
          exchangeCurrency +
          currency!);
      var resA = responseA.data;
      Map<String, dynamic> mapA = resA;
      mapA.forEach((key, value) {
        exchangeResultA = value[currency];
      });

      exchangeRateA = exchangeResultA;
      final responseB = await _dio.get(exchangeRateUrl +
          tokenAddress +
  addressB +
          exchangeCurrency +
          currency!);
      var resB = responseB.data;
      Map<String, dynamic> mapB = resB;
      mapB.forEach((key, value) {
        exchangeResultB = value[currency];
      });

      exchangeRateB = exchangeResultB;
      exchangeRates.add(exchangeResultA);
      exchangeRates.add(exchangeResultB);
      return exchangeRates;

    } on DioError catch (e) {
      errorMessage = e.response!.data['message'];
      hasError = true;
      isLoading = false;
    }
      isLoading = false;
    exchangeRateA = exchangeResultA;
    exchangeRateB = exchangeResultB;
    return exchangeRates;
  }

}