import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
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

  final TextEditingController
      nameController =
          TextEditingController();

  final TextEditingController
      descriptionController =
          TextEditingController();

  final TextEditingController
      budgetController =
          TextEditingController();

  final formatter =
      NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp ",
    decimalDigits: 0,
  );

  Color selectedColor =
      AppColors.primary;

  final colors = [

    AppColors.primary,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  File? selectedImage;

  bool isLoading =
      false;

  @override
  void dispose() {

    nameController.dispose();

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

    if (value.isEmpty) {

      budgetController.clear();

      return;
    }

    final number =
        int.parse(value);

    final formatted =
        formatter.format(
      number,
    );

    budgetController.value =
        TextEditingValue(

      text:
          formatted,

      selection:
          TextSelection.collapsed(
        offset:
            formatted.length,
      ),
    );
  }

  Future<void> pickImage() async {

    try {

      final picker =
          ImagePicker();

      final image =
          await picker.pickImage(

        source:
            ImageSource.gallery,

        imageQuality:
            75,
      );

      if (image == null) {
        return;
      }

      setState(() {

        selectedImage =
            File(image.path);
      });

    } catch (e) {

      debugPrint(
        "IMAGE PICK ERROR: $e",
      );
    }
  }

  Future<void> createSpace() async {

    if (nameController.text
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

    setState(() {

      isLoading = true;
    });

    try {

      final cleanBudget =
          budgetController.text
              .replaceAll(
                RegExp(
                  r'[^0-9]',
                ),
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

      String? imageUrl;

      if (selectedImage != null) {

        final fileName =
            DateTime.now()
                .millisecondsSinceEpoch
                .toString();

        final ref =
            FirebaseStorage
                .instance
                .ref()
                .child(
                  "spaces/$fileName.jpg",
                );

        await ref.putFile(
          selectedImage!,
        );

        imageUrl =
            await ref.getDownloadURL();
      }

      await FirebaseFirestore
          .instance
          .collection(
            "spaces",
          )
          .add({

        "name":
            nameController.text
                .trim(),

        "description":
            descriptionController
                .text
                .trim(),

        "budget":
            budget,

        "budgetPeriod":
            "Monthly",

        "type":
            "Shared",

        "color":
            selectedColor.value,

        "ownerId":
            user.uid,

        "members": [
          user.uid,
        ],

        "coverUrl":
            imageUrl,

        "wishlist": [],

        "createdAt":
            Timestamp.now(),
      });

      if (!mounted) return;

      Navigator.pop(
        context,
      );

    } catch (e) {

      debugPrint(
        "CREATE SPACE ERROR: $e",
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

    } finally {

      if (mounted) {

        setState(() {

          isLoading =
              false;
        });
      }
    }
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          AppColors.background,

      body: SafeArea(

        child:
            SingleChildScrollView(

          padding:
              const EdgeInsets.all(
            24,
          ),

          child:
              Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Row(

                children: [

                  IconButton(

                    onPressed: () {

                      Navigator.pop(
                        context,
                      );
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
                      Icons.groups_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              Text(

                "Create Space",

                style:
                    TextStyle(

                  fontSize: 30,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      AppColors
                          .textPrimary,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(

                "Build deeper connections together",

                style:
                    TextStyle(

                  color:
                      AppColors
                          .textSecondary,

                  fontSize: 14,
                ),
              ),

              const SizedBox(
                height: 35,
              ),

              buildSection(

                "Space Name",

                TextField(

                  controller:
                      nameController,

                  decoration:
                      inputStyle(
                    "Bali Trip",
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              buildSection(

                "Description (Optional)",

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

              const SizedBox(
                height: 25,
              ),

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

                          setState(() {

                            selectedColor =
                                color;
                          });
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

                              if (selected)

                                BoxShadow(

                                  color:
                                      color.withOpacity(
                                    .6,
                                  ),

                                  blurRadius:
                                      20,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              buildSection(

                "Cover Image (Optional)",

                GestureDetector(

                  onTap:
                      pickImage,

                  child:
                      Container(

                    height: 180,

                    decoration:
                        BoxDecoration(

                      color:
                          const Color(
                        0xFF151A24,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),
                    ),

                    child:
                        selectedImage !=
                                null

                            ? ClipRRect(

                                borderRadius:
                                    BorderRadius.circular(
                                  28,
                                ),

                                child:
                                    Image.file(

                                  selectedImage!,

                                  fit:
                                      BoxFit.cover,

                                  width:
                                      double.infinity,
                                ),
                              )

                            : Column(

                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [

                                  Icon(

                                    Icons.image_rounded,

                                    size:
                                        42,

                                    color:
                                        AppColors.primary,
                                  ),

                                  const SizedBox(
                                    height:
                                        12,
                                  ),

                                  Text(

                                    "Add Cover Image",

                                    style:
                                        TextStyle(

                                      color:
                                          AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                  ),
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

                  onPressed:
                      isLoading
                          ? null
                          : createSpace,

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        AppColors
                            .primary,

                    elevation: 0,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),

                  child:
                      isLoading

                          ? const SizedBox(

                              width: 24,
                              height: 24,

                              child:
                                  CircularProgressIndicator(

                                strokeWidth:
                                    2,

                                color:
                                    Colors.white,
                              ),
                            )

                          : const Text(

                              "Create Space",

                              style:
                                  TextStyle(

                                fontSize:
                                    16,

                                fontWeight:
                                    FontWeight.w600,

                                color:
                                    Colors.white,
                              ),
                            ),
                ),
              ),

              const SizedBox(
                height: 80,
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

      hintStyle:
          TextStyle(

        color:
            AppColors
                .textSecondary,
      ),

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

      enabledBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          28,
        ),

        borderSide:
            BorderSide.none,
      ),

      focusedBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          28,
        ),

        borderSide:
            BorderSide(

          color:
              AppColors.primary,

          width: 1.4,
        ),
      ),
    );
  }
}