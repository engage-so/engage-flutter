library engage;

import 'dart:io' show Platform;
import 'dart:convert';
import 'package:http/http.dart' as http;

class Engage {
  static String publicKey = '';
  
  static const int put = 1;
  static const int post = 2;
  static const String _root = 'https://api.engage.so/v1';

  static void init (String pk) {
    publicKey = pk;
  }

  static void identify (String id, Map<String, Object> properties) {
    Map<String, Object> data = {};
    Map<String, Object> meta = {};
    Set<String> standardAttributes = const {"first_name", "last_name", "email", "number", "created_at"};
    properties.forEach((key, value) {
      if (standardAttributes.contains(key)) {
        data[key] = value;
      } else {
        meta[key] = value;
      }
    });

    if (meta.isNotEmpty) {
      data['meta'] = meta;
    }

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
      'device_platform': platform
    };
    _request('/users/' + id, put, data);
  }

  static void addAttributes (String id, Map<String, Object> attributes) =>
    identify(id, attributes);
  
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

  static void _request (String url, int type, Map<String, Object> data) async {
    try {
      String auth = 'Basic ' + base64Encode(utf8.encode('$publicKey:'));
      // Convert date
      data = _convertDateToString(data);
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
      }
    } catch (e) {
      // print(e.toString());
    }
  }
}
