import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverStretchyHeader extends StatefulWidget {
  const SliverStretchyHeader({
    super.key,
    required this.title,
    required this.background,
    this.expandedWidget,
    this.expandedHeight = 280,
    this.stretchTriggerOffset = 100,
    this.onStretchTrigger,
  });

  final Widget title;
  final Widget background;
  final Widget? expandedWidget;
  final double expandedHeight;
  final double stretchTriggerOffset;
  final AsyncCallback? onStretchTrigger;

  @override
  State<SliverStretchyHeader> createState() => _SliverStretchyHeaderState();
}

class _SliverStretchyHeaderState extends State<SliverStretchyHeader> {
  late OverScrollHeaderStretchConfiguration _stretchConfiguration = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: widget.stretchTriggerOffset,
    onStretchTrigger: widget.onStretchTrigger,
  );

  void _updateStretchConfiguration() {
    setState(() {
      _stretchConfiguration = OverScrollHeaderStretchConfiguration(
        stretchTriggerOffset: widget.stretchTriggerOffset,
        onStretchTrigger: widget.onStretchTrigger,
      );
    });
  }

  @override
  void didUpdateWidget(covariant SliverStretchyHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stretchTriggerOffset != widget.stretchTriggerOffset ||
        oldWidget.onStretchTrigger != widget.onStretchTrigger) {
      _updateStretchConfiguration();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.paddingOf(context).top;
    final double expandendHeight = widget.expandedHeight + topPadding;
    final double collapsedHeight = kToolbarHeight + topPadding;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: SliverPersistentHeader(
        pinned: true,
        delegate: _SliverStretchyHeaderDelegate(
          title: widget.title,
          background: widget.background,
          collapsedHeight: collapsedHeight,
          expandedHeight: expandendHeight,
          expandedWidget: widget.expandedWidget,
          stretchConfiguration: _stretchConfiguration,
        ),
      ),
    );
  }
}

class _SliverStretchyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget title;
  final Widget background;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget? expandedWidget;

  _SliverStretchyHeaderDelegate({
    required this.title,
    required this.background,
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.stretchConfiguration,
    this.expandedWidget,
  });

  @override
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(covariant _SliverStretchyHeaderDelegate oldDelegate) {
    return title != oldDelegate.title ||
        background != oldDelegate.background ||
        collapsedHeight != oldDelegate.minExtent ||
        expandedHeight != oldDelegate.maxExtent ||
        expandedWidget != oldDelegate.expandedWidget ||
        stretchConfiguration != oldDelegate.stretchConfiguration;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double progress = clampDouble(shrinkOffset / constraints.maxHeight, 0, 1);
        final double expandedWidgetOpacity = 1 - clampDouble(progress, 0, 1);
        final bool hideExpandedWidget = expandedWidget == null || expandedWidgetOpacity == 0;

        return Stack(
          fit: StackFit.expand,
          children: [
            _SliverStretchyHeaderAppBar(
              title: title,
              background: background,
              progress: progress,
              minExtent: minExtent,
              maxExtent: maxExtent,
              shrinkOffset: shrinkOffset,
              overlapsContent: overlapsContent,
            ),
            Offstage(
              offstage: hideExpandedWidget,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: expandedWidgetOpacity,
                  child: expandedWidget,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SliverStretchyHeaderAppBar extends StatelessWidget {
  const _SliverStretchyHeaderAppBar({
    required this.title,
    required this.background,
    required this.progress,
    required this.minExtent,
    required this.maxExtent,
    required this.shrinkOffset,
    required this.overlapsContent,
  });

  final Widget title;
  final Widget background;
  final double progress;
  final double minExtent;
  final double maxExtent;
  final double shrinkOffset;
  final bool overlapsContent;

  @override
  Widget build(BuildContext context) {
    final double titleOffset = clampDouble(progress * 2 - 1, 0, 1);
    final double titleOpacity = clampDouble(progress * 5 - 4, 0, 1);
    final double backgroundOpacity = 1 - clampDouble(progress - 0.01, 0, 1);
    final double currentExtent = math.max(minExtent, maxExtent - shrinkOffset);
    final bool isScrolledUnder = overlapsContent || shrinkOffset > maxExtent - minExtent;

    return FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: currentExtent,
      isScrolledUnder: isScrolledUnder,
      child: AppBar(
        elevation: isScrolledUnder ? 4 : 0,
        flexibleSpace: FlexibleSpaceBar(
          expandedTitleScale: 1,
          stretchModes: const [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
          ],
          title: FractionalTranslation(
            translation: Offset(0, 1 - titleOffset),
            child: Opacity(
              opacity: titleOpacity,
              child: title,
            ),
          ),
          background: Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: backgroundOpacity,
                child: background,
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.25, 1],
                    colors: [
                      Colors.black,
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
