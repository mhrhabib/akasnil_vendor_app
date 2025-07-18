import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/base/api_response.dart';
import 'package:sixvalley_vendor_app/features/splash/domain/models/config_model.dart';
import 'package:sixvalley_vendor_app/features/splash/domain/services/splash_service_interface.dart';
import 'package:sixvalley_vendor_app/helper/api_checker.dart';

class SplashController extends ChangeNotifier {
  final SplashServiceInterface serviceInterface;
  SplashController({required this.serviceInterface});

  ConfigModel? _configModel;
  BaseUrls? _baseUrls;
  CurrencyList? _myCurrency;
  CurrencyList? _defaultCurrency;
  CurrencyList? _usdCurrency;
  int? _currencyIndex;
  int? _shippingIndex;
  bool _hasConnection = true;
  bool _fromSetting = false;
  bool _firstTimeConnectionCheck = true;
  List<String>? _unitList;
  List<ColorList>? _colorList;
  final int _unitIndex = 0;
  final int _colorIndex = 0;
  List<String>? get unitList => _unitList;
  List<ColorList>? get colorList => _colorList;
  int get unitIndex => _unitIndex;
  int get colorIndex => _colorIndex;
  List<String?> _shippingTypeList = [];
  final String _shippingStatusType = '';
  List<String?> get shippingTypeList => _shippingTypeList;
  String get shippingStatusType => _shippingStatusType;

  ConfigModel? get configModel => _configModel;
  BaseUrls? get baseUrls => _baseUrls;
  CurrencyList? get myCurrency => _myCurrency;
  CurrencyList? get defaultCurrency => _defaultCurrency;
  CurrencyList? get usdCurrency => _usdCurrency;
  int? get currencyIndex => _currencyIndex;
  int? get shippingIndex => _shippingIndex;
  bool get hasConnection => _hasConnection;
  bool get fromSetting => _fromSetting;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  ///Refector this
  Future<bool> initConfig() async {
    _configModel = null;
    _hasConnection = true;
    ApiResponse apiResponse = await serviceInterface.getConfig();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response!.data);
      _baseUrls = ConfigModel.fromJson(apiResponse.response!.data).baseUrls;
      String? currencyCode = serviceInterface.getCurrency();
      for (CurrencyList currencyList in _configModel!.currencyList!) {
        if (currencyList.id == _configModel!.systemDefaultCurrency) {
          if (currencyCode == null || currencyCode.isEmpty) {
            currencyCode = currencyList.code;
          }
          _defaultCurrency = currencyList;
        }
        if (currencyList.code == 'USD') {
          _usdCurrency = currencyList;
        }
      }

      getCurrencyData(currencyCode);
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(apiResponse);
      if (apiResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
    return isSuccess;
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  void getCurrencyData(String? currencyCode) {
    for (var currency in _configModel!.currencyList!) {
      if (currencyCode == currency.code) {
        _myCurrency = currency;
        _currencyIndex = _configModel!.currencyList!.indexOf(currency);
        continue;
      }
    }
  }

  Future<List<int?>> getColorList() async {
    List<int?> colorIds = [];
    _colorList = [];
    for (ColorList item in _configModel!.colors!) {
      _colorList!.add(item);
      colorIds.add(item.id);
    }
    // notifyListeners();
    return colorIds;
  }

  void setCurrency(int index) {
    serviceInterface.setCurrency(_configModel!.currencyList![index].code!);
    getCurrencyData(_configModel!.currencyList![index].code);
    notifyListeners();
  }

  void setShippingType(int index) {
    serviceInterface.setShippingType(_shippingTypeList[index]!);
    notifyListeners();
  }

  void initShippingType(String? type) {
    _shippingIndex = _shippingTypeList.indexOf(type);
    notifyListeners();
  }

  void initSharedPrefData() {
    serviceInterface.initSharedData();
  }

  void setFromSetting(bool isSetting) {
    _fromSetting = isSetting;
  }

  void initShippingTypeList(BuildContext context, String type) async {
    _shippingTypeList.clear();
    _shippingTypeList = [];
    ApiResponse apiResponse = await serviceInterface.getShippingTypeList(context, type);
    _shippingTypeList.addAll(apiResponse.response!.data);
    notifyListeners();
  }
}
