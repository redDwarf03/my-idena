// @dart=2.9
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

const String PN_URL = "https://rpc.idena.dev";
const String PN_ADDRESS = "(public node)";

const int SHARED_NODE = 1;
const int NORMAL_LOCAL_NODE = 2;
const int NORMAL_VPS_NODE = 3;
const int PUBLIC_NODE = 4;
const int DEMO_NODE = 5;
const int UNKOWN_NODE = 0;

class NodeUtil {
  Future<int> getNodeType() async {
    return await sl.get<SharedPrefsUtil>().getNodeType();
  }


  String getLabel(int nodeType) {
    switch (nodeType) {
      case SHARED_NODE:
        return "Shared Node";
      case NORMAL_LOCAL_NODE:
        return "Normal Local";
      case NORMAL_VPS_NODE:
        return "VPS";
      case PUBLIC_NODE:
        return "Public Node";
      case DEMO_NODE:
        return "Demo";
      default:
        return "Unknown";
    }
  }

  String getExplaination(int nodeType) {
    switch (nodeType) {
      case SHARED_NODE:
        return "You use a shared node that is provided by the community members and the Idena core team. They provide an (api key) to connect to their node";
      case NORMAL_LOCAL_NODE:
        return "You use a local node in your own computer, in local network, such at your home. You need a VPN access to your node to improve security";
      case NORMAL_VPS_NODE:
        return "You use a remote node which is installed on a VPS (Virtual private server)";
      case PUBLIC_NODE:
        return "You use a public node which is provided by menxit";
      case DEMO_NODE:
        return "You want to discover the app 'my idena'";
      default:
        return "Unknown";
    }
  }



  List<NodeType> getNodeTypeList() {
    List<NodeType> nodeTypeList = new List();
    nodeTypeList
        .add(new NodeType(type: SHARED_NODE, label: getLabel(SHARED_NODE)));
    nodeTypeList.add(new NodeType(
        type: NORMAL_LOCAL_NODE, label: getLabel(NORMAL_LOCAL_NODE)));
    nodeTypeList.add(
        new NodeType(type: NORMAL_VPS_NODE, label: getLabel(NORMAL_VPS_NODE)));
    nodeTypeList
        .add(new NodeType(type: PUBLIC_NODE, label: getLabel(PUBLIC_NODE)));
    nodeTypeList.add(new NodeType(type: DEMO_NODE, label: getLabel(DEMO_NODE)));
    return nodeTypeList;
  }
}

class NodeType {
  NodeType({this.type, this.label});
  int type;
  String label;
}
