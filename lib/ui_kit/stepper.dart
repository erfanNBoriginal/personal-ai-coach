import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class Stepper extends StatefulWidget {
  final int id;
  final List<StepperItem> items;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool isMoveable;
  final bool useDashedLine;
  final int count;
  final Function(int count, bool shouldExpand)? onExapndedCountChanged;

  const Stepper({
    super.key,
    required this.items,
    required this.id,
    this.shrinkWrap = true,
    this.physics,
    this.onExapndedCountChanged,
    this.isMoveable = false,
    this.useDashedLine = false,
    this.count = 0,
  });

  @override
  State<Stepper> createState() => _StepperState();
}

class _StepperState extends State<Stepper> with TickerProviderStateMixin {
  int? expandedIndex;

  bool get hasExpandedItem => expandedIndex != null;

  @override
  void didUpdateWidget(covariant Stepper oldWidget) {
    if (oldWidget.count != widget.count) {
      // print('widget.count');
      // print(widget.count);
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final shouldMove = hasExpandedItem && widget.isMoveable;
    return LayoutBuilder(
      builder: (context, constraints) {
        // print('widget.counttttttttttt');
        // print(widget.count.toDouble());
        const expansion = 0.08;
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          tween: Tween<double>(end: shouldMove ? widget.count.toDouble() : 0.0),
          builder: (context, value, child) {
            // final shift = constraints.maxWidth * expansion * value;
            return Transform.translate(
              offset: Offset(0, 0),
              child: FractionallySizedBox(
                alignment: Alignment.topRight,
                widthFactor: 1 + (expansion * value),
                child: child,
              ),
            );
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.items.length,
            shrinkWrap: widget.shrinkWrap,
            primary: false,
            physics:
                widget.physics ??
                (widget.shrinkWrap
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics()),
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final isExpanded = expandedIndex == index;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Dynamic connector.
                    //
                    // Its height is based on the real height of the Row/step content.
                    // It begins below this bullet and reaches the next bullet.
                    if (index != widget.items.length - 1)
                      Positioned(
                        left: 5.0, // (18 bullet width - 3 line width) / 2
                        top: widget.useDashedLine
                            ? 20
                            : 25, // directly below this item's bullet
                        bottom: widget.useDashedLine
                            ? -18
                            : -23, // extends through this item's bottom spacing
                        child: widget.useDashedLine
                            ? SizedBox(
                                width: 3,
                                child: VerticalDashedLine(
                                  color: U.Theme.divider,
                                  width: 3,
                                  dashHeight: 6,
                                  dashSpacing: 4,
                                  radius: 12,
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                width: 3,
                                decoration: BoxDecoration(
                                  color: U.Theme.divider,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                      ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 13),
                            item.isDone
                                ? Container(
                                    height: 13,
                                    width: 13,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  )
                                : Container(
                                    height: 14,
                                    width: 14,

                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: U.Theme.primary,
                                      ),
                                      shape: BoxShape.circle,
                                      color: item.inProgress
                                          ? U.Theme.primary
                                          : U.Theme.white,
                                    ),

                                    child: Center(
                                      child: Container(
                                        height: 6,
                                        width: 6,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: item.inProgress
                                              ? U.Theme.white
                                              : U.Theme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              item.subTitle != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Column(
                                        children: [
                                          U.Text(
                                            text: item.subTitle!,
                                            color: U.Theme.primary,
                                          ),
                                          SizedBox(height: 6),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: item.isDisabled
                                    ? null
                                    : () {
                                        widget.onExapndedCountChanged == null
                                            ? null
                                            : widget.onExapndedCountChanged!(
                                                widget.id,
                                                isExpanded,
                                              );
                                        setState(() {
                                          // print('expandedIndex');
                                          // print(expandedIndex);
                                          expandedIndex = isExpanded
                                              ? null
                                              : index;
                                        });
                                      },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: item.isDisabled
                                        ? U.Theme.onBackground.withValues(
                                            alpha: 0.3,
                                          )
                                        : U.Theme.onBackground.withValues(
                                            alpha: 0.6,
                                          ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: U.Text(
                                          text: item.title,
                                          color: item.isDisabled
                                              ? U.Theme.primaryText.withValues(
                                                  alpha: 0.4,
                                                )
                                              : U.Theme.primaryText,
                                          textSize: U.TextSize.s16,
                                          textWeight: U.TextWeight.semiBold,
                                        ),
                                      ),
                                      AnimatedRotation(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        turns: isExpanded ? 0.5 : 0,
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: item.isDisabled
                                              ? U.Theme.secondaryButton
                                                    .withValues(alpha: 0.4)
                                              : U.Theme.secondaryButton,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ClipRect(
                                child: Padding(
                                  padding: item.padding,
                                  child: AnimatedSize(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                    alignment: Alignment.topCenter,
                                    child: isExpanded
                                        ? Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: item
                                                              .itemBackground,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15,
                                                              ),
                                                          // border: Border.all(
                                                          // color: Colors.grey.withValues(
                                                          // alpha: 0.6,
                                                          // ),
                                                          // width: 0.8,
                                                          // ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8,
                                                            ),
                                                        child: item.child,
                                                      ),
                                                    ),
                                                    item.onTap != null
                                                        ? Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              // const SizedBox(
                                                              //   width: 12,
                                                              // ),

                                                              GestureDetector(
                                                                onTap:
                                                                    item.onTap,
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color: U
                                                                        .Theme
                                                                        .divider
                                                                        .withValues(
                                                                          alpha:
                                                                              0.6,
                                                                        ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                        4,
                                                                      ),
                                                                  child: const Icon(
                                                                    Icons
                                                                        .arrow_right_sharp,
                                                                    size: 21,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                                item.loading
                                                    ? Column(
                                                        children: [
                                                          SizedBox(height: 7),
                                                          LoadingAnimationWidget.fourRotatingDots(
                                                            color:
                                                                U.Theme.primary,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class StepperItem {
  final bool isDisabled;
  final bool isDone;
  final bool inProgress;
  final bool loading;
  final EdgeInsetsGeometry padding;
  final String title;
  final String? subTitle;
  final Widget child;
  final Color? itemBackground;
  final Function()? onTap;

  StepperItem({
    this.isDisabled = false,
    this.inProgress = false,
    this.loading = false,
    this.padding = const EdgeInsets.only(left: 16.0),
    required this.isDone,
    required this.title,
    this.subTitle,
    this.itemBackground,
    required this.child,
    this.onTap,
  });
}

class VerticalDashedLine extends StatelessWidget {
  final double width;
  final Color color;
  final double dashHeight;
  final double dashSpacing;
  final double radius;

  const VerticalDashedLine({
    super.key,
    this.width = 3,
    required this.color,
    this.dashHeight = 6,
    this.dashSpacing = 4,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxHeight / (dashHeight + dashSpacing))
            .floor();

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: width,
              height: dashHeight,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
              ),
            );
          }),
        );
      },
    );
  }
}
