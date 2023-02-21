import 'package:crypto_trade/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Data/constraints.dart';
import '../../Data/models/token_list_model.dart';
import 'main_menu.dart';

final selectedTokenAddressA = Provider((ref) {
  final data = ref.watch(riverpodSelectedTokensProvider).selectedTokenA.first.address;
  return data;
});

final selectedTokenAddressB = StateProvider((ref) {
  final data = ref.watch(riverpodSelectedTokensProvider).selectedTokenB.first.address;
  return data;
});

final currency = Provider((ref) {
  final data = ref.watch(riverpodSelectedCurrencyProvider);
  return data;
});

final setOfExchangeRate = FutureProvider<Set<double>>((ref) async{
  var a = ref.watch(selectedTokenAddressA);
  var b = ref.watch(selectedTokenAddressB);
  var c = ref.watch(currency);
  final data = ref.watch(riverpodExchangeRateProvider).getDataDio(a, b, c);
  return data;
});



class ExchangeRatePage extends ConsumerStatefulWidget {
  const ExchangeRatePage({Key? key,}) : super(key: key);

  @override
  ConsumerState<ExchangeRatePage> createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends ConsumerState<ExchangeRatePage> {

  TextEditingController controllerA = TextEditingController();
  TextEditingController controllerB = TextEditingController();

  String convertTokensExchangeRate(double a, double b, double amount) {
    if (amount == 0.0) {
      return '';
    }
    else {
      var result = (b / (a * amount)).toStringAsFixed(3);
      return result;
    }
  }

  @override
  void initState() {
    super.initState();
    controllerA = TextEditingController(text: '1');
  }

  @override
  Widget build(BuildContext context) {

    final selectedTokenA = ref.watch(mainMenuStateSelectedTokenA);
    final selectedTokenB = ref.watch(mainMenuStateSelectedTokenB);
    var date = ref.watch(riverpodDateProvider);
    var currency = ref.watch(riverpodSelectedCurrencyProvider);

    final exchange = ref.watch(setOfExchangeRate);

    final topStatusBarHeight = MediaQuery
        .of(context)
        .viewPadding
        .top;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;

    final double scale = width / mockUpWidth;
    final double bigTextScaleFactor = scale * 2.2;
    final double mediumTextScaleFactor = scale * 1.3;
    final double smallTextScaleFactor = scale * 1.1;
    final double iconScaleSize = scale * 2.2;
    final double marginSize = scale * 30;
    final double imageHeightSize = scale * 30;


    return exchange.when(error: (err, stack) =>
        Material(child: Center(child: Text('Error: $err'))),
        loading: () =>
            const Material(child: Center(child: CircularProgressIndicator())),
        data: (rate) {
          if (controllerA.text.isEmpty) {
            controllerB = TextEditingController(text: convertTokensExchangeRate(
                rate.last,
                rate.first, 0.0));
          }
          else if(controllerA.text == '1'){
            controllerB = TextEditingController(text: convertTokensExchangeRate(
                rate.last,
                rate.first,
                double.parse(controllerA.text)));
          }
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              backgroundColor: backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height * 0.1,
                      margin:
                      EdgeInsets.only(top: topStatusBarHeight, left: scale * 15),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new)),
                    ),
                    Container(
                      height: height * 0.3,
                      margin: EdgeInsets.only(
                          top: scale * 15.0, left: marginSize),
                      child: Text(
                        'Last exchange date: $date',
                        textScaleFactor: bigTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,),
                      ),
                    ),
                    Column(
                      children: [
                        tokenCustomContainer(
                            selectedTokenA.first,
                            currency.toString(),
                      TextField(
                              controller: controllerA,
                              onChanged: (value) {
                                if (value == null || value == '') {
                                  setState(() {
                                    controllerB = TextEditingController(text: '');
                                  });
                                }
                                else {
                                  setState(() {
                                    controllerB.clear();
                                    var result = convertTokensExchangeRate(
                                        rate.last,
                                        rate.first,
                                        double.parse(value));
                                    controllerB = TextEditingController(
                                        text: result.toString());
                                  });
                                }
                              },
                              style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.w400, fontSize: scale * 20,
                              ),
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              textAlign: TextAlign.end,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'^(\d+)?\.?\d{0,2}'),),
                              ],
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '0.0'
                              ),
                            ),
                            rate.first.toString(),
                            scale,
                            marginSize,
                            imageHeightSize,
                            mediumTextScaleFactor,
                            smallTextScaleFactor,),

                        Center(
                          child: Icon(
                            Icons.arrow_downward,
                            size: iconScaleSize,
                          ),
                        ),
                        tokenCustomContainer(
                            selectedTokenB.first,
                            currency.toString(),
                          TextField(
                              controller: controllerB,
                              onChanged: (value) {
                                if (value == null || value == '') {
                                  setState(() {
                                    controllerA = TextEditingController(text: '');
                                  });
                                }
                                else {
                                  setState(() {
                                    controllerA.clear();
                                    var result = convertTokensExchangeRate(
                                        rate.last,
                                        rate.first,
                                        double.parse(value));
                                    controllerA = TextEditingController(
                                        text: result.toString());
                                  });
                                }
                              },
                              style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontWeight: FontWeight.w400, fontSize: scale * 20,
                              ),
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              textAlign: TextAlign.end,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'^(\d+)?\.?\d{0,2}'),),
                              ],
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '0.0'
                              ),
                            ),
                            rate.last.toString(),
                            scale,
                            marginSize,
                            imageHeightSize,
                            mediumTextScaleFactor,
                            smallTextScaleFactor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget tokenCustomContainer(TokenModel token, String currency, TextField text,
      String exchangeRate, double scale, double marginSize,
      double imageHeightSize, double mediumTextScaleFactor,
      double smallTextScaleFactor) {
    return Container(
      margin: EdgeInsets.all(marginSize),
      height: scale * 70,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(scale * 15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: scale * 10,
          ),
          ClipOval(
            child: Container(
              color: iconColor,
              child: Image.network(
                token.logoURI,
                height: imageHeightSize,
              ),
            ),
          ),
          SizedBox(
            width: scale * 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(token.symbol,
                textScaleFactor: mediumTextScaleFactor,
                style: const TextStyle(fontWeight: FontWeight.w400),),
              Text(currency,
                textScaleFactor: smallTextScaleFactor,
                style: const TextStyle(fontWeight: FontWeight.w400),),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                    width: scale * 150,
                    child: text),
              ),
              Expanded(
                child: Text(exchangeRate,
                    textScaleFactor: smallTextScaleFactor,
                    style: const TextStyle(fontWeight: FontWeight.w400)),
              ),
            ],
          ),
          SizedBox(
            width: scale * 10,
          ),
        ],
        // leading: ,
        // title:
        // subtitle:
        // trailing:
      ),
    );
  }
}
