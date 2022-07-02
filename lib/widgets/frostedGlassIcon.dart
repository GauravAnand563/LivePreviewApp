import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class FrostedGlassIcon extends StatefulWidget {
  FrostedGlassIcon({this.onTap, required this.child});
  Function? onTap;
  Widget child;
  @override
  State<FrostedGlassIcon> createState() => _FrostedGlassIconState();
}

class _FrostedGlassIconState extends State<FrostedGlassIcon> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        print('HERE');
        widget.onTap!();
      },
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(23)),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
