import 'package:flutter/material.dart';

class SpaceSkeleton
    extends StatelessWidget {

  const SpaceSkeleton({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    return Column(

      children:
          List.generate(
        5,

        (index) {

          return Transform.translate(

          offset: Offset(
            0,
            -(index * 25.0),
          ),

            child:
                Container(

              height: 120,

              margin:
                  const EdgeInsets.only(
                bottom: 10,
              ),

              decoration:
                  BoxDecoration(

                color:
                    Colors.white10,

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}