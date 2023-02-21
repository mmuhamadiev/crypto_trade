import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../Data/constraints.dart';
import '../../Data/models/token_list_model.dart';
import '../../main.dart';

final mainMenuStateHasError = Provider((ref) {
  final data = ref.watch(riverpodTokenProvider).hasError;
  return data;
});
final mainMenuStateErrorMessage = Provider((ref) {
  final data = ref.watch(riverpodTokenProvider).errorMessage;
  return data;
});

class ListOfTokens extends ConsumerWidget {
  ListOfTokens(
      this.scale,
      this.bigTextScaleFactor,
      this.mediumTextScaleFactor,
      this.smallTextScaleFactor,
      this.buttonVerticalPadding,
      this.marginSize,
      this.imageHeightSize,
      this.iconScaleSize, {
        Key? key,
        required this.func,required this.selectedTokenA, required this.selectedTokenB
      }) : super(key: key);

  Function(TokenModel) func;
  Set<TokenModel> selectedTokenA;
  Set<TokenModel> selectedTokenB;
  final double scale;
  final double bigTextScaleFactor;
  final double mediumTextScaleFactor;
  final double smallTextScaleFactor;
  final double buttonVerticalPadding;
  final double marginSize;
  final double imageHeightSize;
  final double iconScaleSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = ref.watch(listOfTokens);
    final errorMessage = ref.watch(mainMenuStateErrorMessage);

    return tokens.when(
        loading: () => Center(child: const CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (tokens) {
          return ref.read(riverpodTokenProvider.notifier).state.isLoading
              ? const Center(
            child: CircularProgressIndicator(
              color: backgroundColor,
            ),
          )
              : ref.read(riverpodTokenProvider.notifier).state.hasError
              ? Center(
            child: Text(
              errorMessage!,
              textScaleFactor: bigTextScaleFactor,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ):SearchableList<TokenModel>(
            onItemSelected: func,
            initialList: tokens,
            builder: (TokenModel token) {
              if (selectedTokenA.isNotEmpty && selectedTokenB.isNotEmpty) {
                if (selectedTokenA.first.symbol == token.symbol ||
                    selectedTokenB.first.symbol == token.symbol) {
                  return Container(
                    margin: EdgeInsets.only(bottom: scale * 10),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: ListTile(
                      leading: ClipOval(
                        child: Container(
                          color: iconColor,
                          child: Image.network(token.logoURI,
                              height: imageHeightSize),
                        ),
                      ),
                      title: Text(
                        token.symbol,
                        textScaleFactor: mediumTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        token.name,
                        textScaleFactor: smallTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(bottom: scale * 10),
                    child: ListTile(
                      leading: ClipOval(
                        child: Container(
                          color: iconColor,
                          child: Image.network(token.logoURI,
                              height: imageHeightSize),
                        ),
                      ),
                      title: Text(
                        token.symbol,
                        textScaleFactor: mediumTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        token.name,
                        textScaleFactor: smallTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }
              } else if (selectedTokenA.isNotEmpty && selectedTokenB.isEmpty) {
                if (selectedTokenA.first.symbol == token.symbol) {
                  return Container(
                    margin: EdgeInsets.only(bottom: scale * 10),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: ListTile(
                      leading: ClipOval(
                        child: Container(
                          color: iconColor,
                          child: Image.network(token.logoURI,
                              height: imageHeightSize),
                        ),
                      ),
                      title: Text(
                        token.symbol,
                        textScaleFactor: mediumTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        token.name,
                        textScaleFactor: smallTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(bottom: scale * 10),
                    child: ListTile(
                      leading: ClipOval(
                        child: Container(
                          color: iconColor,
                          child: Image.network(token.logoURI,
                              height: imageHeightSize),
                        ),
                      ),
                      title: Text(
                        token.symbol,
                        textScaleFactor: mediumTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        token.name,
                        textScaleFactor: smallTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }
              } else if (selectedTokenA.isEmpty && selectedTokenB.isNotEmpty) {
                if (selectedTokenB.first.symbol == token.symbol) {
                  return Container(
                    margin: EdgeInsets.only(bottom: scale * 10),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: ListTile(
                      leading: ClipOval(
                        child: Container(
                          color: iconColor,
                          child: Image.network(token.logoURI,
                              height: imageHeightSize),
                        ),
                      ),
                      title: Text(
                        token.symbol,
                        textScaleFactor: mediumTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        token.name,
                        textScaleFactor: smallTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(bottom: scale * 10),
                    child: ListTile(
                      leading: ClipOval(
                        child: Container(
                          color: iconColor,
                          child: Image.network(token.logoURI,
                              height: imageHeightSize),
                        ),
                      ),
                      title: Text(
                        token.symbol,
                        textScaleFactor: mediumTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        token.name,
                        textScaleFactor: smallTextScaleFactor,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return Container(
                  margin: EdgeInsets.only(bottom: scale * 10),
                  child: ListTile(
                    leading: ClipOval(
                      child: Container(
                        color: iconColor,
                        child: Image.network(token.logoURI,
                            height: imageHeightSize),
                      ),
                    ),
                    title: Text(
                      token.symbol,
                      textScaleFactor: mediumTextScaleFactor,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text(
                      token.name,
                      textScaleFactor: smallTextScaleFactor,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }
            },
            filter: (value) => tokens
                .where(
                  (element) => element.symbol.toLowerCase().contains(value),
            )
                .toList(),
            emptyWidget: const SizedBox.shrink(),
            inputDecoration: const InputDecoration(
              labelText: "Search",
            ),
          );
        });
  }
}