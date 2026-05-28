import 'package:flutter/material.dart';

class SpaceCard extends StatelessWidget {
  final String title;
  final String totalBalance;
  final String budget;
  final String used;

  final bool expanded;
  final VoidCallback onTap;

  final Color color;

  const SpaceCard({
    super.key,
    required this.title,
    required this.totalBalance,
    required this.budget,
    required this.used,
    required this.expanded,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: AnimatedContainer(

        duration: const Duration(
          milliseconds: 500,
        ),

        curve:
            Curves.easeOutCubic,

        child: Column(

          children: [

            // TOP CARD

            Container(

              height: 82,

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
              ),

              decoration:
                  BoxDecoration(

                color: color,

                borderRadius:
                    const BorderRadius.only(

                  topLeft:
                      Radius.circular(
                    28,
                  ),

                  topRight:
                      Radius.circular(
                    28,
                  ),
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        color.withOpacity(
                      .25,
                    ),

                    blurRadius: 25,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Row(

                children: [

                  // group icon

                  Container(

                    width: 46,
                    height: 46,

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.white
                              .withOpacity(
                        .95,
                      ),

                      shape:
                          BoxShape.circle,
                    ),

                    child:
                        Icon(

                      Icons.groups_rounded,

                      color:
                          color,
                    ),
                  ),

                  const SizedBox(
                    width: 14,
                  ),

                  Expanded(

                    child: Column(

                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          title,

                          style:
                              const TextStyle(

                            fontSize:
                                17,

                            fontWeight:
                                FontWeight
                                    .bold,

                            color:
                                Colors
                                    .white,
                          ),
                        ),

                        const SizedBox(
                          height: 2,
                        ),

                        Text(

                          "3 members",

                          style:
                              TextStyle(

                            fontSize:
                                12,

                            color:
                                Colors.white
                                    .withOpacity(
                              .8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .end,

                    children: [

                      Text(

                        totalBalance,

                        style:
                            const TextStyle(

                          fontSize: 17,

                          fontWeight:
                              FontWeight
                                  .bold,

                          color:
                              Colors.white,
                        ),
                      ),

                      Text(

                        "Total Balance",

                        style:
                            TextStyle(

                          fontSize:
                              11,

                          color:
                              Colors.white
                                  .withOpacity(
                            .8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // EXPAND AREA

            AnimatedSize(

              duration:
                  const Duration(
                milliseconds: 500,
              ),

              curve:
                  Curves.easeOutCubic,

              child: expanded

                  ? Container(

                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      decoration:
                          const BoxDecoration(

                        color:
                            Color(
                          0xFF171717,
                        ),

                        borderRadius:
                            BorderRadius.only(

                          bottomLeft:
                              Radius.circular(
                            28,
                          ),

                          bottomRight:
                              Radius.circular(
                            28,
                          ),
                        ),
                      ),

                      child: Column(

                        children: [

                          Row(

                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: [

                              const Text(

                                "Monthly Budget",

                                style:
                                    TextStyle(
                                  color:
                                      Colors
                                          .white70,
                                ),
                              ),

                              Text(

                                "$used / $budget",

                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          ClipRRect(

                            borderRadius:
                                BorderRadius.circular(
                              50,
                            ),

                            child:
                                LinearProgressIndicator(

                              value:
                                  .58,

                              minHeight:
                                  10,

                              valueColor:
                                  AlwaysStoppedAnimation(
                                color,
                              ),

                              backgroundColor:
                                  Colors
                                      .white10,
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          Align(

                            alignment:
                                Alignment.centerRight,

                            child:
                                TextButton(

                              onPressed:
                                  () {},

                              child:
                                  Text(

                                "View Details",

                                style:
                                    TextStyle(
                                  color:
                                      color,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )

                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}