class DeepLinkParam {
  String key;
  List<String> value;

  DeepLinkParam(this.key, this.value);

  @override
  String toString() {
    return '{ ${this.key}, ${this.value} }';
  }
}
