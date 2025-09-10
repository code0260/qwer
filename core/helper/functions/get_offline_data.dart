import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/repo/general%20repo/general_repo_imp.dart';
import 'package:toastification/toastification.dart';

Future<void> getOfflineData() async {
  var result = await getIt.get<GeneralRepoImpl>().getOfflineData();
  result.fold((l) {
    mySnackBar(ToastificationType.error, "خطأ", "لم يتم تحميل البيانات");
  }, (r) => null);
}
