import 'package:flutter/material.dart';
import 'package:dharma/utils/responsive_utils.dart';

class Header extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final double? expandedHeight;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final double? elevation;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  
  const Header({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.flexibleSpace,
    this.expandedHeight,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation,
    this.textColor = Colors.white,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: true,
      pinned: true,
      snap: false,
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      leading: showBackButton 
          ? leading ?? IconButton(
              icon: Icon(Icons.arrow_back_ios, size: ResponsiveUtils.wp(5), color: textColor),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize != null ? ResponsiveUtils.fontSize(fontSize!) : ResponsiveUtils.fontSize(22),
          fontWeight: fontWeight,
        ),
      ),
      actions: actions,
      flexibleSpace: flexibleSpace ?? FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.primaryColor,
                theme.primaryColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(ResponsiveUtils.wp(5)),
              bottomRight: Radius.circular(ResponsiveUtils.wp(5)),
            ),
          ),
        ),
      ),
    );
  }
}

// Simple scaffold implementation with responsive header
class ResponsiveScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;
  
  const ResponsiveScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.actions,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.grey[50],
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            Header(title: title, actions: actions),
          ];
        },
        body: body,
      ),
    );
  }
}
