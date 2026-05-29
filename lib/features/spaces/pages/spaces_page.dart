import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/constants/colors.dart';
import '../../../shared/widgets/primary_header.dart';

import '../models/space_model.dart';
import '../pages/create_space_page.dart';
import '../widgets/space_card.dart';

class SpacesPage extends StatefulWidget {
  const SpacesPage({super.key});

  @override
  State<SpacesPage> createState() =>
      _SpacesPageState();
}

class _SpacesPageState
    extends State<SpacesPage>
    with SingleTickerProviderStateMixin {

  int expandedIndex = -1;

  late AnimationController controller;

  late Animation<double>
      fadeAnimation;

  late Animation<Offset>
      slideAnimation;

  final firestore =
      FirebaseFirestore.instance;

  final auth =
      FirebaseAuth.instance;

  final currencyFormatter =
      NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp ",
    decimalDigits: 0,
  );

  List<SpaceModel> spaces =
      [];

  bool isLoading =
      true;

  @override
  void initState() {

    super.initState();

    controller =
        AnimationController(
      vsync: this,
      duration:
          const Duration(
        milliseconds: 900,
      ),
    );

    fadeAnimation =
        Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve:
            Curves.easeOut,
      ),
    );

    slideAnimation =
        Tween<Offset>(
      begin:
          const Offset(
        0,
        .15,
      ),
      end:
          Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve:
            Curves.easeOutCubic,
      ),
    );

    controller.forward();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      loadSpaces();

    });
  }

Future<void> loadSpaces() async {

  if (!mounted) return;

  setState(() {
    isLoading = true;
  });

  try {

    final user =
        auth.currentUser;

    if (user == null) {

      if (!mounted) return;

      setState(() {

        spaces = [];

        isLoading = false;
      });

      return;
    }

    final snapshot =
        await firestore
            .collection(
              "spaces",
            )
            .where(
              "ownerId",
              isEqualTo:
                  user.uid,
            )
            .get();

    final loadedSpaces =
        snapshot.docs.map(

      (doc) {

        return SpaceModel.fromMap(
          doc.data(),
          doc.id,
        );
      },
    ).toList();

    if (!mounted) return;

    setState(() {

      spaces =
          loadedSpaces;

      isLoading =
          false;
    });

  } catch (e) {

    debugPrint(
      "LOAD SPACE ERROR: $e",
    );

    if (!mounted) return;

    setState(() {

      spaces = [];

      isLoading =
          false;
    });
  }
}

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          AppColors.background,

      body: Stack(

        children: [

          Positioned(
            top: -120,
            right: -50,

            child: Container(
              width: 250,
              height: 250,

              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,

                color:
                    AppColors.primary
                        .withOpacity(
                  .18,
                ),
              ),
            ),
          ),

          Positioned(
            top: -70,
            left: -80,

            child: Container(
              width: 220,
              height: 220,

              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,

                color:
                    Colors.blue
                        .withOpacity(
                  .12,
                ),
              ),
            ),
          ),

          SafeArea(

            child:
                FadeTransition(

              opacity:
                  fadeAnimation,

              child:
                  SlideTransition(

                position:
                    slideAnimation,

                child:
                    Column(

                  children: [

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          const PrimaryHeader(),

                          const SizedBox(
                            height: 25,
                          ),

                          Text(
                            "My Spaces",
                            style:
                                TextStyle(
                              fontSize:
                                  28,

                              fontWeight:
                                  FontWeight.bold,

                              color:
                                  AppColors.textPrimary,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            "A space for every bond that matters",

                            style:
                                TextStyle(
                              fontSize:
                                  14,

                              color:
                                  AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: isLoading

                          ? ListView(

                              physics:
                                  const AlwaysScrollableScrollPhysics(),

                              children: const [

                                SizedBox(
                                  height: 250,
                                ),

                                Center(
                                  child:
                                      CircularProgressIndicator(),
                                ),
                              ],
                            )

                          : RefreshIndicator(

                              onRefresh:
                                  loadSpaces,

                              child:
                                  ListView.builder(

                                    padding:
                                        const EdgeInsets.only(
                                      top: 20,
                                      bottom: 120,
                                    ),

                                    itemCount:
                                        spaces.length +
                                            1,

                                    itemBuilder:
                                        (
                                      context,
                                      index,
                                    ) {

                                      // add button terakhir

                                      if (index ==
                                          spaces.length) {

                                        return Column(

                                          children: [

                                            if(spaces.isEmpty)

                                            Column(

                                              children: [

                                                Icon(

                                                  Icons.groups_rounded,

                                                  size:
                                                      90,

                                                  color:
                                                      AppColors.primary.withOpacity(
                                                    .6,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height:
                                                      20,
                                                ),

                                                const Text(

                                                  "No spaces yet",

                                                  style:
                                                      TextStyle(
                                                    fontSize:
                                                        20,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height:
                                                      8,
                                                ),

                                                Text(

                                                  "Create your first meaningful space",

                                                  style:
                                                      TextStyle(
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height:
                                                      40,
                                                ),
                                              ],
                                            ),

                                            InkWell(

                                              borderRadius:
                                                  BorderRadius.circular(
                                                30,
                                              ),

                                              onTap:
                                                  () async {

                                                await Navigator.push(
                                                  context,

                                                  MaterialPageRoute(
                                                    builder:
                                                        (_) =>
                                                            const CreateSpacePage(),
                                                  ),
                                                );

                                                loadSpaces();
                                              },

                                              child:
                                                  Padding(

                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal:
                                                      20,
                                                  vertical:
                                                      12,
                                                ),

                                                child:
                                                    Row(

                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,

                                                  children: [

                                                    Icon(
                                                      Icons.add_circle_rounded,

                                                      size:
                                                          18,

                                                      color:
                                                          AppColors.primary,
                                                    ),

                                                    const SizedBox(
                                                      width:
                                                          8,
                                                    ),

                                                    Text(

                                                      "Add New Space",

                                                      style:
                                                          TextStyle(
                                                        color:
                                                            AppColors.primary,

                                                        fontWeight:
                                                            FontWeight.w600,

                                                        fontSize:
                                                            15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height:
                                                  100,
                                            ),
                                          ],
                                        );
                                      }

                                      final space =
                                          spaces[
                                              index];

                                      final expanded =
                                          expandedIndex ==
                                              index;

                                      final cardHeight =
                                          expanded
                                              ? 290
                                              : 140;

                                      return Stack(

                                        clipBehavior:
                                            Clip.none,

                                        children: [

                                          SizedBox(

                                            height:
                                                cardHeight
                                                    .toDouble(),

                                            child:
                                                Container(

                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal:
                                                    20,
                                              ),

                                              color:
                                                  AppColors.background,

                                              child:
                                                  SpaceCard(

                                                title:
                                                    space.name,

                                                totalBalance:
                                                    space.budget,

                                                budget:
                                                    space.budget,

                                                used:
                                                    0,

                                                color:
                                                    AppColors.primary,

                                                expanded:
                                                    expanded,

                                                onTap:
                                                    () {

                                                  setState(
                                                    () {

                                                      expandedIndex =
                                                          expanded
                                                              ? -1
                                                              : index;
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),

                                          Positioned(

                                            left:
                                                0,

                                            right:
                                                0,

                                            bottom:
                                                0,

                                            child:
                                                IgnorePointer(

                                              child:
                                                  Container(

                                                height:
                                                    64,

                                                decoration:
                                                    BoxDecoration(

                                                  color:
                                                      AppColors.background,

                                                  borderRadius:
                                                      const BorderRadius.vertical(
                                                    top:
                                                        Radius.circular(
                                                      32,
                                                    ),
                                                  ),

                                                  boxShadow: [

                                                    BoxShadow(

                                                      color:
                                                          AppColors.primary.withOpacity(
                                                        .35,
                                                      ),

                                                      blurRadius:
                                                          50,

                                                      spreadRadius:
                                                          5,

                                                      offset:
                                                          const Offset(
                                                        0,
                                                        -8,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}