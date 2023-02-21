import 'package:crypto_trade/Data/models/token_list_model.dart';
import 'package:crypto_trade/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../Data/constraints.dart';
import '../custom_widgets/CustomContainer.dart';
import '../custom_widgets/list_of_tokens.dart';

final mainMenuStateLoading = Provider((ref) {
  final data = ref.watch(riverpodTokenProvider).isLoading;
  return data;
});

final mainMenuStateSelectedTokenA = Provider((ref) {
  final data = ref.watch(riverpodSelectedTokensProvider).selectedTokenA;
  return data;
});

final mainMenuStateSelectedTokenB = Provider((ref) {
  final data = ref.watch(riverpodSelectedTokensProvider).selectedTokenB;
  return data;
});


class MainMenu extends ConsumerWidget {

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedTokenA = ref.watch(mainMenuStateSelectedTokenA);
    final selectedTokenB = ref.watch(mainMenuStateSelectedTokenB);

    final topStatusBarHeight = MediaQuery.of(context).viewPadding.top;
    final bottomStatusBarHeight = MediaQuery.of(context).viewPadding.bottom;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final double scale = width / mockUpWidth;
    final double bigTextScaleFactor = scale * 2.2;
    final double mediumTextScaleFactor = scale * 1.3;
    final double smallTextScaleFactor = scale * 1.1;
    final double buttonVerticalPadding = scale * 17;
    final double marginSize = scale * 30;
    final double imageHeightSize = scale * 30;
    final double iconScaleSize = scale * 2.2;

    return Scaffold(
      backgroundColor: backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.2,
                        margin: EdgeInsets.only(
                            top: topStatusBarHeight == 0.0? 20: topStatusBarHeight, left: marginSize),
                        child: Text(
                          'Choose tokens',
                          textScaleFactor: bigTextScaleFactor,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showListOfTokens(
                            context,
                            (value) {
                              ref.read(riverpodSelectedTokensProvider).addValueToSelectedTokenA(value, context, ref);
                            },
                            height,
                            bigTextScaleFactor,
                            mediumTextScaleFactor,
                            smallTextScaleFactor,
                            scale,
                            imageHeightSize,
                            iconScaleSize,
                            buttonVerticalPadding, marginSize,
                            selectedTokenA,
                            selectedTokenB
                          );
                        },
                        child: CustomContainer(
                            tokens: selectedTokenA,
                            staticToken: 'Token A',
                            mediumTextScaleSize: mediumTextScaleFactor,
                            scale: scale,
                            imageHeightSize: imageHeightSize,
                            iconScaleSize: iconScaleSize),
                      ),
                      Container(
                        height: height * 0.1,
                        child: Center(
                          child: Icon(
                            Icons.arrow_downward,
                            size: imageHeightSize,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showListOfTokens(
                            context,
                            (value) {
                              ref.read(riverpodSelectedTokensProvider).addValueToSelectedTokenB(value, context, ref);
                            },
                            height,
                            bigTextScaleFactor,
                            mediumTextScaleFactor,
                            smallTextScaleFactor,
                            scale,
                            imageHeightSize,
                            iconScaleSize,
                            buttonVerticalPadding, marginSize,
                            selectedTokenA,
                            selectedTokenB,
                          );
                        },
                        child:  CustomContainer(
                            tokens: selectedTokenB,
                            staticToken: 'Token B',
                            mediumTextScaleSize: mediumTextScaleFactor,
                            scale: scale,
                            imageHeightSize: imageHeightSize,
                            iconScaleSize: iconScaleSize),
                      ),
                      SizedBox(
                        height: height * 0.2,
                      ),
                      watchExchangeRateButton(
                        context,
                          height,
                          bottomStatusBarHeight == 0.0? 20: bottomStatusBarHeight,
                          smallTextScaleFactor,
                          marginSize,
                          buttonVerticalPadding,
                      selectedTokenA, selectedTokenB, ref),
                    ],
                  ),
              ),
    );
  }

  void showListOfTokens(
    BuildContext context,
    Function(TokenModel) func,
    double height,
    double bigTextScaleFactor,
    double mediumTextScaleFactor,
    double smallTextScaleFactor,
    double scale,
    double imageHeightSize,
    double iconScaleSize,
      double buttonVerticalPadding, double marginSize,
      Set<TokenModel> selectedTokenA, Set<TokenModel> selectedTokenB
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: SizedBox(
              height: height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      'Choose token',
                      textScaleFactor: bigTextScaleFactor,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: scale * 15.0),
                      child: ListOfTokens(scale, bigTextScaleFactor, mediumTextScaleFactor, smallTextScaleFactor, buttonVerticalPadding, marginSize, imageHeightSize, iconScaleSize, func: func, selectedTokenA: selectedTokenA, selectedTokenB: selectedTokenB,),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget tokenCustomContainer(
      Set<TokenModel> tokens,
      String staticToken,
      double mediumTextScaleSize,
      double scale,
      double imageHeightSize,
      double iconScaleSize,) {

    return Container(
      margin: EdgeInsets.all(scale * 30),
      height: scale * 70,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Container(
        margin: EdgeInsets.only(left: scale * 20),
        child: tokens.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Container(
                      color: iconColor,
                      child: Padding(
                        padding: EdgeInsets.all(scale * 8.0),
                        child: Image.network(
                          tokens.first.logoURI,
                          height: imageHeightSize,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: scale * 18,
                  ),
                  Text(
                    tokens.first.symbol,
                    textScaleFactor: mediumTextScaleSize,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Container(
                      color: iconColor,
                      child: Padding(
                        padding: EdgeInsets.all(scale * 8.0),
                        child: Icon(
                          Icons.abc,
                          size: imageHeightSize,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: scale * 18,
                  ),
                  Text(
                    staticToken,
                    textScaleFactor: mediumTextScaleSize,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget watchExchangeRateButton(
      BuildContext context,
      double height,
      double bottomStatusBarHeight,
      double smallTextScaleFactor,
      double marginSize,
      double buttonVerticalPadding,
      Set<TokenModel> selectedTokenA, Set<TokenModel> selectedTokenB, WidgetRef ref
      ) {
    return Container(
      margin: EdgeInsets.only(
          left: marginSize, right: marginSize, bottom: bottomStatusBarHeight),
      child: FilledButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
        ),
        onPressed: () {
          if (selectedTokenA.isNotEmpty && selectedTokenB.isNotEmpty) {
            ref.read(riverpodDateProvider.notifier).update((state) => dateFormat.format(DateTime.now()).toString());
            context.pushNamed('/currency');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                content: Center(
              child: Text(
                'Please choose Tokens',
                textScaleFactor: smallTextScaleFactor,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            )));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: buttonVerticalPadding),
              child: Text('WATCH',
                  textScaleFactor: smallTextScaleFactor,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}