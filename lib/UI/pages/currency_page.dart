import 'package:crypto_trade/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../Data/constraints.dart';
import 'main_menu.dart';

class CurrencyPage extends ConsumerWidget {
  CurrencyPage(
      {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final selectedTokenA = ref.watch(mainMenuStateSelectedTokenA);
    final selectedTokenB = ref.watch(mainMenuStateSelectedTokenB);


    final topStatusBarHeight = MediaQuery.of(context).viewPadding.top;
    final bottomStatusBarHeight = MediaQuery.of(context).viewPadding.bottom;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final double scale = width / mockUpWidth;
    final double scaleMarginOrPadding = scale * 15.0;
    final double indentScale = scale * 20.0;
    final double bigTextScaleFactor = scale * 2.2;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: topStatusBarHeight, left: scaleMarginOrPadding),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          Flexible(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(left: scaleMarginOrPadding,right: scaleMarginOrPadding, top: scaleMarginOrPadding),
              margin: EdgeInsets.only(bottom: bottomStatusBarHeight),
              child: SearchableList(
                spaceBetweenSearchAndList: scale * 10,
                textAlign: TextAlign.center,
                onItemSelected: (currency) {
                  ref.read(riverpodSelectedCurrencyProvider.notifier).state = currency;
                  context.pushNamed('/exchange');
                },
                initialList: currenciesList,
                builder: (currencies) => Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: scaleMarginOrPadding),
                      height: scale * 50,
                      child: Text(
                        currencies,
                        textScaleFactor: bigTextScaleFactor,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,),
                      ),
                    ),
                    Divider(
                      height: scale * 2,
                      thickness: scale *3,
                      endIndent: indentScale,
                      indent: indentScale,
                    )
                  ],
                ),
                filter: (value) => currenciesList
                    .where(
                      (element) => element.toLowerCase().contains(value),
                    )
                    .toList(),
                emptyWidget: const SizedBox.shrink(),
                inputDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: "Search",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
