import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/features/splash/controllers/splash_controller.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double? price, {double? discount, String? discountType}) {
    final splashProvider = Provider.of<SplashController>(context, listen: false);
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price! - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price! - ((discount / 100) * price);
      }
    }

    bool singleCurrency = splashProvider.configModel!.currencyModel == 'single_currency';

    return '${splashProvider.myCurrency!.symbol}${(singleCurrency ? price : price! * splashProvider.myCurrency!.exchangeRate! * (1 / splashProvider.usdCurrency!.exchangeRate!))!.toStringAsFixed(splashProvider.configModel!.decimalPointSettings!).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  static double? convertWithDiscount(BuildContext context, double? price, double? discount, String? discountType) {
    if (discountType == 'amount' || discountType == 'flat') {
      price = price! - discount!;
    } else if (discountType == 'percent' || discountType == 'percentage') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static String convertPriceWithoutSymbol(BuildContext context, double? price, {double? discount, String? discountType}) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price! - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price! - ((discount / 100) * price);
      }
    }
    final splashProvider = Provider.of<SplashController>(context, listen: false);
    bool singleCurrency = splashProvider.configModel!.currencyModel == 'single_currency';

    return (singleCurrency ? price : price! * splashProvider.myCurrency!.exchangeRate! * (1 / splashProvider.usdCurrency!.exchangeRate!))!.toStringAsFixed(splashProvider.configModel!.decimalPointSettings!);
  }

  static double systemCurrencyToDefaultCurrency(double price, BuildContext context) {
    final splashProvider = Provider.of<SplashController>(context, listen: false);
    bool singleCurrency = splashProvider.configModel!.currencyModel == 'single_currency';
    if (singleCurrency) {
      return price / 1;
    } else {
      return price / splashProvider.myCurrency!.exchangeRate!;
    }
  }

  static double convertAmount(double amount, BuildContext context) {
    final splashProvider = Provider.of<SplashController>(context, listen: false);
    return double.parse((amount * splashProvider.myCurrency!.exchangeRate! * (1 / splashProvider.usdCurrency!.exchangeRate!)).toStringAsFixed(splashProvider.configModel!.decimalPointSettings!));
  }

  static String percentageCalculation(BuildContext context, double? price, double? discount, String? discountType) {
    return '-${(discountType == 'percent' || discountType == 'percentage') ? '$discount %' : convertPrice(context, discount)}';
  }

  static String discountCalculationWithOutSymbol(BuildContext context, double price, double discount, String? discountType) {
    if (discountType == 'amount') {
      discount = discount;
    } else if (discountType == 'percent') {
      discount = ((discount / 100) * price);
    }
    return discount.toStringAsFixed(2);
  }

  static String discountCalculation(BuildContext context, double price, double discount, String? discountType) {
    final splashProvider = Provider.of<SplashController>(context, listen: false);
    if (discountType == 'amount') {
      discount = discount;
    } else if (discountType == 'percent') {
      discount = ((discount / 100) * price);
    }
    return '${splashProvider.myCurrency!.symbol} ${discount.toStringAsFixed(2)}';
  }
}
