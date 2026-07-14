import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class Stepper extends StatefulWidget {
  final List<StepperItem> items;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool isMoveable;

  const Stepper({
    super.key,
    required this.items,
    this.shrinkWrap = true,
    this.physics,
    this.isMoveable = false,
  });

  @override
  State<Stepper> createState() => _StepperState();
}

class _StepperState extends State<Stepper> with TickerProviderStateMixin {
  int? expandedIndex;

  bool get hasExpandedItem => expandedIndex != null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      offset: hasExpandedItem && widget.isMoveable
          ? const Offset(-0.08, 0)
          : Offset.zero,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.isDone ? Colors.green : Colors.grey,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      width: 3,
                      height: isExpanded ? 80 : 25,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: U.Theme.divider,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          setState(() {
                            expandedIndex = isExpanded ? null : index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: U.Theme.onBackground.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: U.Text(
                                  text: item.title,
                                  textSize: U.TextSize.s18,
                                  textWeight: U.TextWeight.semiBold,
                                ),
                              ),
                              AnimatedRotation(
                                duration: const Duration(milliseconds: 200),
                                turns: isExpanded ? 0.5 : 0,
                                child: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ClipRect(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            alignment: Alignment.topCenter,
                            child: isExpanded
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: U.Theme.outline.withValues(
                                        alpha: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.grey.withValues(
                                          alpha: 0.6,
                                        ),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: item.child,
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
          );
        },
      ),
    );
  }
}

class StepperItem {
  final bool isDone;
  final String title;
  final Widget child;

  StepperItem({required this.isDone, required this.title, required this.child});
}
