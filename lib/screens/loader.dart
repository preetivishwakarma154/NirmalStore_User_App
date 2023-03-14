import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class LoaderSection extends StatelessWidget {
  const LoaderSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingAnimationWidget.discreteCircle(
              color: Color(0xff074d58), size: 80),
          SizedBox(height: 15,),
          Text("Please wait" )
        ],
      ),
    );
  }
}