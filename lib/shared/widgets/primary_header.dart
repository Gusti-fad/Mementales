import 'package:flutter/material.dart';

class PrimaryHeader
    extends StatelessWidget {

  final String?
      photoUrl;

  const PrimaryHeader({
    super.key,
    this.photoUrl,
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

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          Container(

            width: 50,
            height: 50,

            decoration:
                BoxDecoration(

              shape:
                  BoxShape.circle,

              color:
                  Colors.white12,

              image:
                  photoUrl != null
                      ? DecorationImage(
                          image:
                              NetworkImage(
                            photoUrl!,
                          ),
                          fit:
                              BoxFit.cover,
                        )
                      : null,
            ),
          ),

          Container(

            width: 50,
            height: 50,

            decoration:
                BoxDecoration(

              shape:
                  BoxShape.circle,

              color:
                  const Color(
                0xFF1A1A1A,
              ),
            ),

            child: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
    );
  }
}