// @dart=2.9

// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:barcode_scan/barcode_scan.dart';
import 'package:idena_lib_dart/model/address.dart';
import 'package:idena_lib_dart/util/keys/seeds.dart';
import 'package:logger/logger.dart';
import 'package:quiver/strings.dart';
import 'package:validators2/validators.dart';

// Project imports:
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/ui/util/ui_util.dart';

enum DataType { RAW, URL, ADDRESS, SEED }

class QRScanErrs {
  static const String PERMISSION_DENIED = "qr_denied";
  static const String UNKNOWN_ERROR = "qr_unknown";
  static const String CANCEL_ERROR = "qr_cancel";
  static const List<String> ERROR_LIST = [PERMISSION_DENIED, UNKNOWN_ERROR, CANCEL_ERROR];
}

class UserDataUtil {
  static final Logger log = sl.get<Logger>();

  static const MethodChannel _channel = const MethodChannel('fappchannel');
  static StreamSubscription<dynamic> setStream;

  static String _parseData(String data, DataType type) {
    data = data.trim();
    if (type == DataType.RAW) {
      return data;
    } else if (type == DataType.URL) {
      if (isIP(data)) {
        return data;
      } else if (isURL(data)) {
        return data;
      }
    } else if (type == DataType.ADDRESS) {
      Address address = Address(data);
      if (address.isValid()) {
        return address.address;
      }
    } else if (type == DataType.SEED) {
      // Check if valid seed
      if (AppSeeds.isValidSeed(data)) {
        return data;
      }
    }
    return null;
  }

  static Future<String> getClipboardText(DataType type) async {
    ClipboardData data = await Clipboard.getData("text/plain");
    if (data == null || data.text == null) {
      return null;
    }
    return _parseData(data.text, type);
  }

  static Future<String> getQRData(DataType type, BuildContext context) async {
    UIUtil.cancelLockEvent();
    try {
      String data = await BarcodeScanner.scan(StateContainer.of(context).curTheme.qrScanTheme);
      if (isEmpty(data)) {
        return null;
      }
      return _parseData(data, type);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        UIUtil.showSnackbar(AppLocalization.of(context).qrInvalidPermissions, context);
        return QRScanErrs.PERMISSION_DENIED;
      } else {
        UIUtil.showSnackbar(AppLocalization.of(context).qrUnknownError, context);
        return QRScanErrs.UNKNOWN_ERROR;
      }
    } on FormatException {
      return QRScanErrs.CANCEL_ERROR;
    } catch (e) {
      log.e("Unknown QR Scan Error ${e.toString()}", e);
      return QRScanErrs.UNKNOWN_ERROR;
    }
  }

  static Future<void> setSecureClipboardItem(String value) async {
    if (Platform.isIOS) {
      final Map<String, dynamic> params = <String, dynamic>{
        'value': value,
      };
      await _channel.invokeMethod("setSecureClipboardItem", params);
    } else {
      // Set item in clipboard
      await Clipboard.setData(new ClipboardData(text: value));
      // Auto clear it after 2 minutes
      if (setStream != null) {
        setStream.cancel();
      }
      Future<dynamic> delayed = new Future.delayed(new Duration(minutes: 2));
      delayed.then((_) {
        return true;
      });
      setStream = delayed.asStream().listen((_) {
        Clipboard.getData("text/plain").then((data) {
          if (data != null && data.text != null && AppSeeds.isValidSeed(data.text)) {
            Clipboard.setData(ClipboardData(text: ""));
          }
        });
      });
    }
  }
}
