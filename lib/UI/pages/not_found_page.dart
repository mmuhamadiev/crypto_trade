import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.network('https://assets2.lottiefiles.com/packages/lf20_jitmvb71.json', width: MediaQuery.of(context).size.width - 20,),
          const Flexible(
            child: Text('Page Not Found',style: TextStyle(
              fontFamily: 'assets/fonts/Courgette-Regular.ttf',
            ),),
          ),
        ],
      ),
    );
  }
}
