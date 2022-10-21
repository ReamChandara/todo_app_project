import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = "isDarkModel";
  saveThemeToBox(bool isdarkMode) => _box.write(_key, isdarkMode);
  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!_loadThemeFromBox());
  }
}