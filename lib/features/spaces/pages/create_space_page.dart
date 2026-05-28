import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/constants/colors.dart';

class CreateSpacePage extends StatefulWidget {
  const CreateSpacePage({super.key});

  @override
  State<CreateSpacePage> createState() =>
      _CreateSpacePageState();
}

class _CreateSpacePageState
    extends State<CreateSpacePage> {

  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final budgetController =
      TextEditingController();

  final formatter =
      NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp ",
    decimalDigits: 0,
  );

  String selectedType =
      "Personal";

  String selectedPeriod =
      "Monthly";

  Color selectedColor =
      AppColors.primary;

  final colors = [

    AppColors.primary,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  @override
  void dispose() {

    titleController.dispose();

    descriptionController.dispose();

    budgetController.dispose();

    super.dispose();
  }

  void formatCurrency(
      String value) {

    value =
        value.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (value.isEmpty) return;

    final number =
        int.parse(value);

    final formatted =
        formatter.format(
      number,
    );

    budgetController.value =
        TextEditingValue(
      text: formatted,
      selection:
          TextSelection.collapsed(
        offset:
            formatted.length,
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          AppColors.background,

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(
            24,
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Row(

                children: [

                  IconButton(

                    onPressed: () {

                      Navigator.pop(
                          context);
                    },

                    icon: Icon(
                      Icons.arrow_back,
                      color:
                          AppColors
                              .textPrimary,
                    ),
                  ),

                  const Spacer(),

                  Container(

                    width: 48,
                    height: 48,

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.white
                              .withOpacity(
                        .08,
                      ),

                      shape:
                          BoxShape.circle,
                    ),

                    child:
                        const Icon(
                      Icons.more_horiz,
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              Text(

                "Create Space",

                style: TextStyle(

                  fontSize: 30,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      AppColors
                          .textPrimary,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // TITLE

              buildSection(
                "Space Name",
                TextField(

                  controller:
                      titleController,

                  decoration:
                      inputStyle(
                    "Bali Trip",
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              const SizedBox(
                height: 25,
              ),

              buildSection(

                "Description",

                TextField(

                  controller:
                      descriptionController,

                  maxLines: 3,

                  decoration:
                      inputStyle(
                    "Create deeper connections together...",
                  ),
                ),
              ),

              // BUDGET

              buildSection(

                "Budget Target",

                Container(

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 5,
                  ),

                  decoration:
                      pillDecoration(),

                  child:
                      TextField(

                    controller:
                        budgetController,

                    onChanged:
                        formatCurrency,

                    textAlign:
                        TextAlign.center,

                    keyboardType:
                        TextInputType.number,

                    style:
                        const TextStyle(

                      fontSize: 28,

                      fontWeight:
                          FontWeight.bold,
                    ),

                    decoration:
                        const InputDecoration(

                      border:
                          InputBorder.none,

                      hintText:
                          "Rp 0",
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              buildSection(

                "Space Type",

                Row(

                  children: [

                    buildTypeCard(
                      "Personal",
                      Icons.person,
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    buildTypeCard(
                      "Shared",
                      Icons.groups,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              buildSection(

                "Budget Period",

                Container(

                  padding:
                      const EdgeInsets.all(
                    6,
                  ),

                  decoration:
                      pillDecoration(),

                  child: Row(

                    children: [

                      buildPeriod(
                          "Daily"),

                      buildPeriod(
                          "Weekly"),

                      buildPeriod(
                          "Monthly"),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              buildSection(

                "Theme Color",

                Wrap(

                  spacing: 14,

                  children:
                      colors.map(
                    (color) {

                      final selected =
                          selectedColor ==
                              color;

                      return GestureDetector(

                        onTap: () {

                          setState(
                            () {

                              selectedColor =
                                  color;
                            },
                          );
                        },

                        child:
                            AnimatedContainer(

                          duration:
                              const Duration(
                            milliseconds:
                                250,
                          ),

                          width: 42,
                          height: 42,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            color:
                                color,

                            border:
                                Border.all(

                              width:
                                  selected
                                      ? 3
                                      : 0,

                              color:
                                  Colors.white,
                            ),

                            boxShadow: [

                              if(selected)

                              BoxShadow(

                                color:
                                    color.withOpacity(
                                  .6,
                                ),

                                blurRadius:
                                    20,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),

              const SizedBox(
                height: 60,
              ),

              SizedBox(

                width:
                    double.infinity,

                height: 58,

                child:
                    ElevatedButton(

                      onPressed: () async {

                        if (titleController.text
                            .trim()
                            .isEmpty) {

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(

                            const SnackBar(
                              content: Text(
                                "Space name required",
                              ),
                            ),
                          );

                          return;
                        }

                        try {

                          final cleanBudget =
                              budgetController.text
                                  .replaceAll(
                                    RegExp(r'[^0-9]'),
                                    '',
                                  );

                          final budget =
                              double.tryParse(
                                    cleanBudget,
                                  ) ??
                                  0;

                          final user =
                              FirebaseAuth
                                  .instance
                                  .currentUser;

                          if (user == null) {
                            return;
                          }

                          await FirebaseFirestore
                              .instance
                              .collection(
                                "spaces",
                              )
                              .add({

                            "title":
                                titleController.text
                                    .trim(),

                            "description":
                                descriptionController.text
                                    .trim(),

                            "budget":
                                budget,

                            "budgetPeriod":
                                selectedPeriod,

                            "type":
                                selectedType,

                            "color":
                                selectedColor.value,

                            "ownerId":
                                user.uid,

                            "createdAt":
                                FieldValue.serverTimestamp(),
                          });

                          if (!mounted) return;

                          Navigator.pop(
                            context,
                          );

                        } catch (e) {

                          debugPrint(
                            e.toString(),
                          );

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(

                            SnackBar(
                              content: Text(
                                "Failed: $e",
                              ),
                            ),
                          );
                        }
                      },

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        AppColors
                            .primary,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),

                  child:
                      const Text(

                    "Continue",

                    style:
                        TextStyle(

                      fontSize: 16,

                      fontWeight:
                          FontWeight.w600,

                      color:
                          Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(
      String title,
      Widget child) {

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(

          title,

          style:
              const TextStyle(

            fontSize: 14,

            fontWeight:
                FontWeight.w600,
          ),
        ),

        const SizedBox(
          height: 12,
        ),

        child,
      ],
    );
  }

  Widget buildTypeCard(
      String text,
      IconData icon) {

    final selected =
        selectedType ==
            text;

    return Expanded(

      child:
          GestureDetector(

        onTap: () {

          setState(
            () {

              selectedType =
                  text;
            },
          );
        },

        child:
            AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 250,
          ),

          padding:
              const EdgeInsets.all(
            18,
          ),

          decoration:
              BoxDecoration(

            color:
                selected

                    ? AppColors
                        .primary

                    : const Color(
                        0xFF151A24,
                      ),

            borderRadius:
                BorderRadius.circular(
              24,
            ),
          ),

          child: Column(

            children: [

              Icon(
                icon,
                color:
                    Colors.white,
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                text,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPeriod(
      String text) {

    final selected =
        selectedPeriod ==
            text;

    return Expanded(

      child:
          GestureDetector(

        onTap: () {

          setState(
            () {

              selectedPeriod =
                  text;
            },
          );
        },

        child:
            Container(

          padding:
              const EdgeInsets.symmetric(
            vertical: 14,
          ),

          decoration:
              BoxDecoration(

            color:
                selected

                    ? Colors.blue

                    : Colors.transparent,

            borderRadius:
                BorderRadius.circular(
              30,
            ),
          ),

          child: Center(
            child:
                Text(text),
          ),
        ),
      ),
    );
  }

  BoxDecoration pillDecoration() {

    return BoxDecoration(

      color:
          const Color(
        0xFF151A24,
      ),

      borderRadius:
          BorderRadius.circular(
        28,
      ),
    );
  }

  InputDecoration inputStyle(
      String hint) {

    return InputDecoration(

      hintText: hint,

      filled: true,

      fillColor:
          const Color(
        0xFF151A24,
      ),

      border:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          28,
        ),

        borderSide:
            BorderSide.none,
      ),
    );
  }
}