import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpaceCard extends StatelessWidget {
  final String title;

  final double totalBalance;

  final double spendingLimit;

  final double used;

  final int memberCount;

  final String limitCycle;

  final bool expanded;

  final VoidCallback onTap;

  final Color color;

  SpaceCard({
    super.key,
    required this.title,
    required this.totalBalance,
    required this.spendingLimit,
    required this.used,
    required this.memberCount,
    required this.limitCycle,
    required this.expanded,
    required this.onTap,
    required this.color,
  });

  final currencyFormatter =
      NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp ",
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final progress =
        spendingLimit <= 0
            ? 0.0
            : (used / spendingLimit)
                .clamp(0.0, 1.0);

    final remaining =
        spendingLimit - used;

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
            // ======================
            // TOP CARD
            // ======================

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

                    child: Icon(
                      Icons.groups_rounded,
                      color: color,
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

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              const TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Colors.white,
                          ),
                        ),

                        const SizedBox(
                          height: 2,
                        ),

                        Text(
                          "$memberCount members",

                          style:
                              TextStyle(
                            fontSize: 12,
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
                        currencyFormatter
                            .format(
                          totalBalance,
                        ),

                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Colors.white,
                        ),
                      ),

                      Text(
                        "Balance",

                        style:
                            TextStyle(
                          fontSize: 11,
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

            // ======================
            // EXPAND AREA
            // ======================

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
                              Text(
                                "$limitCycle Limit",

                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white70,
                                ),
                              ),

                              Text(
                                "${currencyFormatter.format(used)} / ${currencyFormatter.format(spendingLimit)}",

                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white,
                                  fontWeight:
                                      FontWeight
                                          .w600,
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
                                  progress,

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
                            height: 12,
                          ),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: [
                              Text(
                                "${(progress * 100).toStringAsFixed(0)}% used",

                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white70,
                                  fontSize:
                                      12,
                                ),
                              ),

                              Text(
                                "${currencyFormatter.format(
                                  remaining < 0
                                      ? 0
                                      : remaining,
                                )} left",

                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                  fontSize:
                                      12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          Align(
                            alignment:
                                Alignment
                                    .centerRight,

                            child:
                                TextButton(
                              onPressed:
                                  () {},

                              child: Text(
                                "View Details",

                                style:
                                    TextStyle(
                                  color: color,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}