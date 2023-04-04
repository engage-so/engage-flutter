library engage;

import 'dart:io' show Platform;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Engage {
  static String publicKey = '';
  static String tz = '';
  static String version = '';
  static String build = '';
  
  static const int put = 1;
  static const int post = 2;
  static const int delete = 3;
  static const String _root = 'https://api.engage.so/v1';

  static Future<void> init (String pk) async {
    publicKey = pk;
    try {
      tz = await FlutterNativeTimezone.getLocalTimezone();
    } catch(_) { }
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
      build = packageInfo.buildNumber;
    } catch(_) { }
  }

  static void identify (String id, Map<String, Object> properties) {
    Map<String, Object> data = {};
    Map<String, Object> meta = {};
    Set<String> standardAttributes = const {"is_account", "first_name", "last_name", "email", "number", "created_at", "tz"};
    properties.forEach((key, value) {
      if (standardAttributes.contains(key)) {
        data[key] = value;
      } else {
        meta[key] = value;
      }
    });

    // tz
    if (!data.containsKey('tz') && tz.isNotEmpty) {
      data['tz'] = tz;
    }
    if (meta.isNotEmpty) {
      data['meta'] = meta;
    }

    // print(data);

    _request('/users/' + id, put, data);
  }

  static void setDeviceToken (String id, String token) {
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    } else {
      return;
    }

    Map<String, Object> data = {
      'device_token': token,
      'device_platform': platform,
      'app_version': version,
      'app_build': build,
      'app_last_active': DateTime.now()
    };
    // print(data);
    _request('/users/' + id, put, data);
  }

  static void addAttributes (String id, Map<String, Object> attributes) =>
    identify(id, attributes);

  static void addToAccount (String id, String aid, [String? role]) {
    Map<String, String> g = { 'id': aid };
    if (role != null) {
      g['role'] = role;
    }
    List<Map<String, String>> accounts = [g];
    Map<String, Object> data = { 'accounts': accounts };
    _request('/users/' + id + '/accounts', post, data);
  }

  static void removeFromAccount (String id, String aid) {
    _request('/users/' + id + '/accounts/' + aid, delete);
  }

  static void changeAccountRole (String id, String aid, String role) {
    Map<String, Object> data = { 'role': role };
    _request('/users/' + id + '/accounts/' + aid, put, data);
  }

  static void convertToCustomer (String id) {
    Map<String, Object> data = { 'type': 'customer' };
    _request('/users/' + id + '/convert', post, data);
  }

  static void convertToAccount (String id) {
    Map<String, Object> data = { 'type': 'account' };
    _request('/users/' + id + '/convert', post, data);
  }

  static void merge (String source, String destination) {
    Map<String, Object> data = { 'source': source, 'destination': destination };
    _request('/users/merge', post, data);
  }
  
  static void trackEvents (String id, String event, [Object? value, DateTime? date]) {
    Map<String, Object> data = {};
    data['event'] = event;
    if (value is DateTime && date == null) {
      data['timestamp'] = value;
    } else if (value is Map) {
      data['properties'] = value;
    } else if (value != null) {
      data['value'] = value;
    }
    if (date != null) {
      data['timestamp'] = date;
    }
    _request('/users/' + id + '/events', post, data);
  }

  static Map<String, Object> _convertDateToString (Map<String, Object> data) {
    data.forEach((key, value) {
      if (value is Map<String, Object>) {
        data[key] = _convertDateToString(value);
      } else if (value is DateTime) {
        data[key] = value.toIso8601String();
      }
    });
    return data;
  }

  static void _request (String url, int type, [Map<String, Object>? data]) async {
    try {
      String auth = 'Basic ' + base64Encode(utf8.encode('$publicKey:'));
      // Convert date
      if (data != null) {
        data = _convertDateToString(data);
        // print(data);
      }
      if (type == 1) {
        await http.put(
          Uri.parse(_root + url),
          headers: <String, String>{
            'Authorization': auth,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data),
        );
      } else if (type == 2) {
        await http.post(
          Uri.parse(_root + url),
          headers: <String, String>{
            'Authorization': auth,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data),
        );
      } else if (type == 3) {
        await http.delete(
          Uri.parse(_root + url),
          headers: <String, String>{
            'Authorization': auth,
            'Content-Type': 'application/json; charset=UTF-8',
          }
        );
      }
    } catch (e) {
      // print(e.toString());
    }
  }
}
