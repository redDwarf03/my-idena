import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class NodeBase
{
  result(Response res, String data) {

    final jsonMap = {
      'jsonrpc': '2.0',
      'id': 1,
      'result': data,
    };
    return Response(json.encode(jsonMap), 200);
  }
}