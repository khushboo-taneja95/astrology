import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:login/constant/dimens.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/about_us_model.dart';
import 'package:login/models/astrology_details_model.dart';
import 'package:login/models/astrology_list_model.dart';
import 'package:login/models/blogs_details_model.dart';
import 'package:login/models/blogs_homepage_model.dart';
import 'package:login/models/blogs_list_model.dart';
import 'package:login/models/categories_model.dart';
import 'package:login/models/consultation_history_models.dart';
import 'package:login/models/daily_horscope_model.dart';
import 'package:login/models/home_banner_models.dart';
import 'package:login/models/horscope_models.dart';
import 'package:login/models/kundali_model.dart';
import 'package:login/models/languages_model.dart';
import 'package:login/models/match_making_models.dart';
import 'package:login/models/notification_list.dart';
import 'package:login/models/order_create_model.dart';
import 'package:login/models/panchang_models.dart';
import 'package:login/models/panchang_tommorow_models.dart';
import 'package:login/models/payment_gateway.dart';
import 'package:login/models/payment_history_model.dart';

import 'package:login/models/recharge_wallet_models.dart';
import 'package:login/models/register_model.dart';
import 'package:login/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  List<RegisterModel> data = [];

  static String baseUrl = "https://astromind.life";
  String blogsList = "/api/v1/articles";
  String blogsDetailsList = "/api/v1/article-details";
  String rechargeWallet = "/api/v1/prices";
  String horscopeList = "/api/v1/zodiacs";
  String categoriesList = "/api/v1/categories";
  String astrologyList = "/api/v1/astrologers";
  String astrologyListDetails = "/api/v1/astrologer-details";
  String homeBanner = "/api/v1/banners";
  String panchang = "/api/v1/panchang";
  String panchangTomorrow = "/api/v1/panchang/tomorrow";
  String matchMaking = "/api/v1/match-making";
  String dailyHorscope = "/api/v1/daily-horoscope";
  String kundali = "/api/v1/kundali";
  String aboutUs = "/api/v1/about";
  String notificationsList = "/api/v1/notifications";
  String blogsHomeScreenList = "/api/v1/latest-articles";
  String languages = "/api/v1/languages";
  String consultationsHistory = "/api/v1/consultations-history";
  String registerOTP = "/api/v1/register";
  String createOrder = "/api/v1/create-order";
  String rechargeWalletAPI = "/api/v1/recharge-wallet";
  String userProfileEndPoint = '/api/v1/get-user';
  String updateUserProfileEndPoint = '/api/v1/update-user';
  String placeCallEndPoint = '/api/v1/place-call';
  String paymentHistoryEndPoint = '/api/v1/payment-history';

  Map<String, String> requestHeadersWithoutParams = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

//Check internet Connectivity
  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // Register OTP
  Future<RegisterModel> getRegisterAPI(String phone) async {
    //var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    // print("toekn show " + token);
    dynamic body = {
      "phone": phone,
    };

    final prefs = await SharedPreferences.getInstance();

    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse("$baseUrl$registerOTP"),
            body: body,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        var temp = RegisterModel.fromJson(jsonDecode(response.body));
        data.add(temp);
        await prefs.setString("token", data[0].data!.token.toString());
        print(data[0].data!.token.toString());
        print(prefs.getString("token"));
// ;        print(
//             "register data ${RegisterModel.fromJson(jsonDecode(response.body))}");
        return RegisterModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Home Banner Slider
  Future<HomeBanner> getHomeBannerSections() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$homeBanner"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return HomeBanner.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Categories List Slider
  Future<SkillsCategoriesModel> getCategoriesSlider() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$categoriesList"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return SkillsCategoriesModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Astrology List Home Page
  Future<AstrologyListModel> getAstrologyList({
    int page = 1,
  }) async {
    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse("$baseUrl$astrologyList?page=$page"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(
            const Duration(
              seconds: AstroDimens.timeOutDuration,
            ),
          );
      if (response.statusCode == 200) {
        return AstrologyListModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Astrology Details List
  Future<AstrologyDetailsModel> getAstrologyListDetails(String id) async {
    dynamic body = {"id": id};
    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse("$baseUrl$astrologyListDetails"),
            body: body,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return AstrologyDetailsModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Horscope List
  Future<HorscopeModel> getHorscopeList() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$horscopeList"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return HorscopeModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Recharge Wallet
  Future<RechargeWalletModel> getRechargeList() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$rechargeWallet"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return RechargeWalletModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // List of Blogs
  Future<BlogsListModel> getBlogList() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$blogsList"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return BlogsListModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // List of Blogs Details
  Future<BlogsDetailsModel> getBlogsDetailsList(String id) async {
    print(id);
    dynamic body = {"id": id};
    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse(
              "$baseUrl$blogsDetailsList",
            ),
            body: body,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return BlogsDetailsModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // List of Panchang Data
  Future<PanchangModel> getPanchang() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$panchang"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return PanchangModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // List of Panchang Tomorrow Data
  Future<PanchangTomorrowModel> getPanchangTomorrow() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$panchangTomorrow"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return PanchangTomorrowModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Match Making

  Future<MatchMakingModel> getMatchMaking(
      String boy_name,
      String boy_dob,
      String boy_tob,
      String boy_pob,
      String boy_lat,
      String boy_long,
      String girl_name,
      String girl_dob,
      String girl_tob,
      String girl_pob,
      String girl_lat,
      String girl_long) async {
    dynamic body = {
      "boy_name": boy_name,
      "boy_dob": boy_dob,
      "boy_tob": boy_tob,
      "boy_pob": boy_pob,
      "boy_lat": boy_lat,
      "boy_long": boy_long,
      "girl_name": girl_name,
      "girl_dob": girl_dob,
      "girl_tob": girl_tob,
      "girl_pob": girl_pob,
      "girl_lat": girl_lat,
      "girl_long": girl_long,
    };
    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse("$baseUrl$matchMaking"),
            headers: requestHeadersWithoutParams,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return MatchMakingModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Daily Horscope Model
  Future<DailyHorscopeModel> getDailyHorscopeModel(String zodiac) async {
    print(zodiac);
    dynamic body = {"zodiac": zodiac};
    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse(
              "$baseUrl$dailyHorscope",
            ),
            body: body,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return DailyHorscopeModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Kundali Model
  Future<KundaliModel> getKundaliModel() async {
    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse("$baseUrl$kundali"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return KundaliModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // About Us API
  Future<AboutUsModel> getAboutUs() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$aboutUs"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return AboutUsModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Notifications List  API
  Future<NotificationsListModel> getNotificationsList() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$notificationsList"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return NotificationsListModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Blogs Home Page List  API
  Future<BlogsHomePageModel> getBlogsHomePageList() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$blogsHomeScreenList"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return BlogsHomePageModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Languages List  API
  Future<LanguagesModel> getLanguageFilters() async {
    if (await isConnected()) {
      final response = await http
          .get(
            Uri.parse("$baseUrl$languages"),
            headers: requestHeadersWithoutParams,
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      if (response.statusCode == 200) {
        return LanguagesModel.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Consultations History API
  Future<List<ConsultationsHistory>> getConsultations(String type) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse("$baseUrl$consultationsHistory"),
            headers: {
              ...requestHeadersWithoutParams,
              'Authorization': "Bearer $token",
            },
            body: jsonEncode({
              'consultation_type': type,
            }),
          )
          .timeout(
            const Duration(
              seconds: AstroDimens.timeOutDuration,
            ),
          );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['success']) {
          List<dynamic>? data = body['data'];
          if (data != null && data.isNotEmpty) {
            return data
                .map(
                  (e) => ConsultationsHistory.fromJson(e),
                )
                .toList();
          }
          return [];
        }
        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      } else {
        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      }
    } else {
      return Future.error(
        AstroString.noInternet,
      );
    }
  }

  // Order create Model
  Future<OrderCreate> getOrderCreate(String amount) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(FirebaseAuth.instance.currentUser!.phoneNumber
        .toString()
        .replaceAll("+91", ""));
    print('Token found : ${token}');
    String phone = FirebaseAuth.instance.currentUser!.phoneNumber
        .toString()
        .replaceAll("+91", "");
    dynamic body = {
      //"amount": amount,
      "phone": "$phone",
    };
    Map<String, String> requestHeaders = {
      //'Content-type': 'application/json',
      'Authorization': "Bearer $token",
    };
    print('Token : ${token}');
    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse(
                "https://astromind.life/api/v1/create-order?amount=$amount"),
            headers: requestHeaders,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: AstroDimens.timeOutDuration));
      print(response.body);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return OrderCreate.fromJson(jsonDecode(response.body));
      } else {
        return Future.error(AstroString.errorMessageOnAPICalledFailed);
      }
    } else {
      return Future.error(AstroString.noInternet);
    }
  }

  // Recharge Wallet Model
  Future<PaymentGatewayModel> getPaymentGateway(
    String orderId,
    String paymentId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    dynamic body = {
      "order_id": orderId,
      "payment_id": paymentId,
    };
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse("$baseUrl$rechargeWalletAPI"),
            headers: requestHeaders,
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(
              seconds: AstroDimens.timeOutDuration,
            ),
          );
      if (response.statusCode == 200) {
        return PaymentGatewayModel.fromJson(
          jsonDecode(
            response.body,
          ),
        );
      } else {
        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      }
    } else {
      return Future.error(
        AstroString.noInternet,
      );
    }
  }

  Future<UserProfile> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (await isConnected()) {
      final response = await http.get(
        Uri.parse("$baseUrl$userProfileEndPoint"),
        headers: {
          ...requestHeadersWithoutParams,
          'Authorization': "Bearer $token",
        },
      ).timeout(
        const Duration(
          seconds: AstroDimens.timeOutDuration,
        ),
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['success'] && body['data'] != null) {
          return UserProfile.fromJson(body['data']);
        }

        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      } else {
        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      }
    } else {
      return Future.error(
        AstroString.noInternet,
      );
    }
  }

  Future updateUserProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (await isConnected()) {
      final response = await http
          .put(
            Uri.parse("$baseUrl$updateUserProfileEndPoint"),
            headers: {
              ...requestHeadersWithoutParams,
              'Authorization': "Bearer $token",
            },
            body: jsonEncode(
              profile.toJson(),
            ),
          )
          .timeout(
            const Duration(
              seconds: AstroDimens.timeOutDuration,
            ),
          );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['success'] && body['data'] != null) {
          return UserProfile.fromJson(body['data']);
        }

        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      } else {
        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      }
    } else {
      return Future.error(
        AstroString.noInternet,
      );
    }
  }

  Future placeCallWithAstrologer(int id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    if (await isConnected()) {
      final response = await http
          .post(
            Uri.parse("$baseUrl$placeCallEndPoint"),
            headers: {
              ...requestHeadersWithoutParams,
              'Authorization': "Bearer $token",
            },
            body: jsonEncode({
              "astrologer_id": id,
            }),
          )
          .timeout(
            const Duration(
              seconds: AstroDimens.timeOutDuration,
            ),
          );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['success']) {
          return body;
        }
      } else {
        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      }
    } else {
      return Future.error(
        AstroString.noInternet,
      );
    }
  }

  Future fetchPaymentHistory({
    int pageKey = 0,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    if (await isConnected()) {
      final response = await http.post(
        Uri.parse("$baseUrl$paymentHistoryEndPoint?page=$pageKey"),
        headers: {
          ...requestHeadersWithoutParams,
          'Authorization': "Bearer $token",
        },
      ).timeout(
        const Duration(
          seconds: AstroDimens.timeOutDuration,
        ),
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['success'] &&
            body['data'] != null &&
            body['data']['data'] != null) {
          return (body['data']['data'] as List<dynamic>)
              .map(
                (e) => PaymentHistoryModel.fromJson(e),
              )
              .toList();
        }

        return [];
      } else {
        return Future.error(
          AstroString.errorMessageOnAPICalledFailed,
        );
      }
    } else {
      return Future.error(
        AstroString.noInternet,
      );
    }
  }
}
