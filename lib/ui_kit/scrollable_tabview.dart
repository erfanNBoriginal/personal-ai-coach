import 'package:flutter/material.dart';

class ScrollableTabview extends StatefulWidget {
  final List<Widget> headers;
  final List<Widget> pages;

  const ScrollableTabview({
    super.key,
    required this.headers,
    required this.pages,
  }) : assert(headers.length == pages.length);

  @override
  State<ScrollableTabview> createState() => _ScrollableTabviewState();
}

enum _SyncSource {
  tabs,
  pages,
}

class _ScrollableTabviewState extends State<ScrollableTabview> {
  final ScrollController _tabController = ScrollController();
  final PageController _pageController = PageController();
// 0.5 means change at halfway.
  // 0.7 means user must drag 70% toward the next item before changing.
  // Increase it for less sensitivity, e.g. 0.8.
  static const double _pageChangeThreshold = 0.70;

  static const Duration _pageChangeDuration = Duration(milliseconds: 220);
  _SyncSource? _syncSource;
  int _activeIndex = 0;

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  double _progress(ScrollMetrics metrics) {
    if (metrics.maxScrollExtent <= 0) return 0;

    return (metrics.pixels / metrics.maxScrollExtent).clamp(0.0, 1.0);
  }

  void _updateActiveIndex(double progress) {
    if (widget.pages.length <= 1) return;

    final index = (progress * (widget.pages.length - 1))
        .round()
        .clamp(0, widget.pages.length - 1);

    if (index != _activeIndex && mounted) {
      setState(() => _activeIndex = index);
    }
  }

  void _jumpToIfNeeded(ScrollController controller, double target) {
    if (!controller.hasClients) return;

    final position = controller.position;
    final clampedTarget = target.clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    // Avoid unnecessary jumpTo calls, which can cause jitter.
    if ((position.pixels - clampedTarget).abs() > 0.5) {
      controller.jumpTo(clampedTarget);
    }
  }
void _updatePageFromTabScroll() {
    if (!_tabController.hasClients || !_pageController.hasClients) return;
    if (widget.pages.length <= 1) return;

    final progress = _progress(_tabController.position);

    final maxIndex = widget.pages.length - 1;

    // Progress distance represented by one page.
    //
    // Example with 4 pages:
    // page 0 = 0.0
    // page 1 = 0.333
    // page 2 = 0.666
    // page 3 = 1.0
    final onePageProgress = 1 / maxIndex;

    // Where the currently active page sits in the tab-list progress.
    final activePageProgress = _activeIndex * onePageProgress;

    final difference = progress - activePageProgress;

    int targetIndex = _activeIndex;

    // User is scrolling toward later pages.
    if (difference >= onePageProgress * _pageChangeThreshold) {
      final pagesToMove = (difference / onePageProgress).ceil();

      targetIndex = (_activeIndex + pagesToMove).clamp(0, maxIndex);
    }
    // User is scrolling back toward earlier pages.
    else if (difference <= -onePageProgress * _pageChangeThreshold) {
      final pagesToMove = (difference.abs() / onePageProgress).ceil();

      targetIndex = (_activeIndex - pagesToMove).clamp(0, maxIndex);
    }

    // Do nothing until the user crosses the threshold.
    if (targetIndex == _activeIndex) return;

    setState(() => _activeIndex = targetIndex);

    // Animate only once after crossing the threshold.
    _pageController.animateToPage(
      targetIndex,
      duration: _pageChangeDuration,
      curve: Curves.easeOutCubic,
    );
  }
  // User drags the tab ListView -> move the PageView.
bool _onTabNotification(ScrollNotification notification) {
    if (notification.depth != 0) return false;

    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _syncSource = _SyncSource.tabs;
    }

    if (notification is ScrollUpdateNotification &&
        _syncSource == _SyncSource.tabs) {
      _updatePageFromTabScroll();
    }

    if (notification is ScrollEndNotification &&
        _syncSource == _SyncSource.tabs) {
      _syncSource = null;
    }

    return false;
  }

  // User drags the PageView -> move the tab ListView.
  bool _onPageNotification(ScrollNotification notification) {
    if (notification.depth != 0) return false;

    // A real user drag started on the PageView.
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _syncSource = _SyncSource.pages;
    }

    if (notification is ScrollUpdateNotification &&
        _syncSource == _SyncSource.pages &&
        _tabController.hasClients) {
      final progress = _progress(notification.metrics);

      final targetTabPixels =
          progress * _tabController.position.maxScrollExtent;

      _jumpToIfNeeded(_tabController, targetTabPixels);
      _updateActiveIndex(progress);
    }

    if (notification is ScrollEndNotification &&
        _syncSource == _SyncSource.pages) {
      _syncSource = null;
    }

    return false;
  }

  Future<void> _onTabTap(int index) async {
    if (!_pageController.hasClients) return;

    setState(() => _activeIndex = index);

    // Treat this animation as a page-originated change, so tabs follow it.
    _syncSource = _SyncSource.pages;

    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    if (mounted && _syncSource == _SyncSource.pages) {
      _syncSource = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: NotificationListener<ScrollNotification>(
            onNotification: _onTabNotification,
            child: ListView.separated(
              controller: _tabController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),

              // Optional, but avoids iOS overscroll/bounce affecting sync.
              physics: const ClampingScrollPhysics(),

              itemCount: widget.headers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final isActive = index == _activeIndex;

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onTabTap(index),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: isActive ? 1 : 0.6,
                    child: widget.headers[index],
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 77,
          child: NotificationListener<ScrollNotification>(
            onNotification: _onPageNotification,
            child: PageView(
              controller: _pageController,
              children: widget.pages,
            ),
          ),
        ),
      ],
    );
  }
}