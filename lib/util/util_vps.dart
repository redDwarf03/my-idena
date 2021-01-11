import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartssh/client.dart';
import 'package:my_idena/network/model/request/dna_identity_request.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:args/args.dart';
import 'package:dartssh/identity.dart';
import 'package:dartssh/pem.dart';
import 'package:dartssh/server.dart';
import 'package:dartssh/ssh.dart';
import 'package:dartssh/transport.dart';
import 'package:dartssh/http.dart';

SSHServer server;
Identity identity;
SSHClient client;
Channel forwardChannel;

class VpsUtil {
  Future<bool> isVpsUsed() async {
    if (await sl.get<SharedPrefsUtil>().getVpsIp() != "") {
      return true;
    } else {
      return false;
    }
  }

  Future<SSHClient> connectVps(String tunnel, String keyApp) async {

    if(client != null)
    {
      return client;
    }
    
    String user = await sl.get<SharedPrefsUtil>().getVpsUser();
    String ip = await sl.get<SharedPrefsUtil>().getVpsIp();
    String password = await sl.get<SharedPrefsUtil>().getVpsPassword();
    String sshResponse = '';
    String tunnelWithoutHttp =
        tunnel.replaceAll("http://", "").replaceAll("https://", "");

    getSSHClient(<String>[
      '-l',
      user,
      ip,
      '--tunnel',
      tunnelWithoutHttp,
      '--password',
      password
      //,'--debug'
    ], (_, String v) => sshResponse += v, null, keyApp);

    /*status = await getWStatusGetResponse(
        HttpClientImpl(clientFactory: () => SSHTunneledBaseClient(client)),
        tunnel,
        keyApp);*/
    return client;
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

  bool getSSHClient(List<String> arguments, ResponseCallback response,
      VoidCallback done, String keyApp,
      {int termWidth = 80, int termHeight = 25}) {
    bool status = false;

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
    client = null;
    forwardChannel = null;

    if (args.rest.length != 1) {
      print('usage: ssh -l login url [args]');
      print(argParser.usage);
      return null;
    }

    final String host = args.rest.first,
        login = args['login'],
        identityFile = args['identity'],
        tunnel = args['tunnel'];

    if (login == null || login.isEmpty) {
      print('no login specified');
      return null;
    }

    if (tunnel != null && tunnel.split(':').length != 2) {
      print('tunnel target should be specified host:port');
      return null;
    }

    applyCipherSuiteOverrides(
        args['kex'], args['key'], args['cipher'], args['mac']);

    try {
      client = SSHClient(
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
      return null;
    }

    return status;
  }
}
