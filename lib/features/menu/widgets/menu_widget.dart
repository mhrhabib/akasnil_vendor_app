import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/features/restock/screens/restock_list_screen.dart';
import 'package:sixvalley_vendor_app/features/shop/controllers/shop_controller.dart';
import 'package:sixvalley_vendor_app/localization/controllers/localization_controller.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/features/profile/controllers/profile_controller.dart';
import 'package:sixvalley_vendor_app/features/splash/controllers/splash_controller.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/common/basewidgets/custom_bottom_sheet_widget.dart';
import 'package:sixvalley_vendor_app/features/addProduct/screens/add_product_screen.dart';
import 'package:sixvalley_vendor_app/features/chat/screens/inbox_screen.dart';
import 'package:sixvalley_vendor_app/features/coupon/screens/coupon_list_screen.dart';
import 'package:sixvalley_vendor_app/features/dashboard/screens/nav_bar_screen.dart';
import 'package:sixvalley_vendor_app/features/delivery_man/screens/delivery_man_setup_screen.dart';
import 'package:sixvalley_vendor_app/features/menu/widgets/sign_out_confirmation_dialog_widget.dart';
import 'package:sixvalley_vendor_app/features/more/screens/html_view_screen.dart';
import 'package:sixvalley_vendor_app/features/product/screens/product_list_screen.dart';
import 'package:sixvalley_vendor_app/features/profile/screens/profile_view_screen.dart';
import 'package:sixvalley_vendor_app/features/review/screens/product_review_screen.dart';
import 'package:sixvalley_vendor_app/features/settings/screens/setting_screen.dart';
import 'package:sixvalley_vendor_app/features/shop/screens/shop_screen.dart';
import 'package:sixvalley_vendor_app/features/wallet/screens/wallet_screen.dart';
import 'package:sixvalley_vendor_app/features/bank_info/screens/bank_info_screen.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

import '../../../common/basewidgets/custom_image_widget.dart';
import '../../../theme/controllers/theme_controller.dart';

class MenuBottomSheetWidget extends StatelessWidget {
  const MenuBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> activateMenu = [
      Consumer<ProfileController>(builder: (context, profile, child) {
        return CustomBottomSheetWidget(
            image: '${Provider.of<SplashController>(context, listen: false).baseUrls!.sellerImageUrl}/${Provider.of<ProfileController>(context, listen: false).userInfoModel?.image}',
            isProfile: true,
            title: profile.userInfoModel!.fName!,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreenView())));
      }),
      Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: ColorResources.getBottomSheetColor(context),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeController>(context).darkTheme ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.3)],
        ),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            title: Text('Shop Management',
                textAlign: TextAlign.center, maxLines: Provider.of<LocalizationController>(context, listen: false).isLtr ? 1 : 1, overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
            leading: SizedBox(
              width: MediaQuery.of(context).size.width / 14,
              height: MediaQuery.of(context).size.width / 14,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(Images.myShop),
              ),
            ),
            children: [
              // CustomBottomSheetWidget(image: Images.myShop, title: getTranslated('my_shop', context), onTap: () => ),
              CustomBottomSheetWidget(image: Images.productIconPp, title: getTranslated('products', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListMenuScreen()))),
              CustomBottomSheetWidget(image: Images.addProduct, title: getTranslated('add_product', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductScreen()))),
            ],
          ),
        ),
      ),
      CustomBottomSheetWidget(image: Images.reviewIcon, title: getTranslated('reviews', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductReviewScreen()))),
      CustomBottomSheetWidget(image: Images.couponIcon, title: getTranslated('coupons', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CouponListScreen()))),
      if (Provider.of<SplashController>(context, listen: false).configModel!.shippingMethod == 'sellerwise_shipping')
        CustomBottomSheetWidget(image: Images.deliveryManIcon, title: getTranslated('deliveryman', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryManSetupScreen()))),
      if (Provider.of<SplashController>(context, listen: false).configModel!.posActive == 1 && Provider.of<ProfileController>(context, listen: false).userInfoModel?.posActive == 1)
        CustomBottomSheetWidget(image: Images.pos, title: getTranslated('pos', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NavBarScreen()))),
      CustomBottomSheetWidget(image: Images.settings, title: getTranslated('settings', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
      // CustomBottomSheetWidget(image: Images.restockIcon, title: getTranslated('restock', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RestockListScreen()))),
      CustomBottomSheetWidget(image: Images.wallet, title: getTranslated('wallet', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()))),
      CustomBottomSheetWidget(image: Images.message, title: getTranslated('message', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InboxScreen()))),
      CustomBottomSheetWidget(image: Images.bankingInfo, title: getTranslated('bank_info', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BankInfoScreen()))),
      CustomBottomSheetWidget(
          image: Images.termsAndCondition,
          title: getTranslated('terms_and_condition', context),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HtmlViewScreen(title: getTranslated('terms_and_condition', context), url: Provider.of<SplashController>(context, listen: false).configModel!.termsConditions)))),
      CustomBottomSheetWidget(
          image: Images.aboutUs,
          title: getTranslated('about_us', context),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HtmlViewScreen(
                        title: getTranslated('about_us', context),
                        url: Provider.of<SplashController>(context, listen: false).configModel!.aboutUs,
                      )))),
      CustomBottomSheetWidget(
          image: Images.privacyPolicy,
          title: getTranslated('privacy_policy', context),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HtmlViewScreen(title: getTranslated('privacy_policy', context), url: Provider.of<SplashController>(context, listen: false).configModel!.privacyPolicy)))),
      if (Provider.of<SplashController>(context, listen: false).configModel!.refundPolicy!.status == 1)
        CustomBottomSheetWidget(
            image: Images.refundPolicy,
            title: getTranslated('refund_policy', context),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HtmlViewScreen(title: getTranslated('refund_policy', context), url: Provider.of<SplashController>(context, listen: false).configModel!.refundPolicy!.content)))),
      if (Provider.of<SplashController>(context, listen: false).configModel!.returnPolicy!.status == 1)
        CustomBottomSheetWidget(
            image: Images.returnPolicy,
            title: getTranslated('return_policy', context),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HtmlViewScreen(title: getTranslated('return_policy', context), url: Provider.of<SplashController>(context, listen: false).configModel!.returnPolicy!.content)))),
      if (Provider.of<SplashController>(context, listen: false).configModel!.cancellationPolicy!.status == 1)
        CustomBottomSheetWidget(
            image: Images.cPolicy,
            title: getTranslated('cancellation_policy', context),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HtmlViewScreen(title: getTranslated('cancellation_policy', context), url: Provider.of<SplashController>(context, listen: false).configModel!.returnPolicy!.content)))),
      CustomBottomSheetWidget(image: Images.logOut, title: getTranslated('logout', context), onTap: () => showCupertinoModalPopup(context: context, builder: (_) => const SignOutConfirmationDialogWidget())),
      CustomBottomSheetWidget(image: Images.appInfo, title: 'v - ${AppConstants.appVersion}', onTap: () {}),
    ];

    return Container(
      decoration: BoxDecoration(color: ColorResources.getHomeBg(context), borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Consumer<ShopController>(builder: (context, shopController, child) {
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopScreen())),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 20, left: 12),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.width / 6,
                      child: ClipRRect(borderRadius: BorderRadius.circular(50), child: CustomImageWidget(image: "${Provider.of<SplashController>(context, listen: false).baseUrls!.shopImageUrl}/${shopController.shopModel!.image!}")),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Center(
                      child: Text(shopController.shopModel!.name!,
                          textAlign: TextAlign.center, maxLines: Provider.of<LocalizationController>(context, listen: false).isLtr ? 1 : 1, overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    ),
                  ]),
                ),
              );
            }),

            Consumer<ProfileController>(builder: (context, profileController, child) {
              return Container(
                margin: const EdgeInsets.only(top: 2, left: 16),
                child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    height: MediaQuery.of(context).size.width / 6,
                    child: ClipRRect(borderRadius: BorderRadius.circular(50), child: CustomImageWidget(image: "${Provider.of<SplashController>(context, listen: false).baseUrls!.sellerImageUrl}/${profileController.userInfoModel!.image!}")),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profileController.userInfoModel!.fName! + profileController.userInfoModel!.lName!,
                          textAlign: TextAlign.center, maxLines: Provider.of<LocalizationController>(context, listen: false).isLtr ? 1 : 1, overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                      Text(profileController.userInfoModel!.phone!,
                          textAlign: TextAlign.center, maxLines: Provider.of<LocalizationController>(context, listen: false).isLtr ? 1 : 1, overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    ],
                  ),
                ]),
              );
            }),
            // GestureDetector(
            //     onTap: () => Navigator.pop(context),
            //     child: Icon(
            //       Icons.keyboard_arrow_down_outlined,
            //       color: Theme.of(context).hintColor,
            //       size: Dimensions.iconSizeLarge,
            //     )),
            const SizedBox(height: Dimensions.paddingSizeVeryTiny),
            Consumer<ProfileController>(builder: (context, profileProvider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                child: Column(
                  children: activateMenu,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
