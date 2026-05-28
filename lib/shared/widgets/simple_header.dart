import 'package:flutter/material.dart';

class SimpleHeader
    extends StatelessWidget {

  final String title;

  const SimpleHeader({

    super.key,

    required this.title,
  });

  @override
  Widget build(
      BuildContext context) {

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),

      child: Stack(

        alignment:
            Alignment.center,

        children: [

          Align(

            alignment:
                Alignment.centerLeft,

            child:
                GestureDetector(

              onTap: () {

                Navigator.pop(
                    context);
              },

              child:
                  Container(

                width: 45,
                height: 45,

                decoration:
                    BoxDecoration(

                  color:
                      const Color(
                    0xFF1A1A1A,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),

                child:
                    const Icon(
                  Icons
                      .arrow_back_ios_new,
                  size: 18,
                ),
              ),
            ),
          ),

          Text(

            title,

            style:
                const TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}