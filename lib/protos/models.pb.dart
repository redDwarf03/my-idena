///
//  Generated code. Do not modify.
//  source: models.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ProtoTransaction_Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoTransaction.Data', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nonce', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epoch', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxFee', $pb.PbFieldType.OY, protoName: 'maxFee')
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tips', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payload', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoTransaction_Data._() : super();
  factory ProtoTransaction_Data({
    $core.int nonce,
    $core.int epoch,
    $core.int type,
    $core.List<$core.int> to,
    $core.List<$core.int> amount,
    $core.List<$core.int> maxFee,
    $core.List<$core.int> tips,
    $core.List<$core.int> payload,
  }) {
    final _result = create();
    if (nonce != null) {
      _result.nonce = nonce;
    }
    if (epoch != null) {
      _result.epoch = epoch;
    }
    if (type != null) {
      _result.type = type;
    }
    if (to != null) {
      _result.to = to;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (maxFee != null) {
      _result.maxFee = maxFee;
    }
    if (tips != null) {
      _result.tips = tips;
    }
    if (payload != null) {
      _result.payload = payload;
    }
    return _result;
  }
  factory ProtoTransaction_Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoTransaction_Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoTransaction_Data clone() => ProtoTransaction_Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoTransaction_Data copyWith(void Function(ProtoTransaction_Data) updates) => super.copyWith((message) => updates(message as ProtoTransaction_Data)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTransaction_Data create() => ProtoTransaction_Data._();
  ProtoTransaction_Data createEmptyInstance() => create();
  static $pb.PbList<ProtoTransaction_Data> createRepeated() => $pb.PbList<ProtoTransaction_Data>();
  @$core.pragma('dart2js:noInline')
  static ProtoTransaction_Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTransaction_Data>(create);
  static ProtoTransaction_Data _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get nonce => $_getIZ(0);
  @$pb.TagNumber(1)
  set nonce($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNonce() => $_has(0);
  @$pb.TagNumber(1)
  void clearNonce() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get epoch => $_getIZ(1);
  @$pb.TagNumber(2)
  set epoch($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpoch() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get type => $_getIZ(2);
  @$pb.TagNumber(3)
  set type($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get to => $_getN(3);
  @$pb.TagNumber(4)
  set to($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTo() => $_has(3);
  @$pb.TagNumber(4)
  void clearTo() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get maxFee => $_getN(5);
  @$pb.TagNumber(6)
  set maxFee($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxFee() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get tips => $_getN(6);
  @$pb.TagNumber(7)
  set tips($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTips() => $_has(6);
  @$pb.TagNumber(7)
  void clearTips() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get payload => $_getN(7);
  @$pb.TagNumber(8)
  set payload($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPayload() => $_has(7);
  @$pb.TagNumber(8)
  void clearPayload() => clearField(8);
}

class ProtoTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoTransaction_Data>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: ProtoTransaction_Data.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'useRlp', protoName: 'useRlp')
    ..hasRequiredFields = false
  ;

  ProtoTransaction._() : super();
  factory ProtoTransaction({
    ProtoTransaction_Data data,
    $core.List<$core.int> signature,
    $core.bool useRlp,
  }) {
    final _result = create();
    if (data != null) {
      _result.data = data;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    if (useRlp != null) {
      _result.useRlp = useRlp;
    }
    return _result;
  }
  factory ProtoTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoTransaction clone() => ProtoTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoTransaction copyWith(void Function(ProtoTransaction) updates) => super.copyWith((message) => updates(message as ProtoTransaction)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTransaction create() => ProtoTransaction._();
  ProtoTransaction createEmptyInstance() => create();
  static $pb.PbList<ProtoTransaction> createRepeated() => $pb.PbList<ProtoTransaction>();
  @$core.pragma('dart2js:noInline')
  static ProtoTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTransaction>(create);
  static ProtoTransaction _defaultInstance;

  @$pb.TagNumber(1)
  ProtoTransaction_Data get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(ProtoTransaction_Data v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
  @$pb.TagNumber(1)
  ProtoTransaction_Data ensureData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get useRlp => $_getBF(2);
  @$pb.TagNumber(3)
  set useRlp($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUseRlp() => $_has(2);
  @$pb.TagNumber(3)
  void clearUseRlp() => clearField(3);
}

