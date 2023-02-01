import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Data/constraints.dart';
import '../../Data/models/token_list_model.dart';
import '../../main.dart';

class CustomContainer extends ConsumerWidget {
  CustomContainer({Key? key, required this.tokens, required this.staticToken, required this.mediumTextScaleSize, required this.scale, required this.imageHeightSize, required this.iconScaleSize}) : super(key: key);

  Set<TokenModel> tokens;
  final String staticToken;
  final double mediumTextScaleSize;
  final double scale;
  final double imageHeightSize;
  final double iconScaleSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var statesChange = ref.watch(riverpodStateProvider);
    return statesChange? Container(
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
    ): Container(
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
}