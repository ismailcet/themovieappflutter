import 'package:flutter/cupertino.dart';
import 'package:themovieapp/pages/home_page.dart';

enum NavbarItem { home, search, bookmark }

extension NavbarItemExtension on NavbarItem {
  String get name {
    switch (this) {
      case NavbarItem.home:
        return "Home";
      case NavbarItem.search:
        return "Search";
      case NavbarItem.bookmark:
        return "Watch list";
    }
  }

  int get value {
    switch (this) {
      case NavbarItem.home:
        return 1;
      case NavbarItem.search:
        return 2;
      case NavbarItem.bookmark:
        return 3;
    }
  }
}
