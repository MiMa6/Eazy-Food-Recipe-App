import 'package:flutter/material.dart';
import 'home_page_mobile_and_tablet.dart';
import 'home_page_desktop.dart';
import '../../components/size_constraints.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileBreakpoint) {
        return const HomePageMobileAndTablet();
      } else if (constraints.maxWidth < tabletBreakpoint) {
        return const HomePageMobileAndTablet();
      } else {
        return const HomePageDesktop();
      }
    });
  }
}
