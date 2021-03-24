// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:my_idena/pubdev/dartssh/client.dart';
import 'package:my_idena/network/model/request/dna_identity_request.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:args/args.dart';
import 'package:my_idena/pubdev/dartssh/identity.dart';
import 'package:my_idena/pubdev/dartssh/pem.dart';
import 'package:my_idena/pubdev/dartssh/ssh.dart';
import 'package:my_idena/pubdev/dartssh/transport.dart';
import 'package:my_idena/pubdev/dartssh/http.dart';

class SSHClientStatus {
  SSHClient sshClient;
  bool sshClientStatus;
  String sshClientStatusMsg;
}

class VpsUtil {
  SSHClientStatus sshClientStatus;
  Identity identity;
  Channel forwardChannel;

  void disconnectVps() {
    if (sshClientStatus != null && sshClientStatus.sshClient != null &&
        sshClientStatus.sshClient.socket != null) {
      sshClientStatus.sshClient.disconnect("Configuration in progress");
    }
  }

  Future<SSHClientStatus> connectVps(String tunnel, String keyApp) async {
    if (sshClientStatus != null && sshClientStatus.sshClient != null &&
        sshClientStatus.sshClient.socket != null) {
      return this.sshClientStatus;
    }

    this.sshClientStatus = new SSHClientStatus();
    String user = await sl.get<SharedPrefsUtil>().getVpsUser();
    String ip = await sl.get<SharedPrefsUtil>().getVpsIp();
    String password = await sl.get<SharedPrefsUtil>().getVpsPassword();
    String sshResponse = '';
    String tunnelWithoutHttp =
        tunnel.replaceAll("http://", "").replaceAll("https://", "");

    String statusString = getSSHClient(<String>[
      '-l',
      user,
      ip,
      '--tunnel',
      tunnelWithoutHttp,
      '--password',
      password
      //,'--debug'
    ], (_, String v) => sshResponse += v, null, keyApp);

    if (statusString == "true") {
      this.sshClientStatus.sshClientStatus = true;
    } else {
      this.sshClientStatus.sshClientStatus = false;
      this.sshClientStatus.sshClientStatusMsg = statusString;
    }
    return this.sshClientStatus;
  }

  Future<bool> getWStatusGetResponse(
      HttpClient httpClient, String tunnel, String keyApp) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var response;
    try {
      String map = '{"method": "' +
          DnaIdentityRequest.METHOD_NAME +
          '", "params": [], "id": 101, "key": "' +
          keyApp +
          '"}';

      response = await httpClient.request(tunnel,
          method: 'POST', data: map, headers: requestHeaders);
      print(response.text);
      if (response.status == 200) {}
    } catch (e) {
      print("e: " + e.toString());
    }

    return true;
  }

  String getSSHClient(List<String> arguments, ResponseCallback response,
      VoidCallback done, String keyApp,
      {int termWidth = 80, int termHeight = 25}) {
    final argParser = ArgParser()
      ..addOption('login', abbr: 'l')
      ..addOption('identity', abbr: 'i')
      ..addOption('password')
      ..addOption('tunnel')
      ..addOption('kex')
      ..addOption('key')
      ..addOption('cipher')
      ..addOption('mac')
      ..addFlag('debug')
      ..addFlag('trace')
      ..addFlag('agentForwarding', abbr: 'A');

    final ArgResults args = argParser.parse(arguments);

    identity = null;
    forwardChannel = null;

    if (args.rest.length != 1) {
      print('usage: ssh -l login url [args]');
      print(argParser.usage);
      return "usage: ssh -l login url [args]";
    }

    String host = args.rest.first,
        login = args['login'],
        identityFile = args['identity'],
        tunnel = args['tunnel'];

    if (login == null || login.isEmpty) {
      print('no login specified');
      return "no login specified";
    }

    if (host != null && host.split(":").length == 1) {
      host = host + ":22";
    }

    if (tunnel != null && tunnel.split(':').length != 2) {
      print('tunnel target should be specified host:port');
      return "tunnel target should be specified host:port";
    }

    applyCipherSuiteOverrides(
        args['kex'], args['key'], args['cipher'], args['mac']);

    try {
      this.sshClientStatus.sshClient = SSHClient(
        hostport: parseUri(host),
        login: login,
        print: print,
        termWidth: termWidth,
        termHeight: termHeight,
        termvar: Platform.environment['TERM'] ?? 'xterm',
        agentForwarding: args['agentForwarding'],
        debugPrint: args['debug'] ? print : null,
        tracePrint: args['trace'] ? print : null,
        getPassword: ((args['password'] != null)
            ? () => utf8.encode(args['password'])
            : null),
        response: response,
        loadIdentity: () {
          if (identity == null && identityFile != null) {
            identity = parsePem(File(identityFile).readAsStringSync());
          }
          return identity;
        },
        disconnected: done,
        startShell: tunnel == null,
        success: (null),
      );
    } catch (error, stacktrace) {
      print('ssh: exception: $error: $stacktrace');
      return error;
    }

    return "true";
  }
}
