import 'package:get/get.dart';
import 'package:ubs/model/ads_post.dart';
import 'package:ubs/services/remote_services.dart';

class PostDetailsController extends GetxController {
  Rx<AdsPost> adsPost = AdsPost(
          pId: 0,
          pDate: DateTime.now(),
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
          uName: '',
          pFavorite: 0,
          pView: 0,
          uPhoto: "")
      .obs;

  @override
  void onInit() {
    super.onInit();
  }

  getAdsPostDetails(AdsPost adsData) async {
    var res =
        await RemoteServices.getAdsPostDetails(adsData.pUid, adsData.pId!);
    if (res != null) {
      adsPost.value = res;
    }
  }
}
