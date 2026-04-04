import '../utils/import.dart';
class CustomExpandText extends StatefulWidget {
  const CustomExpandText({
    super.key,
    required this.text,
    this.trimLines = 3,
    this.style,
    this.readMoreStyle,
    this.padding = EdgeInsets.zero,
  });
  final String text;
  final int trimLines;
  final TextStyle? style;
  final TextStyle? readMoreStyle;
  final EdgeInsetsGeometry padding;
  @override
  State<CustomExpandText> createState() => _CustomExpandTextState();
}
class _CustomExpandTextState extends State<CustomExpandText> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle =
        widget.style ??
        AppTextStyle.regular(size: 14, color: theme.colorScheme.onSurface);
    final moreStyle =
        widget.readMoreStyle ??
        AppTextStyle.bold(size: 14, color: AppColor.kPrimary);
    final loc = context.loc;
    return Padding(
      padding: widget.padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final span = TextSpan(text: widget.text, style: textStyle);
          final tp = TextPainter(
            text: span,
            maxLines: widget.trimLines,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);
          if (!tp.didExceedMaxLines) {
            return Text(widget.text, style: textStyle);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.topCenter,
                child: Text(
                  widget.text,
                  style: textStyle,
                  maxLines: _isExpanded ? null : widget.trimLines,
                  overflow: _isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
              ),
              const Gap(4),
              CustomInkWell(
                onTap: () {
                  setState(() => _isExpanded = !_isExpanded);
                  Get.find<AnalyticsService>().logClick(
                    widgetName: 'CustomExpandText',
                    clickName: _isExpanded
                        ? ClickEvents.showLessClick
                        : ClickEvents.readMoreClick,
                  );
                },
                clickName: _isExpanded
                    ? ClickEvents.showLessClick
                    : ClickEvents.readMoreClick,
                child: Text(
                  _isExpanded ? loc.showLess : loc.readMore,
                  style: moreStyle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
