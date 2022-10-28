import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/model/categories.dart';
import 'package:ubs/services/remote_services.dart';

class SellingController extends GetxController {
  final sellingPost = AdsPost(
          pTitle: "",
          pBrand: "",
          pDescribe: "",
          pImg1: "",
          pImg2: "",
          pImg3: "",
          pImg4: "",
          pImg5: "",
          pPrice: 0,
          pLocation: "",
          pMcat: 0,
          pScat: 0,
          pUid: "",
          userId: "").obs;

  var mainCatList = List<Categories>.empty().obs;
  var subCatList = List<Categories>.empty().obs;
  RxString page_status = "".obs;

  @override
  void onInit() {
    fetchMainCategories();
    super.onInit();
  }

  void fetchMainCategories() async {
    var mainCat = await RemoteServices.fetchMainCat();
    if (mainCat != null) {
      mainCatList.value = mainCat;
    }
  }

  void getSubCat(int mainCat) async {
    var subCat = await RemoteServices.fetchSubCat(mainCat);
    if (subCat != null) {
      subCatList.value = subCat;
      sellingPost.value.pMcat = mainCat;
    }
  }

  insertPostAds(AdsPost adsPost) async {
    page_status.value = "Loading";
    var res = await RemoteServices.postAds(adsPost);
    if (res != null) {
      page_status.value = "Your Post uploaded successfully";
      
    }
  }
}
