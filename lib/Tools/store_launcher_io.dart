import 'package:open_store/open_store.dart';

void launchStore({required String appStoreId, String androidAppBundleId = ""}) {
  OpenStore.instance.open(
    appStoreId: appStoreId,
    androidAppBundleId: androidAppBundleId,
  );
}
