import 'package:flutter/material.dart';
import 'package:dharma/utils/responsive_utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveUtils utils) builder;

  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = ResponsiveUtils();
    utils.init(context);
    return builder(context, utils);
  }
}
