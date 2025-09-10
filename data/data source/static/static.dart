import 'package:almonazim/core/constant/app_assets.dart';
import 'package:almonazim/data/model/onboarding_model.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title: "إدارة الحسابات بسهولة",
      body:
          "قم بمتابعة جميع معاملاتك المالية وتسجيل الإيرادات والمصروفات بكل سهولة ودقة.",
      image: Assets.assetsImagesProcess),
  OnBoardingModel(
      title: "تتبع المخزون والمبيعات",
      body:
          "راقب مخزونك وقم بتحديث المنتجات والمبيعات بشكل مباشر لتتخذ قرارات أفضل.",
      image: Assets.assetsImagesResearch),
  OnBoardingModel(
      title: "تقارير شاملة وذكية",
      body:
          "احصل على تقارير تفصيلية تساعدك في فهم أداء عملك المالي واتخاذ قرارات مستنيرة.",
      image: Assets.assetsImagesAnalysis),
];
