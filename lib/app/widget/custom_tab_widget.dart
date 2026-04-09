import '../utils/import.dart';

@immutable
class TabItemData {
  final int id;
  final String title;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? analyticsEventName;
  final Widget? customContent;
  final TextStyle? textStyle;
  final double? height;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool enabled;
  const TabItemData({
    required this.id,
    required this.title,
    this.onTap,
    this.onLongPress,
    this.analyticsEventName,
    this.customContent,
    this.textStyle,
    this.height,
    this.padding,
    this.decoration,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
  });
  TabItemData copyWith({
    String? title,
    int? id,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? analyticsEventName,
    Widget? customContent,
    TextStyle? textStyle,
    double? height,
    EdgeInsets? padding,
    BoxDecoration? decoration,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool? enabled,
  }) {
    return TabItemData(
      id: id ?? this.id,
      title: title ?? this.title,
      onTap: onTap ?? this.onTap,
      onLongPress: onLongPress ?? this.onLongPress,
      analyticsEventName: analyticsEventName ?? this.analyticsEventName,
      customContent: customContent ?? this.customContent,
      textStyle: textStyle ?? this.textStyle,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      decoration: decoration ?? this.decoration,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabItemData &&
        other.title == title &&
        other.enabled == enabled;
  }

  @override
  int get hashCode => Object.hash(title, enabled);
}

enum TabScrollAlignment { start, center, ensureVisible }

class ScrollableAnimatedTabBar extends StatefulWidget {
  final List<TabItemData> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final EdgeInsets tabPadding;
  final double defaultTabHeight;
  final double tabBorderRadius;
  final double leadingPadding;
  final double trailingPadding;
  final double tabSpacing;
  final bool centerSelectedTabInitially;
  final MainAxisSize rowMainAxisSize;
  final ScrollPhysics? scrollPhysics;
  final Color? selectedBackgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final Color? disabledBorderColor;
  final double selectedBorderWidth;
  final double unselectedBorderWidth;
  final bool showBorder;
  final List<BoxShadow>? selectedShadow;
  final List<BoxShadow>? unselectedShadow;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final TextStyle? disabledTextStyle;
  final Duration animationDuration;
  final Curve animationCurve;
  final Duration scrollAnimationDuration;
  final Curve scrollAnimationCurve;
  final Gradient? selectedGradient;
  final Gradient? unselectedGradient;
  final BoxDecoration Function(bool isSelected, int index, bool isEnabled)?
  decorationBuilder;
  final Widget Function(
    TabItemData tab,
    bool isSelected,
    int index,
    bool isEnabled,
  )?
  tabBuilder;
  final bool enableHapticFeedback;
  final double? tabMinWidth;
  final double? tabMaxWidth;
  final bool shrinkWrap;
  final TabScrollAlignment scrollAlignment;
  final double iconSpacing;
  const ScrollableAnimatedTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.defaultTabHeight = 38,
    this.tabBorderRadius = 8,
    this.leadingPadding = 16,
    this.trailingPadding = 16,
    this.tabSpacing = 10,
    this.centerSelectedTabInitially = false,
    this.rowMainAxisSize = MainAxisSize.min,
    this.scrollPhysics,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.disabledBorderColor,
    this.selectedBorderWidth = 1,
    this.unselectedBorderWidth = 1,
    this.showBorder = true,
    this.selectedShadow,
    this.unselectedShadow,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.disabledTextStyle,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeInOut,
    this.scrollAnimationDuration = const Duration(milliseconds: 300),
    this.scrollAnimationCurve = Curves.easeInOut,
    this.selectedGradient,
    this.unselectedGradient,
    this.decorationBuilder,
    this.tabBuilder,
    this.enableHapticFeedback = false,
    this.tabMinWidth,
    this.tabMaxWidth,
    this.shrinkWrap = false,
    this.scrollAlignment = TabScrollAlignment.center,
    this.iconSpacing = 6,
  }) : assert(selectedIndex >= 0 && selectedIndex < tabs.length);
  @override
  State<ScrollableAnimatedTabBar> createState() =>
      _ScrollableAnimatedTabBarState();
}

class _ScrollableAnimatedTabBarState extends State<ScrollableAnimatedTabBar> {
  late final ScrollController _scrollController;
  late final List<GlobalKey> _tabKeys;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabKeys = List.generate(widget.tabs.length, (_) => GlobalKey());
    if (widget.centerSelectedTabInitially) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollToIndex(widget.selectedIndex),
      );
    }
  }

  @override
  void didUpdateWidget(covariant ScrollableAnimatedTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length > _tabKeys.length) {
      _tabKeys.addAll(
        List.generate(widget.tabs.length - _tabKeys.length, (_) => GlobalKey()),
      );
    } else if (widget.tabs.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.tabs.length, _tabKeys.length);
    }
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollToIndex(widget.selectedIndex),
      );
    }
  }

  void _scrollToIndex(int index) {
    if (!_scrollController.hasClients) return;
    if (index < 0 || index >= _tabKeys.length) return;
    final contextBox = _tabKeys[index].currentContext;
    if (contextBox == null) return;
    final renderBox = contextBox.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;
    final min = _scrollController.position.minScrollExtent;
    final max = _scrollController.position.maxScrollExtent;
    if (max <= min) return;
    final position = renderBox.localToGlobal(
      Offset.zero,
      ancestor: context.findRenderObject(),
    );
    double targetOffset;
    switch (widget.scrollAlignment) {
      case TabScrollAlignment.start:
        targetOffset = _scrollController.offset + position.dx;
        break;
      case TabScrollAlignment.ensureVisible:
        final start = position.dx;
        final end = start + renderBox.size.width;
        final viewport = MediaQuery.of(context).size.width;
        if (start < 0) {
          targetOffset = _scrollController.offset + start;
        } else if (end > viewport) {
          targetOffset = _scrollController.offset + (end - viewport);
        } else {
          return;
        }
        break;
      case TabScrollAlignment.center:
        final tabCenter = position.dx + renderBox.size.width / 2;
        final screenCenter = MediaQuery.of(context).size.width / 2;
        targetOffset = _scrollController.offset + tabCenter - screenCenter;
        break;
    }
    _scrollController.animateTo(
      targetOffset.clamp(min, max),
      duration: widget.scrollAnimationDuration,
      curve: widget.scrollAnimationCurve,
    );
  }

  BoxDecoration _resolveDecoration(
    bool isSelected,
    int index,
    bool isEnabled,
    bool isDark,
  ) {
    final tab = widget.tabs[index];
    if (tab.decoration != null) return tab.decoration!;
    if (widget.decorationBuilder != null) {
      return widget.decorationBuilder!(isSelected, index, isEnabled);
    }
    if (!isEnabled) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(widget.tabBorderRadius),
        border: widget.showBorder
            ? Border.all(
                color: widget.disabledBorderColor ?? AppColor.divider(context),
                width: widget.unselectedBorderWidth,
              )
            : null,
        color: widget.disabledBackgroundColor ?? AppColor.scaffold(context),
      );
    }
    return BoxDecoration(
      borderRadius: BorderRadius.circular(widget.tabBorderRadius),
      border: widget.showBorder
          ? Border.all(
              color: isSelected
                  ? (widget.selectedBorderColor ?? AppColor.kPrimary)
                  : (widget.unselectedBorderColor ?? AppColor.divider(context)),
              width: isSelected
                  ? widget.selectedBorderWidth
                  : widget.unselectedBorderWidth,
            )
          : null,
      color: isSelected
          ? (widget.selectedGradient == null
                ? (widget.selectedBackgroundColor ?? AppColor.kPrimary)
                : null)
          : (widget.unselectedGradient == null
                ? (widget.unselectedBackgroundColor ??
                      (Theme.of(context).brightness == Brightness.dark
                          ? AppColor.kScaffoldDark
                          : AppColor.kWhite))
                : null),
      gradient: isSelected
          ? widget.selectedGradient
          : widget.unselectedGradient,
      boxShadow: isSelected ? widget.selectedShadow : widget.unselectedShadow,
    );
  }

  TextStyle _resolveTextStyle(
    TabItemData tab,
    bool isSelected,
    bool isEnabled,
    bool isDark,
  ) {
    if (tab.textStyle != null) return tab.textStyle!;
    final textColor = AppColor.text(context);
    if (!isEnabled) {
      return widget.disabledTextStyle ??
          AppTextStyle.regular(
            size: 14,
            fontWeight: FontWeight.w600,
            color: widget.disabledTextColor ?? textColor.withValues(alpha: 0.3),
          );
    }
    return isSelected
        ? widget.selectedTextStyle ??
              AppTextStyle.semiBold(
                size: 14,
                fontWeight: FontWeight.w600,
                color: widget.selectedTextColor ?? AppColor.kWhite,
              )
        : widget.unselectedTextStyle ??
              AppTextStyle.regular(
                size: 14,
                fontWeight: FontWeight.w600,
                color: widget.unselectedTextColor ?? textColor,
              );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: widget.defaultTabHeight,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: widget.scrollPhysics ?? const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: widget.leadingPadding,
          right: widget.trailingPadding,
        ),
        itemCount: widget.tabs.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: widget.tabSpacing),
        itemBuilder: (context, index) {
          final tab = widget.tabs[index];
          final isSelected = index == widget.selectedIndex;
          final isEnabled = tab.enabled;
          return CustomInkWell(
            key: _tabKeys[index],
            onTap: isEnabled ? () => widget.onTabChanged(index) : null,
            borderRadius: BorderRadius.circular(widget.tabBorderRadius),
            child: AnimatedContainer(
              duration: widget.animationDuration,
              curve: widget.animationCurve,
              height: tab.height ?? widget.defaultTabHeight,
              padding: widget.tabPadding,
              decoration: _resolveDecoration(
                isSelected,
                index,
                isEnabled,
                isDark,
              ),
              child: _buildTabContent(tab, isSelected, isEnabled, isDark),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabContent(
    TabItemData tab,
    bool isSelected,
    bool isEnabled,
    bool isDark,
  ) {
    if (tab.customContent != null) return tab.customContent!;
    final text = CustomTextView(
      text: tab.title,
      style: _resolveTextStyle(tab, isSelected, isEnabled, isDark),
    );
    if (tab.leadingIcon == null && tab.trailingIcon == null) return text;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (tab.leadingIcon != null) ...[
          tab.leadingIcon!,
          SizedBox(width: widget.iconSpacing),
        ],
        text,
        if (tab.trailingIcon != null) ...[
          SizedBox(width: widget.iconSpacing),
          tab.trailingIcon!,
        ],
      ],
    );
  }
}
