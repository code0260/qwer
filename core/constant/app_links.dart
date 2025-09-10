// lib/core/constant/app_links.dart

import 'dart:io';

class AppLinks {
  // هذا الكلاس لا يجب إنشاء نسخ منه، لذلك الكونستركتر خاص
  AppLinks._();

  // ====================== روابط ثابتة (Static & Social) ====================== //
  static const String facebook = 'https://www.facebook.com/share/16RxKjudT3';
  static const String youtube =
      'https://www.youtube.com/@%D8%A7%D9%84%D9%85%D9%86%D8%B8%D9%85-%D8%B21%D8%AC1%D8%AA';
  static const String instagram =
      'https://www.instagram.com/almonazim?igsh=MWhlOGM3cGg4NjdjOA==';
  static const String almonazimWebsite = 'https://almonazim.com';
  static const String introVideoTutorial =
      'https://youtu.be/nsfn88TQ9A8?si=ayYiIir09H8uiJHK';

  // ====================== روابط تحميل التطبيق (Platform Specific) ====================== //
  static const String _androidApp =
      'https://play.google.com/store/apps/details?id=com.almonazim';
  static const String _iosApp =
      'https://apps.apple.com/iq/app/almonazim-%D8%A7%D9%84%D9%85%D9%86%D8%B8%D9%85/id6751020021';
  static const String _windowsApp = 'https://almonazim.com/المنظم.exe';

  static String get downloadLink {
    if (Platform.isWindows) return _windowsApp;
    if (Platform.isIOS) return _iosApp;
    return _androidApp; // Default to Android
  }

  // ====================== API Endpoints (الروابط الجديدة) ====================== //

  // الرابط الأساسي الجديد (Laravel API)
  static const String baseUrl = "https://laravelapi.almonazim.com/api";

  // --- قسم المصادقة (Auth) --- //
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String profile = "$baseUrl/profile";
  static const String updateUser = "$baseUrl/updateUser";
  static const String createAccount = "$baseUrl/create_account";
  static const String showUserAccounts = "$baseUrl/show_user_Accounts";

  // --- قسم الفروع (Branches) --- //
  static const String showBranches = "$baseUrl/showBranches";
  static const String addBranch = "$baseUrl/addBranch";

// سنضيف باقي الأقسام هنا تباعاً...
}