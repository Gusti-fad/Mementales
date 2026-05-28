import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/constants/colors.dart';

class CustomBottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNav> createState() =>
      _CustomBottomNavState();
}

class _CustomBottomNavState
    extends State<CustomBottomNav> {

  bool isIdle = false;

  Timer? idleTimer;

  final icons = [
    Icons.home_rounded,
    Icons.groups_rounded,
    Icons.bar_chart_rounded,
    Icons.photo_library_rounded,
  ];

  void resetTimer() {
    idleTimer?.cancel();

    if (mounted) {
      setState(() {
        isIdle = false;
      });
    }

    idleTimer = Timer(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          setState(() {
            isIdle = true;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    resetTimer();
  }

  @override
  void dispose() {
    idleTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(
      BuildContext context) {

    return Padding(

      padding:
          const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 20,
      ),

      child: GestureDetector(

        onTap: resetTimer,

        child: ClipRRect(

          borderRadius:
              BorderRadius.circular(
            30,
          ),

          child: BackdropFilter(

            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),

            child:
                AnimatedContainer(

              duration:
                  const Duration(
                milliseconds: 700,
              ),

              curve:
                  Curves.easeOutExpo,

              height:
                  isIdle
                      ? 24
                      : 75,

              decoration:
                  BoxDecoration(

                color:
                    Colors.white
                        .withValues(
                  alpha: 0.06,
                ),

                border:
                    Border.all(

                  color:
                      Colors.white
                          .withValues(
                    alpha: 0.08,
                  ),
                ),

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),
              ),

              child:
                  LayoutBuilder(

                builder:
                    (
                  context,
                  constraints,
                ) {

                  final itemWidth =
                      constraints
                              .maxWidth /
                          icons.length;

                  return Stack(
                    alignment: Alignment.center,
                    children: [

                      // Bubble aktif
                      AnimatedPositioned(
                        duration: const Duration(
                          milliseconds: 650,
                        ),

                        curve:
                            Curves.easeOutCubic,

                        left:
                            widget.currentIndex *
                                itemWidth,

                        top:
                            isIdle
                                ? 34
                                : 10,

                        child: Container(
                          width: itemWidth,
                          alignment:
                              Alignment.center,

                          child:
                              AnimatedContainer(

                            duration:
                                const Duration(
                              milliseconds: 650,
                            ),

                            curve:
                                Curves.easeOutExpo,

                            width:
                                isIdle
                                    ? 0
                                    : 55,

                            height:
                                isIdle
                                    ? 0
                                    : 55,

                            decoration:
                                BoxDecoration(
                              color:
                                  AppColors
                                      .primary,

                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Menu icon
                      AnimatedSlide(

                        duration:
                            const Duration(
                          milliseconds: 650,
                        ),

                        curve:
                            Curves.easeOutExpo,

                        offset:
                            isIdle
                                ? const Offset(
                                    0,
                                    1.5,
                                  )
                                : Offset.zero,

                        child:
                            AnimatedOpacity(

                          duration:
                              const Duration(
                            milliseconds: 400,
                          ),

                          opacity:
                              isIdle
                                  ? 0
                                  : 1,

                          child: Row(
                            children:
                                List.generate(
                              icons.length,
                              (index) {

                                final selected =
                                    widget.currentIndex ==
                                        index;

                                return Expanded(
                                  child: InkWell(
                                    onTap: () {

                                      widget.onTap(
                                          index);

                                      resetTimer();
                                    },

                                    splashColor:
                                        Colors
                                            .transparent,

                                    highlightColor:
                                        Colors
                                            .transparent,

                                    child: SizedBox(
                                      height: 75,

                                      child: Center(
                                        child:
                                            AnimatedScale(

                                          duration:
                                              const Duration(
                                            milliseconds:
                                                500,
                                          ),

                                          curve:
                                              Curves
                                                  .easeOutBack,

                                          scale:
                                              selected
                                                  ? 1.15
                                                  : 1,

                                          child:
                                              Icon(
                                            icons[
                                                index],

                                            color:
                                                Colors
                                                    .white,

                                            size:
                                                26,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      // Idle bar
                      AnimatedSlide(

                        duration:
                            const Duration(
                          milliseconds: 650,
                        ),

                        curve:
                            Curves.easeOutExpo,

                        offset:
                            isIdle
                                ? Offset.zero
                                : const Offset(
                                    0,
                                    2,
                                  ),

                        child:
                            AnimatedOpacity(

                          duration:
                              const Duration(
                            milliseconds: 500,
                          ),

                          opacity:
                              isIdle
                                  ? 1
                                  : 0,

                          child: Row(
                            children:
                                List.generate(
                              icons.length,
                              (index) {

                                final selected =
                                    widget.currentIndex ==
                                        index;

                                return Expanded(
                                  child: Center(
                                    child:
                                        AnimatedContainer(

                                      duration:
                                          const Duration(
                                        milliseconds:
                                            550,
                                      ),

                                      curve:
                                          Curves
                                              .easeOutBack,

                                      width:
                                          selected
                                              ? 40
                                              : 16,

                                      height: 5,

                                      decoration:
                                          BoxDecoration(
                                        color:
                                            selected
                                                ? AppColors
                                                    .primary
                                                : Colors
                                                    .white12,

                                        borderRadius:
                                            BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
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
        ),
      ),
    );
  }
}