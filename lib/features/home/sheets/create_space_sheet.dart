import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../services/space_service.dart';

class CreateSpaceSheet extends StatefulWidget {
  const CreateSpaceSheet({
    super.key,
  });

  @override
  State<CreateSpaceSheet>
      createState() =>
          _CreateSpaceSheetState();
}

class _CreateSpaceSheetState
    extends State<CreateSpaceSheet> {

  final controller =
      TextEditingController();

  final budgetController =
      TextEditingController();

  bool loading = false;

  @override
  Widget build(
      BuildContext context) {

    return Container(
      padding:
          const EdgeInsets.all(
        20,
      ),

      decoration:
          const BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(
            35,
          ),
        ),
      ),

      child: Column(
        mainAxisSize:
            MainAxisSize.min,

        children: [

          Container(
            width: 50,
            height: 5,

            decoration:
                BoxDecoration(
              color: Colors.grey[300],

              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          const Text(
            "Create Space ✨",
            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          TextField(
            controller:
                controller,

            decoration:
                InputDecoration(
              hintText:
                  "Sigma Boy",

              filled: true,

              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          SizedBox(
            width: double.infinity,

            height: 55,

            child:
                FilledButton(
              onPressed:
                  loading
                      ? null
                      : () async {

                          setState(() {
                            loading =
                                true;
                          });

                          await SpaceService()
                              .createSpace(
                            name:
                                controller
                                    .text,

                            budget: 0,
                          );

                          if(context.mounted){
                            Navigator.pop(
                              context,
                            );
                          }

                        },

              child:
                  loading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Create",
                        ),
            ),
          )
        ],
      ),
    )
        .animate()
        .fade()
        .slideY(
          begin: 1,
          end: 0,
        );
  }
}