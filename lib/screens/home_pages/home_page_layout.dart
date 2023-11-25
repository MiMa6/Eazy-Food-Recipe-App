import 'package:flutter/material.dart';

import './home_page_mobile.dart';
import './home_page_desktop.dart';
import './home_page_tablet.dart';
import '../../components/size_constraints.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileBreakpoint) {
        return const HomePageMobile();
      } else if (constraints.maxWidth < tabletBreakpoint) {
        return const HomePageTablet();
      } else {
        return const HomePageDesktop();
      }
    });
  }
}