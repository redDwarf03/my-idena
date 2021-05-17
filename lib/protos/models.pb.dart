///
//  Generated code. Do not modify.
//  source: models.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
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
    $core.int? nonce,
    $core.int? epoch,
    $core.int? type,
    $core.List<$core.int>? to,
    $core.List<$core.int>? amount,
    $core.List<$core.int>? maxFee,
    $core.List<$core.int>? tips,
    $core.List<$core.int>? payload,
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
  ProtoTransaction_Data copyWith(void Function(ProtoTransaction_Data) updates) => super.copyWith((message) => updates(message as ProtoTransaction_Data)) as ProtoTransaction_Data; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTransaction_Data create() => ProtoTransaction_Data._();
  ProtoTransaction_Data createEmptyInstance() => create();
  static $pb.PbList<ProtoTransaction_Data> createRepeated() => $pb.PbList<ProtoTransaction_Data>();
  @$core.pragma('dart2js:noInline')
  static ProtoTransaction_Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTransaction_Data>(create);
  static ProtoTransaction_Data? _defaultInstance;

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
    ProtoTransaction_Data? data,
    $core.List<$core.int>? signature,
    $core.bool? useRlp,
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
  ProtoTransaction copyWith(void Function(ProtoTransaction) updates) => super.copyWith((message) => updates(message as ProtoTransaction)) as ProtoTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTransaction create() => ProtoTransaction._();
  ProtoTransaction createEmptyInstance() => create();
  static $pb.PbList<ProtoTransaction> createRepeated() => $pb.PbList<ProtoTransaction>();
  @$core.pragma('dart2js:noInline')
  static ProtoTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTransaction>(create);
  static ProtoTransaction? _defaultInstance;

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

class ProtoBlockHeader_Proposed extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlockHeader.Proposed', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parentHash', $pb.PbFieldType.OY, protoName: 'parentHash')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txHash', $pb.PbFieldType.OY, protoName: 'txHash')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proposerPubKey', $pb.PbFieldType.OY, protoName: 'proposerPubKey')
    ..a<$core.List<$core.int>>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'root', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityRoot', $pb.PbFieldType.OY, protoName: 'identityRoot')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flags', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ipfsHash', $pb.PbFieldType.OY, protoName: 'ipfsHash')
    ..a<$core.List<$core.int>>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offlineAddr', $pb.PbFieldType.OY, protoName: 'offlineAddr')
    ..a<$core.List<$core.int>>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txBloom', $pb.PbFieldType.OY, protoName: 'txBloom')
    ..a<$core.List<$core.int>>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockSeed', $pb.PbFieldType.OY, protoName: 'blockSeed')
    ..a<$core.List<$core.int>>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePerGas', $pb.PbFieldType.OY, protoName: 'feePerGas')
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'upgrade', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'seedProof', $pb.PbFieldType.OY, protoName: 'seedProof')
    ..a<$core.List<$core.int>>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptsCid', $pb.PbFieldType.OY, protoName: 'receiptsCid')
    ..hasRequiredFields = false
  ;

  ProtoBlockHeader_Proposed._() : super();
  factory ProtoBlockHeader_Proposed({
    $core.List<$core.int>? parentHash,
    $fixnum.Int64? height,
    $fixnum.Int64? timestamp,
    $core.List<$core.int>? txHash,
    $core.List<$core.int>? proposerPubKey,
    $core.List<$core.int>? root,
    $core.List<$core.int>? identityRoot,
    $core.int? flags,
    $core.List<$core.int>? ipfsHash,
    $core.List<$core.int>? offlineAddr,
    $core.List<$core.int>? txBloom,
    $core.List<$core.int>? blockSeed,
    $core.List<$core.int>? feePerGas,
    $core.int? upgrade,
    $core.List<$core.int>? seedProof,
    $core.List<$core.int>? receiptsCid,
  }) {
    final _result = create();
    if (parentHash != null) {
      _result.parentHash = parentHash;
    }
    if (height != null) {
      _result.height = height;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (txHash != null) {
      _result.txHash = txHash;
    }
    if (proposerPubKey != null) {
      _result.proposerPubKey = proposerPubKey;
    }
    if (root != null) {
      _result.root = root;
    }
    if (identityRoot != null) {
      _result.identityRoot = identityRoot;
    }
    if (flags != null) {
      _result.flags = flags;
    }
    if (ipfsHash != null) {
      _result.ipfsHash = ipfsHash;
    }
    if (offlineAddr != null) {
      _result.offlineAddr = offlineAddr;
    }
    if (txBloom != null) {
      _result.txBloom = txBloom;
    }
    if (blockSeed != null) {
      _result.blockSeed = blockSeed;
    }
    if (feePerGas != null) {
      _result.feePerGas = feePerGas;
    }
    if (upgrade != null) {
      _result.upgrade = upgrade;
    }
    if (seedProof != null) {
      _result.seedProof = seedProof;
    }
    if (receiptsCid != null) {
      _result.receiptsCid = receiptsCid;
    }
    return _result;
  }
  factory ProtoBlockHeader_Proposed.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlockHeader_Proposed.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlockHeader_Proposed clone() => ProtoBlockHeader_Proposed()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlockHeader_Proposed copyWith(void Function(ProtoBlockHeader_Proposed) updates) => super.copyWith((message) => updates(message as ProtoBlockHeader_Proposed)) as ProtoBlockHeader_Proposed; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlockHeader_Proposed create() => ProtoBlockHeader_Proposed._();
  ProtoBlockHeader_Proposed createEmptyInstance() => create();
  static $pb.PbList<ProtoBlockHeader_Proposed> createRepeated() => $pb.PbList<ProtoBlockHeader_Proposed>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlockHeader_Proposed getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlockHeader_Proposed>(create);
  static ProtoBlockHeader_Proposed? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get parentHash => $_getN(0);
  @$pb.TagNumber(1)
  set parentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasParentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearParentHash() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get height => $_getI64(1);
  @$pb.TagNumber(2)
  set height($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get timestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set timestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get txHash => $_getN(3);
  @$pb.TagNumber(4)
  set txHash($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTxHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearTxHash() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get proposerPubKey => $_getN(4);
  @$pb.TagNumber(5)
  set proposerPubKey($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProposerPubKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearProposerPubKey() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get root => $_getN(5);
  @$pb.TagNumber(6)
  set root($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRoot() => $_has(5);
  @$pb.TagNumber(6)
  void clearRoot() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get identityRoot => $_getN(6);
  @$pb.TagNumber(7)
  set identityRoot($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdentityRoot() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdentityRoot() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get flags => $_getIZ(7);
  @$pb.TagNumber(8)
  set flags($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFlags() => $_has(7);
  @$pb.TagNumber(8)
  void clearFlags() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.int> get ipfsHash => $_getN(8);
  @$pb.TagNumber(9)
  set ipfsHash($core.List<$core.int> v) { $_setBytes(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIpfsHash() => $_has(8);
  @$pb.TagNumber(9)
  void clearIpfsHash() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.int> get offlineAddr => $_getN(9);
  @$pb.TagNumber(10)
  set offlineAddr($core.List<$core.int> v) { $_setBytes(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasOfflineAddr() => $_has(9);
  @$pb.TagNumber(10)
  void clearOfflineAddr() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.int> get txBloom => $_getN(10);
  @$pb.TagNumber(11)
  set txBloom($core.List<$core.int> v) { $_setBytes(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTxBloom() => $_has(10);
  @$pb.TagNumber(11)
  void clearTxBloom() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.int> get blockSeed => $_getN(11);
  @$pb.TagNumber(12)
  set blockSeed($core.List<$core.int> v) { $_setBytes(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBlockSeed() => $_has(11);
  @$pb.TagNumber(12)
  void clearBlockSeed() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<$core.int> get feePerGas => $_getN(12);
  @$pb.TagNumber(13)
  set feePerGas($core.List<$core.int> v) { $_setBytes(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFeePerGas() => $_has(12);
  @$pb.TagNumber(13)
  void clearFeePerGas() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get upgrade => $_getIZ(13);
  @$pb.TagNumber(14)
  set upgrade($core.int v) { $_setUnsignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasUpgrade() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpgrade() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<$core.int> get seedProof => $_getN(14);
  @$pb.TagNumber(15)
  set seedProof($core.List<$core.int> v) { $_setBytes(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasSeedProof() => $_has(14);
  @$pb.TagNumber(15)
  void clearSeedProof() => clearField(15);

  @$pb.TagNumber(16)
  $core.List<$core.int> get receiptsCid => $_getN(15);
  @$pb.TagNumber(16)
  set receiptsCid($core.List<$core.int> v) { $_setBytes(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasReceiptsCid() => $_has(15);
  @$pb.TagNumber(16)
  void clearReceiptsCid() => clearField(16);
}

class ProtoBlockHeader_Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlockHeader.Empty', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parentHash', $pb.PbFieldType.OY, protoName: 'parentHash')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'root', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityRoot', $pb.PbFieldType.OY, protoName: 'identityRoot')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..a<$core.List<$core.int>>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockSeed', $pb.PbFieldType.OY, protoName: 'blockSeed')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flags', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoBlockHeader_Empty._() : super();
  factory ProtoBlockHeader_Empty({
    $core.List<$core.int>? parentHash,
    $fixnum.Int64? height,
    $core.List<$core.int>? root,
    $core.List<$core.int>? identityRoot,
    $fixnum.Int64? timestamp,
    $core.List<$core.int>? blockSeed,
    $core.int? flags,
  }) {
    final _result = create();
    if (parentHash != null) {
      _result.parentHash = parentHash;
    }
    if (height != null) {
      _result.height = height;
    }
    if (root != null) {
      _result.root = root;
    }
    if (identityRoot != null) {
      _result.identityRoot = identityRoot;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (blockSeed != null) {
      _result.blockSeed = blockSeed;
    }
    if (flags != null) {
      _result.flags = flags;
    }
    return _result;
  }
  factory ProtoBlockHeader_Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlockHeader_Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlockHeader_Empty clone() => ProtoBlockHeader_Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlockHeader_Empty copyWith(void Function(ProtoBlockHeader_Empty) updates) => super.copyWith((message) => updates(message as ProtoBlockHeader_Empty)) as ProtoBlockHeader_Empty; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlockHeader_Empty create() => ProtoBlockHeader_Empty._();
  ProtoBlockHeader_Empty createEmptyInstance() => create();
  static $pb.PbList<ProtoBlockHeader_Empty> createRepeated() => $pb.PbList<ProtoBlockHeader_Empty>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlockHeader_Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlockHeader_Empty>(create);
  static ProtoBlockHeader_Empty? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get parentHash => $_getN(0);
  @$pb.TagNumber(1)
  set parentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasParentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearParentHash() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get height => $_getI64(1);
  @$pb.TagNumber(2)
  set height($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get root => $_getN(2);
  @$pb.TagNumber(3)
  set root($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRoot() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoot() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get identityRoot => $_getN(3);
  @$pb.TagNumber(4)
  set identityRoot($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdentityRoot() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdentityRoot() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get blockSeed => $_getN(5);
  @$pb.TagNumber(6)
  set blockSeed($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBlockSeed() => $_has(5);
  @$pb.TagNumber(6)
  void clearBlockSeed() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get flags => $_getIZ(6);
  @$pb.TagNumber(7)
  set flags($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFlags() => $_has(6);
  @$pb.TagNumber(7)
  void clearFlags() => clearField(7);
}

class ProtoBlockHeader extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlockHeader', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoBlockHeader_Proposed>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proposedHeader', protoName: 'proposedHeader', subBuilder: ProtoBlockHeader_Proposed.create)
    ..aOM<ProtoBlockHeader_Empty>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emptyHeader', protoName: 'emptyHeader', subBuilder: ProtoBlockHeader_Empty.create)
    ..hasRequiredFields = false
  ;

  ProtoBlockHeader._() : super();
  factory ProtoBlockHeader({
    ProtoBlockHeader_Proposed? proposedHeader,
    ProtoBlockHeader_Empty? emptyHeader,
  }) {
    final _result = create();
    if (proposedHeader != null) {
      _result.proposedHeader = proposedHeader;
    }
    if (emptyHeader != null) {
      _result.emptyHeader = emptyHeader;
    }
    return _result;
  }
  factory ProtoBlockHeader.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlockHeader.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlockHeader clone() => ProtoBlockHeader()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlockHeader copyWith(void Function(ProtoBlockHeader) updates) => super.copyWith((message) => updates(message as ProtoBlockHeader)) as ProtoBlockHeader; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlockHeader create() => ProtoBlockHeader._();
  ProtoBlockHeader createEmptyInstance() => create();
  static $pb.PbList<ProtoBlockHeader> createRepeated() => $pb.PbList<ProtoBlockHeader>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlockHeader getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlockHeader>(create);
  static ProtoBlockHeader? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoBlockHeader_Proposed get proposedHeader => $_getN(0);
  @$pb.TagNumber(1)
  set proposedHeader(ProtoBlockHeader_Proposed v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProposedHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearProposedHeader() => clearField(1);
  @$pb.TagNumber(1)
  ProtoBlockHeader_Proposed ensureProposedHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  ProtoBlockHeader_Empty get emptyHeader => $_getN(1);
  @$pb.TagNumber(2)
  set emptyHeader(ProtoBlockHeader_Empty v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmptyHeader() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmptyHeader() => clearField(2);
  @$pb.TagNumber(2)
  ProtoBlockHeader_Empty ensureEmptyHeader() => $_ensure(1);
}

class ProtoBlockBody extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlockBody', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..pc<ProtoTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: ProtoTransaction.create)
    ..hasRequiredFields = false
  ;

  ProtoBlockBody._() : super();
  factory ProtoBlockBody({
    $core.Iterable<ProtoTransaction>? transactions,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    return _result;
  }
  factory ProtoBlockBody.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlockBody.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlockBody clone() => ProtoBlockBody()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlockBody copyWith(void Function(ProtoBlockBody) updates) => super.copyWith((message) => updates(message as ProtoBlockBody)) as ProtoBlockBody; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlockBody create() => ProtoBlockBody._();
  ProtoBlockBody createEmptyInstance() => create();
  static $pb.PbList<ProtoBlockBody> createRepeated() => $pb.PbList<ProtoBlockBody>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlockBody getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlockBody>(create);
  static ProtoBlockBody? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProtoTransaction> get transactions => $_getList(0);
}

class ProtoBlock extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlock', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoBlockHeader>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'header', subBuilder: ProtoBlockHeader.create)
    ..aOM<ProtoBlockBody>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'body', subBuilder: ProtoBlockBody.create)
    ..hasRequiredFields = false
  ;

  ProtoBlock._() : super();
  factory ProtoBlock({
    ProtoBlockHeader? header,
    ProtoBlockBody? body,
  }) {
    final _result = create();
    if (header != null) {
      _result.header = header;
    }
    if (body != null) {
      _result.body = body;
    }
    return _result;
  }
  factory ProtoBlock.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlock.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlock clone() => ProtoBlock()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlock copyWith(void Function(ProtoBlock) updates) => super.copyWith((message) => updates(message as ProtoBlock)) as ProtoBlock; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlock create() => ProtoBlock._();
  ProtoBlock createEmptyInstance() => create();
  static $pb.PbList<ProtoBlock> createRepeated() => $pb.PbList<ProtoBlock>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlock getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlock>(create);
  static ProtoBlock? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoBlockHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(ProtoBlockHeader v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  ProtoBlockHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  ProtoBlockBody get body => $_getN(1);
  @$pb.TagNumber(2)
  set body(ProtoBlockBody v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => clearField(2);
  @$pb.TagNumber(2)
  ProtoBlockBody ensureBody() => $_ensure(1);
}

class ProtoBlockProposal_Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlockProposal.Data', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoBlockHeader>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'header', subBuilder: ProtoBlockHeader.create)
    ..aOM<ProtoBlockBody>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'body', subBuilder: ProtoBlockBody.create)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proof', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoBlockProposal_Data._() : super();
  factory ProtoBlockProposal_Data({
    ProtoBlockHeader? header,
    ProtoBlockBody? body,
    $core.List<$core.int>? proof,
  }) {
    final _result = create();
    if (header != null) {
      _result.header = header;
    }
    if (body != null) {
      _result.body = body;
    }
    if (proof != null) {
      _result.proof = proof;
    }
    return _result;
  }
  factory ProtoBlockProposal_Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlockProposal_Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlockProposal_Data clone() => ProtoBlockProposal_Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlockProposal_Data copyWith(void Function(ProtoBlockProposal_Data) updates) => super.copyWith((message) => updates(message as ProtoBlockProposal_Data)) as ProtoBlockProposal_Data; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlockProposal_Data create() => ProtoBlockProposal_Data._();
  ProtoBlockProposal_Data createEmptyInstance() => create();
  static $pb.PbList<ProtoBlockProposal_Data> createRepeated() => $pb.PbList<ProtoBlockProposal_Data>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlockProposal_Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlockProposal_Data>(create);
  static ProtoBlockProposal_Data? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoBlockHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(ProtoBlockHeader v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  ProtoBlockHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  ProtoBlockBody get body => $_getN(1);
  @$pb.TagNumber(2)
  set body(ProtoBlockBody v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => clearField(2);
  @$pb.TagNumber(2)
  ProtoBlockBody ensureBody() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$core.int> get proof => $_getN(2);
  @$pb.TagNumber(3)
  set proof($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProof() => $_has(2);
  @$pb.TagNumber(3)
  void clearProof() => clearField(3);
}

class ProtoBlockProposal extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlockProposal', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoBlockProposal_Data>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: ProtoBlockProposal_Data.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoBlockProposal._() : super();
  factory ProtoBlockProposal({
    ProtoBlockProposal_Data? data,
    $core.List<$core.int>? signature,
  }) {
    final _result = create();
    if (data != null) {
      _result.data = data;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory ProtoBlockProposal.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlockProposal.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlockProposal clone() => ProtoBlockProposal()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlockProposal copyWith(void Function(ProtoBlockProposal) updates) => super.copyWith((message) => updates(message as ProtoBlockProposal)) as ProtoBlockProposal; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlockProposal create() => ProtoBlockProposal._();
  ProtoBlockProposal createEmptyInstance() => create();
  static $pb.PbList<ProtoBlockProposal> createRepeated() => $pb.PbList<ProtoBlockProposal>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlockProposal getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlockProposal>(create);
  static ProtoBlockProposal? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoBlockProposal_Data get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(ProtoBlockProposal_Data v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
  @$pb.TagNumber(1)
  ProtoBlockProposal_Data ensureData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);
}

class ProtoIpfsFlip extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoIpfsFlip', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pubKey', $pb.PbFieldType.OY, protoName: 'pubKey')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicPart', $pb.PbFieldType.OY, protoName: 'publicPart')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'privatePart', $pb.PbFieldType.OY, protoName: 'privatePart')
    ..hasRequiredFields = false
  ;

  ProtoIpfsFlip._() : super();
  factory ProtoIpfsFlip({
    $core.List<$core.int>? pubKey,
    $core.List<$core.int>? publicPart,
    $core.List<$core.int>? privatePart,
  }) {
    final _result = create();
    if (pubKey != null) {
      _result.pubKey = pubKey;
    }
    if (publicPart != null) {
      _result.publicPart = publicPart;
    }
    if (privatePart != null) {
      _result.privatePart = privatePart;
    }
    return _result;
  }
  factory ProtoIpfsFlip.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoIpfsFlip.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoIpfsFlip clone() => ProtoIpfsFlip()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoIpfsFlip copyWith(void Function(ProtoIpfsFlip) updates) => super.copyWith((message) => updates(message as ProtoIpfsFlip)) as ProtoIpfsFlip; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoIpfsFlip create() => ProtoIpfsFlip._();
  ProtoIpfsFlip createEmptyInstance() => create();
  static $pb.PbList<ProtoIpfsFlip> createRepeated() => $pb.PbList<ProtoIpfsFlip>();
  @$core.pragma('dart2js:noInline')
  static ProtoIpfsFlip getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoIpfsFlip>(create);
  static ProtoIpfsFlip? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get pubKey => $_getN(0);
  @$pb.TagNumber(1)
  set pubKey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get publicPart => $_getN(1);
  @$pb.TagNumber(2)
  set publicPart($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPublicPart() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicPart() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get privatePart => $_getN(2);
  @$pb.TagNumber(3)
  set privatePart($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrivatePart() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrivatePart() => clearField(3);
}

class ProtoBlockCert_Signature extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlockCert.Signature', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'turnOffline', protoName: 'turnOffline')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'upgrade', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoBlockCert_Signature._() : super();
  factory ProtoBlockCert_Signature({
    $core.bool? turnOffline,
    $core.int? upgrade,
    $core.List<$core.int>? signature,
  }) {
    final _result = create();
    if (turnOffline != null) {
      _result.turnOffline = turnOffline;
    }
    if (upgrade != null) {
      _result.upgrade = upgrade;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory ProtoBlockCert_Signature.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlockCert_Signature.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlockCert_Signature clone() => ProtoBlockCert_Signature()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlockCert_Signature copyWith(void Function(ProtoBlockCert_Signature) updates) => super.copyWith((message) => updates(message as ProtoBlockCert_Signature)) as ProtoBlockCert_Signature; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlockCert_Signature create() => ProtoBlockCert_Signature._();
  ProtoBlockCert_Signature createEmptyInstance() => create();
  static $pb.PbList<ProtoBlockCert_Signature> createRepeated() => $pb.PbList<ProtoBlockCert_Signature>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlockCert_Signature getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlockCert_Signature>(create);
  static ProtoBlockCert_Signature? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get turnOffline => $_getBF(0);
  @$pb.TagNumber(1)
  set turnOffline($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTurnOffline() => $_has(0);
  @$pb.TagNumber(1)
  void clearTurnOffline() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get upgrade => $_getIZ(1);
  @$pb.TagNumber(2)
  set upgrade($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpgrade() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpgrade() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get signature => $_getN(2);
  @$pb.TagNumber(3)
  set signature($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSignature() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignature() => clearField(3);
}

class ProtoBlockCert extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBlockCert', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'round', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'step', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'votedHash', $pb.PbFieldType.OY, protoName: 'votedHash')
    ..pc<ProtoBlockCert_Signature>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signatures', $pb.PbFieldType.PM, subBuilder: ProtoBlockCert_Signature.create)
    ..hasRequiredFields = false
  ;

  ProtoBlockCert._() : super();
  factory ProtoBlockCert({
    $fixnum.Int64? round,
    $core.int? step,
    $core.List<$core.int>? votedHash,
    $core.Iterable<ProtoBlockCert_Signature>? signatures,
  }) {
    final _result = create();
    if (round != null) {
      _result.round = round;
    }
    if (step != null) {
      _result.step = step;
    }
    if (votedHash != null) {
      _result.votedHash = votedHash;
    }
    if (signatures != null) {
      _result.signatures.addAll(signatures);
    }
    return _result;
  }
  factory ProtoBlockCert.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBlockCert.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBlockCert clone() => ProtoBlockCert()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBlockCert copyWith(void Function(ProtoBlockCert) updates) => super.copyWith((message) => updates(message as ProtoBlockCert)) as ProtoBlockCert; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBlockCert create() => ProtoBlockCert._();
  ProtoBlockCert createEmptyInstance() => create();
  static $pb.PbList<ProtoBlockCert> createRepeated() => $pb.PbList<ProtoBlockCert>();
  @$core.pragma('dart2js:noInline')
  static ProtoBlockCert getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBlockCert>(create);
  static ProtoBlockCert? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get round => $_getI64(0);
  @$pb.TagNumber(1)
  set round($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRound() => $_has(0);
  @$pb.TagNumber(1)
  void clearRound() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get step => $_getIZ(1);
  @$pb.TagNumber(2)
  set step($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStep() => $_has(1);
  @$pb.TagNumber(2)
  void clearStep() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get votedHash => $_getN(2);
  @$pb.TagNumber(3)
  set votedHash($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVotedHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearVotedHash() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<ProtoBlockCert_Signature> get signatures => $_getList(3);
}

class ProtoWeakCertificates extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoWeakCertificates', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hashes', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoWeakCertificates._() : super();
  factory ProtoWeakCertificates({
    $core.Iterable<$core.List<$core.int>>? hashes,
  }) {
    final _result = create();
    if (hashes != null) {
      _result.hashes.addAll(hashes);
    }
    return _result;
  }
  factory ProtoWeakCertificates.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoWeakCertificates.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoWeakCertificates clone() => ProtoWeakCertificates()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoWeakCertificates copyWith(void Function(ProtoWeakCertificates) updates) => super.copyWith((message) => updates(message as ProtoWeakCertificates)) as ProtoWeakCertificates; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoWeakCertificates create() => ProtoWeakCertificates._();
  ProtoWeakCertificates createEmptyInstance() => create();
  static $pb.PbList<ProtoWeakCertificates> createRepeated() => $pb.PbList<ProtoWeakCertificates>();
  @$core.pragma('dart2js:noInline')
  static ProtoWeakCertificates getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoWeakCertificates>(create);
  static ProtoWeakCertificates? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.List<$core.int>> get hashes => $_getList(0);
}

class ProtoTransactionIndex extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoTransactionIndex', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockHash', $pb.PbFieldType.OY, protoName: 'blockHash')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idx', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoTransactionIndex._() : super();
  factory ProtoTransactionIndex({
    $core.List<$core.int>? blockHash,
    $core.int? idx,
  }) {
    final _result = create();
    if (blockHash != null) {
      _result.blockHash = blockHash;
    }
    if (idx != null) {
      _result.idx = idx;
    }
    return _result;
  }
  factory ProtoTransactionIndex.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoTransactionIndex.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoTransactionIndex clone() => ProtoTransactionIndex()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoTransactionIndex copyWith(void Function(ProtoTransactionIndex) updates) => super.copyWith((message) => updates(message as ProtoTransactionIndex)) as ProtoTransactionIndex; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTransactionIndex create() => ProtoTransactionIndex._();
  ProtoTransactionIndex createEmptyInstance() => create();
  static $pb.PbList<ProtoTransactionIndex> createRepeated() => $pb.PbList<ProtoTransactionIndex>();
  @$core.pragma('dart2js:noInline')
  static ProtoTransactionIndex getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTransactionIndex>(create);
  static ProtoTransactionIndex? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get blockHash => $_getN(0);
  @$pb.TagNumber(1)
  set blockHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlockHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlockHash() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get idx => $_getIZ(1);
  @$pb.TagNumber(2)
  set idx($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdx() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdx() => clearField(2);
}

class ProtoFlipPrivateKeys extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoFlipPrivateKeys', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'keys', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoFlipPrivateKeys._() : super();
  factory ProtoFlipPrivateKeys({
    $core.Iterable<$core.List<$core.int>>? keys,
  }) {
    final _result = create();
    if (keys != null) {
      _result.keys.addAll(keys);
    }
    return _result;
  }
  factory ProtoFlipPrivateKeys.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoFlipPrivateKeys.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoFlipPrivateKeys clone() => ProtoFlipPrivateKeys()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoFlipPrivateKeys copyWith(void Function(ProtoFlipPrivateKeys) updates) => super.copyWith((message) => updates(message as ProtoFlipPrivateKeys)) as ProtoFlipPrivateKeys; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoFlipPrivateKeys create() => ProtoFlipPrivateKeys._();
  ProtoFlipPrivateKeys createEmptyInstance() => create();
  static $pb.PbList<ProtoFlipPrivateKeys> createRepeated() => $pb.PbList<ProtoFlipPrivateKeys>();
  @$core.pragma('dart2js:noInline')
  static ProtoFlipPrivateKeys getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoFlipPrivateKeys>(create);
  static ProtoFlipPrivateKeys? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.List<$core.int>> get keys => $_getList(0);
}

class ProtoProfile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoProfile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nickname', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'info', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoProfile._() : super();
  factory ProtoProfile({
    $core.List<$core.int>? nickname,
    $core.List<$core.int>? info,
  }) {
    final _result = create();
    if (nickname != null) {
      _result.nickname = nickname;
    }
    if (info != null) {
      _result.info = info;
    }
    return _result;
  }
  factory ProtoProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoProfile clone() => ProtoProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoProfile copyWith(void Function(ProtoProfile) updates) => super.copyWith((message) => updates(message as ProtoProfile)) as ProtoProfile; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoProfile create() => ProtoProfile._();
  ProtoProfile createEmptyInstance() => create();
  static $pb.PbList<ProtoProfile> createRepeated() => $pb.PbList<ProtoProfile>();
  @$core.pragma('dart2js:noInline')
  static ProtoProfile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoProfile>(create);
  static ProtoProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get nickname => $_getN(0);
  @$pb.TagNumber(1)
  set nickname($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNickname() => $_has(0);
  @$pb.TagNumber(1)
  void clearNickname() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get info => $_getN(1);
  @$pb.TagNumber(2)
  set info($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearInfo() => clearField(2);
}

class ProtoHandshake extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoHandshake', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'networkId', $pb.PbFieldType.OU3, protoName: 'networkId')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'genesis', $pb.PbFieldType.OY)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'appVersion', protoName: 'appVersion')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'peers', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oldGenesis', $pb.PbFieldType.OY, protoName: 'oldGenesis')
    ..hasRequiredFields = false
  ;

  ProtoHandshake._() : super();
  factory ProtoHandshake({
    $core.int? networkId,
    $fixnum.Int64? height,
    $core.List<$core.int>? genesis,
    $fixnum.Int64? timestamp,
    $core.String? appVersion,
    $core.int? peers,
    $core.List<$core.int>? oldGenesis,
  }) {
    final _result = create();
    if (networkId != null) {
      _result.networkId = networkId;
    }
    if (height != null) {
      _result.height = height;
    }
    if (genesis != null) {
      _result.genesis = genesis;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (appVersion != null) {
      _result.appVersion = appVersion;
    }
    if (peers != null) {
      _result.peers = peers;
    }
    if (oldGenesis != null) {
      _result.oldGenesis = oldGenesis;
    }
    return _result;
  }
  factory ProtoHandshake.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoHandshake.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoHandshake clone() => ProtoHandshake()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoHandshake copyWith(void Function(ProtoHandshake) updates) => super.copyWith((message) => updates(message as ProtoHandshake)) as ProtoHandshake; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoHandshake create() => ProtoHandshake._();
  ProtoHandshake createEmptyInstance() => create();
  static $pb.PbList<ProtoHandshake> createRepeated() => $pb.PbList<ProtoHandshake>();
  @$core.pragma('dart2js:noInline')
  static ProtoHandshake getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoHandshake>(create);
  static ProtoHandshake? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get networkId => $_getIZ(0);
  @$pb.TagNumber(1)
  set networkId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNetworkId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNetworkId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get height => $_getI64(1);
  @$pb.TagNumber(2)
  set height($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get genesis => $_getN(2);
  @$pb.TagNumber(3)
  set genesis($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGenesis() => $_has(2);
  @$pb.TagNumber(3)
  void clearGenesis() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get appVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set appVersion($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAppVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearAppVersion() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get peers => $_getIZ(5);
  @$pb.TagNumber(6)
  set peers($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPeers() => $_has(5);
  @$pb.TagNumber(6)
  void clearPeers() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get oldGenesis => $_getN(6);
  @$pb.TagNumber(7)
  set oldGenesis($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOldGenesis() => $_has(6);
  @$pb.TagNumber(7)
  void clearOldGenesis() => clearField(7);
}

class ProtoMsg extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoMsg', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payload', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoMsg._() : super();
  factory ProtoMsg({
    $fixnum.Int64? code,
    $core.List<$core.int>? payload,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (payload != null) {
      _result.payload = payload;
    }
    return _result;
  }
  factory ProtoMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoMsg clone() => ProtoMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoMsg copyWith(void Function(ProtoMsg) updates) => super.copyWith((message) => updates(message as ProtoMsg)) as ProtoMsg; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoMsg create() => ProtoMsg._();
  ProtoMsg createEmptyInstance() => create();
  static $pb.PbList<ProtoMsg> createRepeated() => $pb.PbList<ProtoMsg>();
  @$core.pragma('dart2js:noInline')
  static ProtoMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoMsg>(create);
  static ProtoMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get code => $_getI64(0);
  @$pb.TagNumber(1)
  set code($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get payload => $_getN(1);
  @$pb.TagNumber(2)
  set payload($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPayload() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayload() => clearField(2);
}

class ProtoIdentityStateDiff_IdentityStateDiffValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoIdentityStateDiff.IdentityStateDiffValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deleted')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoIdentityStateDiff_IdentityStateDiffValue._() : super();
  factory ProtoIdentityStateDiff_IdentityStateDiffValue({
    $core.List<$core.int>? address,
    $core.bool? deleted,
    $core.List<$core.int>? value,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (deleted != null) {
      _result.deleted = deleted;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ProtoIdentityStateDiff_IdentityStateDiffValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoIdentityStateDiff_IdentityStateDiffValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoIdentityStateDiff_IdentityStateDiffValue clone() => ProtoIdentityStateDiff_IdentityStateDiffValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoIdentityStateDiff_IdentityStateDiffValue copyWith(void Function(ProtoIdentityStateDiff_IdentityStateDiffValue) updates) => super.copyWith((message) => updates(message as ProtoIdentityStateDiff_IdentityStateDiffValue)) as ProtoIdentityStateDiff_IdentityStateDiffValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoIdentityStateDiff_IdentityStateDiffValue create() => ProtoIdentityStateDiff_IdentityStateDiffValue._();
  ProtoIdentityStateDiff_IdentityStateDiffValue createEmptyInstance() => create();
  static $pb.PbList<ProtoIdentityStateDiff_IdentityStateDiffValue> createRepeated() => $pb.PbList<ProtoIdentityStateDiff_IdentityStateDiffValue>();
  @$core.pragma('dart2js:noInline')
  static ProtoIdentityStateDiff_IdentityStateDiffValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoIdentityStateDiff_IdentityStateDiffValue>(create);
  static ProtoIdentityStateDiff_IdentityStateDiffValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get address => $_getN(0);
  @$pb.TagNumber(1)
  set address($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get deleted => $_getBF(1);
  @$pb.TagNumber(2)
  set deleted($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDeleted() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeleted() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get value => $_getN(2);
  @$pb.TagNumber(3)
  set value($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
}

class ProtoIdentityStateDiff extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoIdentityStateDiff', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..pc<ProtoIdentityStateDiff_IdentityStateDiffValue>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values', $pb.PbFieldType.PM, subBuilder: ProtoIdentityStateDiff_IdentityStateDiffValue.create)
    ..hasRequiredFields = false
  ;

  ProtoIdentityStateDiff._() : super();
  factory ProtoIdentityStateDiff({
    $core.Iterable<ProtoIdentityStateDiff_IdentityStateDiffValue>? values,
  }) {
    final _result = create();
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory ProtoIdentityStateDiff.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoIdentityStateDiff.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoIdentityStateDiff clone() => ProtoIdentityStateDiff()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoIdentityStateDiff copyWith(void Function(ProtoIdentityStateDiff) updates) => super.copyWith((message) => updates(message as ProtoIdentityStateDiff)) as ProtoIdentityStateDiff; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoIdentityStateDiff create() => ProtoIdentityStateDiff._();
  ProtoIdentityStateDiff createEmptyInstance() => create();
  static $pb.PbList<ProtoIdentityStateDiff> createRepeated() => $pb.PbList<ProtoIdentityStateDiff>();
  @$core.pragma('dart2js:noInline')
  static ProtoIdentityStateDiff getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoIdentityStateDiff>(create);
  static ProtoIdentityStateDiff? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProtoIdentityStateDiff_IdentityStateDiffValue> get values => $_getList(0);
}

class ProtoSnapshotBlock_KeyValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoSnapshotBlock.KeyValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoSnapshotBlock_KeyValue._() : super();
  factory ProtoSnapshotBlock_KeyValue({
    $core.List<$core.int>? key,
    $core.List<$core.int>? value,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ProtoSnapshotBlock_KeyValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoSnapshotBlock_KeyValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoSnapshotBlock_KeyValue clone() => ProtoSnapshotBlock_KeyValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoSnapshotBlock_KeyValue copyWith(void Function(ProtoSnapshotBlock_KeyValue) updates) => super.copyWith((message) => updates(message as ProtoSnapshotBlock_KeyValue)) as ProtoSnapshotBlock_KeyValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoSnapshotBlock_KeyValue create() => ProtoSnapshotBlock_KeyValue._();
  ProtoSnapshotBlock_KeyValue createEmptyInstance() => create();
  static $pb.PbList<ProtoSnapshotBlock_KeyValue> createRepeated() => $pb.PbList<ProtoSnapshotBlock_KeyValue>();
  @$core.pragma('dart2js:noInline')
  static ProtoSnapshotBlock_KeyValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoSnapshotBlock_KeyValue>(create);
  static ProtoSnapshotBlock_KeyValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get key => $_getN(0);
  @$pb.TagNumber(1)
  set key($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class ProtoSnapshotBlock extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoSnapshotBlock', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..pc<ProtoSnapshotBlock_KeyValue>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.PM, subBuilder: ProtoSnapshotBlock_KeyValue.create)
    ..hasRequiredFields = false
  ;

  ProtoSnapshotBlock._() : super();
  factory ProtoSnapshotBlock({
    $core.Iterable<ProtoSnapshotBlock_KeyValue>? data,
  }) {
    final _result = create();
    if (data != null) {
      _result.data.addAll(data);
    }
    return _result;
  }
  factory ProtoSnapshotBlock.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoSnapshotBlock.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoSnapshotBlock clone() => ProtoSnapshotBlock()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoSnapshotBlock copyWith(void Function(ProtoSnapshotBlock) updates) => super.copyWith((message) => updates(message as ProtoSnapshotBlock)) as ProtoSnapshotBlock; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoSnapshotBlock create() => ProtoSnapshotBlock._();
  ProtoSnapshotBlock createEmptyInstance() => create();
  static $pb.PbList<ProtoSnapshotBlock> createRepeated() => $pb.PbList<ProtoSnapshotBlock>();
  @$core.pragma('dart2js:noInline')
  static ProtoSnapshotBlock getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoSnapshotBlock>(create);
  static ProtoSnapshotBlock? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProtoSnapshotBlock_KeyValue> get data => $_getList(0);
}

class ProtoGossipBlockRange_Block extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoGossipBlockRange.Block', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoBlockHeader>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'header', subBuilder: ProtoBlockHeader.create)
    ..aOM<ProtoBlockCert>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cert', subBuilder: ProtoBlockCert.create)
    ..aOM<ProtoIdentityStateDiff>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'diff', subBuilder: ProtoIdentityStateDiff.create)
    ..hasRequiredFields = false
  ;

  ProtoGossipBlockRange_Block._() : super();
  factory ProtoGossipBlockRange_Block({
    ProtoBlockHeader? header,
    ProtoBlockCert? cert,
    ProtoIdentityStateDiff? diff,
  }) {
    final _result = create();
    if (header != null) {
      _result.header = header;
    }
    if (cert != null) {
      _result.cert = cert;
    }
    if (diff != null) {
      _result.diff = diff;
    }
    return _result;
  }
  factory ProtoGossipBlockRange_Block.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoGossipBlockRange_Block.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoGossipBlockRange_Block clone() => ProtoGossipBlockRange_Block()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoGossipBlockRange_Block copyWith(void Function(ProtoGossipBlockRange_Block) updates) => super.copyWith((message) => updates(message as ProtoGossipBlockRange_Block)) as ProtoGossipBlockRange_Block; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoGossipBlockRange_Block create() => ProtoGossipBlockRange_Block._();
  ProtoGossipBlockRange_Block createEmptyInstance() => create();
  static $pb.PbList<ProtoGossipBlockRange_Block> createRepeated() => $pb.PbList<ProtoGossipBlockRange_Block>();
  @$core.pragma('dart2js:noInline')
  static ProtoGossipBlockRange_Block getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoGossipBlockRange_Block>(create);
  static ProtoGossipBlockRange_Block? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoBlockHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(ProtoBlockHeader v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  ProtoBlockHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  ProtoBlockCert get cert => $_getN(1);
  @$pb.TagNumber(2)
  set cert(ProtoBlockCert v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCert() => $_has(1);
  @$pb.TagNumber(2)
  void clearCert() => clearField(2);
  @$pb.TagNumber(2)
  ProtoBlockCert ensureCert() => $_ensure(1);

  @$pb.TagNumber(3)
  ProtoIdentityStateDiff get diff => $_getN(2);
  @$pb.TagNumber(3)
  set diff(ProtoIdentityStateDiff v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDiff() => $_has(2);
  @$pb.TagNumber(3)
  void clearDiff() => clearField(3);
  @$pb.TagNumber(3)
  ProtoIdentityStateDiff ensureDiff() => $_ensure(2);
}

class ProtoGossipBlockRange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoGossipBlockRange', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchId', $pb.PbFieldType.OU3, protoName: 'batchId')
    ..pc<ProtoGossipBlockRange_Block>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blocks', $pb.PbFieldType.PM, subBuilder: ProtoGossipBlockRange_Block.create)
    ..hasRequiredFields = false
  ;

  ProtoGossipBlockRange._() : super();
  factory ProtoGossipBlockRange({
    $core.int? batchId,
    $core.Iterable<ProtoGossipBlockRange_Block>? blocks,
  }) {
    final _result = create();
    if (batchId != null) {
      _result.batchId = batchId;
    }
    if (blocks != null) {
      _result.blocks.addAll(blocks);
    }
    return _result;
  }
  factory ProtoGossipBlockRange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoGossipBlockRange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoGossipBlockRange clone() => ProtoGossipBlockRange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoGossipBlockRange copyWith(void Function(ProtoGossipBlockRange) updates) => super.copyWith((message) => updates(message as ProtoGossipBlockRange)) as ProtoGossipBlockRange; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoGossipBlockRange create() => ProtoGossipBlockRange._();
  ProtoGossipBlockRange createEmptyInstance() => create();
  static $pb.PbList<ProtoGossipBlockRange> createRepeated() => $pb.PbList<ProtoGossipBlockRange>();
  @$core.pragma('dart2js:noInline')
  static ProtoGossipBlockRange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoGossipBlockRange>(create);
  static ProtoGossipBlockRange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get batchId => $_getIZ(0);
  @$pb.TagNumber(1)
  set batchId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<ProtoGossipBlockRange_Block> get blocks => $_getList(1);
}

class ProtoProposeProof_Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoProposeProof.Data', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proof', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'round', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ProtoProposeProof_Data._() : super();
  factory ProtoProposeProof_Data({
    $core.List<$core.int>? proof,
    $fixnum.Int64? round,
  }) {
    final _result = create();
    if (proof != null) {
      _result.proof = proof;
    }
    if (round != null) {
      _result.round = round;
    }
    return _result;
  }
  factory ProtoProposeProof_Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoProposeProof_Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoProposeProof_Data clone() => ProtoProposeProof_Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoProposeProof_Data copyWith(void Function(ProtoProposeProof_Data) updates) => super.copyWith((message) => updates(message as ProtoProposeProof_Data)) as ProtoProposeProof_Data; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoProposeProof_Data create() => ProtoProposeProof_Data._();
  ProtoProposeProof_Data createEmptyInstance() => create();
  static $pb.PbList<ProtoProposeProof_Data> createRepeated() => $pb.PbList<ProtoProposeProof_Data>();
  @$core.pragma('dart2js:noInline')
  static ProtoProposeProof_Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoProposeProof_Data>(create);
  static ProtoProposeProof_Data? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get proof => $_getN(0);
  @$pb.TagNumber(1)
  set proof($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProof() => $_has(0);
  @$pb.TagNumber(1)
  void clearProof() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get round => $_getI64(1);
  @$pb.TagNumber(2)
  set round($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRound() => $_has(1);
  @$pb.TagNumber(2)
  void clearRound() => clearField(2);
}

class ProtoProposeProof extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoProposeProof', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoProposeProof_Data>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: ProtoProposeProof_Data.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoProposeProof._() : super();
  factory ProtoProposeProof({
    ProtoProposeProof_Data? data,
    $core.List<$core.int>? signature,
  }) {
    final _result = create();
    if (data != null) {
      _result.data = data;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory ProtoProposeProof.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoProposeProof.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoProposeProof clone() => ProtoProposeProof()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoProposeProof copyWith(void Function(ProtoProposeProof) updates) => super.copyWith((message) => updates(message as ProtoProposeProof)) as ProtoProposeProof; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoProposeProof create() => ProtoProposeProof._();
  ProtoProposeProof createEmptyInstance() => create();
  static $pb.PbList<ProtoProposeProof> createRepeated() => $pb.PbList<ProtoProposeProof>();
  @$core.pragma('dart2js:noInline')
  static ProtoProposeProof getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoProposeProof>(create);
  static ProtoProposeProof? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoProposeProof_Data get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(ProtoProposeProof_Data v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
  @$pb.TagNumber(1)
  ProtoProposeProof_Data ensureData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);
}

class ProtoVote_Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoVote.Data', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'round', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'step', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parentHash', $pb.PbFieldType.OY, protoName: 'parentHash')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'votedHash', $pb.PbFieldType.OY, protoName: 'votedHash')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'turnOffline', protoName: 'turnOffline')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'upgrade', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoVote_Data._() : super();
  factory ProtoVote_Data({
    $fixnum.Int64? round,
    $core.int? step,
    $core.List<$core.int>? parentHash,
    $core.List<$core.int>? votedHash,
    $core.bool? turnOffline,
    $core.int? upgrade,
  }) {
    final _result = create();
    if (round != null) {
      _result.round = round;
    }
    if (step != null) {
      _result.step = step;
    }
    if (parentHash != null) {
      _result.parentHash = parentHash;
    }
    if (votedHash != null) {
      _result.votedHash = votedHash;
    }
    if (turnOffline != null) {
      _result.turnOffline = turnOffline;
    }
    if (upgrade != null) {
      _result.upgrade = upgrade;
    }
    return _result;
  }
  factory ProtoVote_Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoVote_Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoVote_Data clone() => ProtoVote_Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoVote_Data copyWith(void Function(ProtoVote_Data) updates) => super.copyWith((message) => updates(message as ProtoVote_Data)) as ProtoVote_Data; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoVote_Data create() => ProtoVote_Data._();
  ProtoVote_Data createEmptyInstance() => create();
  static $pb.PbList<ProtoVote_Data> createRepeated() => $pb.PbList<ProtoVote_Data>();
  @$core.pragma('dart2js:noInline')
  static ProtoVote_Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoVote_Data>(create);
  static ProtoVote_Data? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get round => $_getI64(0);
  @$pb.TagNumber(1)
  set round($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRound() => $_has(0);
  @$pb.TagNumber(1)
  void clearRound() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get step => $_getIZ(1);
  @$pb.TagNumber(2)
  set step($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStep() => $_has(1);
  @$pb.TagNumber(2)
  void clearStep() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get parentHash => $_getN(2);
  @$pb.TagNumber(3)
  set parentHash($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParentHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearParentHash() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get votedHash => $_getN(3);
  @$pb.TagNumber(4)
  set votedHash($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVotedHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearVotedHash() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get turnOffline => $_getBF(4);
  @$pb.TagNumber(5)
  set turnOffline($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTurnOffline() => $_has(4);
  @$pb.TagNumber(5)
  void clearTurnOffline() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get upgrade => $_getIZ(5);
  @$pb.TagNumber(6)
  set upgrade($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpgrade() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpgrade() => clearField(6);
}

class ProtoVote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoVote', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoVote_Data>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: ProtoVote_Data.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoVote._() : super();
  factory ProtoVote({
    ProtoVote_Data? data,
    $core.List<$core.int>? signature,
  }) {
    final _result = create();
    if (data != null) {
      _result.data = data;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory ProtoVote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoVote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoVote clone() => ProtoVote()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoVote copyWith(void Function(ProtoVote) updates) => super.copyWith((message) => updates(message as ProtoVote)) as ProtoVote; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoVote create() => ProtoVote._();
  ProtoVote createEmptyInstance() => create();
  static $pb.PbList<ProtoVote> createRepeated() => $pb.PbList<ProtoVote>();
  @$core.pragma('dart2js:noInline')
  static ProtoVote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoVote>(create);
  static ProtoVote? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoVote_Data get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(ProtoVote_Data v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
  @$pb.TagNumber(1)
  ProtoVote_Data ensureData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);
}

class ProtoGetBlockByHashRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoGetBlockByHashRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoGetBlockByHashRequest._() : super();
  factory ProtoGetBlockByHashRequest({
    $core.List<$core.int>? hash,
  }) {
    final _result = create();
    if (hash != null) {
      _result.hash = hash;
    }
    return _result;
  }
  factory ProtoGetBlockByHashRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoGetBlockByHashRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoGetBlockByHashRequest clone() => ProtoGetBlockByHashRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoGetBlockByHashRequest copyWith(void Function(ProtoGetBlockByHashRequest) updates) => super.copyWith((message) => updates(message as ProtoGetBlockByHashRequest)) as ProtoGetBlockByHashRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoGetBlockByHashRequest create() => ProtoGetBlockByHashRequest._();
  ProtoGetBlockByHashRequest createEmptyInstance() => create();
  static $pb.PbList<ProtoGetBlockByHashRequest> createRepeated() => $pb.PbList<ProtoGetBlockByHashRequest>();
  @$core.pragma('dart2js:noInline')
  static ProtoGetBlockByHashRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoGetBlockByHashRequest>(create);
  static ProtoGetBlockByHashRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get hash => $_getN(0);
  @$pb.TagNumber(1)
  set hash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => clearField(1);
}

class ProtoGetBlocksRangeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoGetBlocksRangeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchId', $pb.PbFieldType.OU3, protoName: 'batchId')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ProtoGetBlocksRangeRequest._() : super();
  factory ProtoGetBlocksRangeRequest({
    $core.int? batchId,
    $fixnum.Int64? from,
    $fixnum.Int64? to,
  }) {
    final _result = create();
    if (batchId != null) {
      _result.batchId = batchId;
    }
    if (from != null) {
      _result.from = from;
    }
    if (to != null) {
      _result.to = to;
    }
    return _result;
  }
  factory ProtoGetBlocksRangeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoGetBlocksRangeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoGetBlocksRangeRequest clone() => ProtoGetBlocksRangeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoGetBlocksRangeRequest copyWith(void Function(ProtoGetBlocksRangeRequest) updates) => super.copyWith((message) => updates(message as ProtoGetBlocksRangeRequest)) as ProtoGetBlocksRangeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoGetBlocksRangeRequest create() => ProtoGetBlocksRangeRequest._();
  ProtoGetBlocksRangeRequest createEmptyInstance() => create();
  static $pb.PbList<ProtoGetBlocksRangeRequest> createRepeated() => $pb.PbList<ProtoGetBlocksRangeRequest>();
  @$core.pragma('dart2js:noInline')
  static ProtoGetBlocksRangeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoGetBlocksRangeRequest>(create);
  static ProtoGetBlocksRangeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get batchId => $_getIZ(0);
  @$pb.TagNumber(1)
  set batchId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get from => $_getI64(1);
  @$pb.TagNumber(2)
  set from($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFrom() => $_has(1);
  @$pb.TagNumber(2)
  void clearFrom() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get to => $_getI64(2);
  @$pb.TagNumber(3)
  set to($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTo() => $_has(2);
  @$pb.TagNumber(3)
  void clearTo() => clearField(3);
}

class ProtoGetForkBlockRangeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoGetForkBlockRangeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'batchId', $pb.PbFieldType.OU3, protoName: 'batchId')
    ..p<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blocks', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoGetForkBlockRangeRequest._() : super();
  factory ProtoGetForkBlockRangeRequest({
    $core.int? batchId,
    $core.Iterable<$core.List<$core.int>>? blocks,
  }) {
    final _result = create();
    if (batchId != null) {
      _result.batchId = batchId;
    }
    if (blocks != null) {
      _result.blocks.addAll(blocks);
    }
    return _result;
  }
  factory ProtoGetForkBlockRangeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoGetForkBlockRangeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoGetForkBlockRangeRequest clone() => ProtoGetForkBlockRangeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoGetForkBlockRangeRequest copyWith(void Function(ProtoGetForkBlockRangeRequest) updates) => super.copyWith((message) => updates(message as ProtoGetForkBlockRangeRequest)) as ProtoGetForkBlockRangeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoGetForkBlockRangeRequest create() => ProtoGetForkBlockRangeRequest._();
  ProtoGetForkBlockRangeRequest createEmptyInstance() => create();
  static $pb.PbList<ProtoGetForkBlockRangeRequest> createRepeated() => $pb.PbList<ProtoGetForkBlockRangeRequest>();
  @$core.pragma('dart2js:noInline')
  static ProtoGetForkBlockRangeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoGetForkBlockRangeRequest>(create);
  static ProtoGetForkBlockRangeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get batchId => $_getIZ(0);
  @$pb.TagNumber(1)
  set batchId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBatchId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatchId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.List<$core.int>> get blocks => $_getList(1);
}

class ProtoFlip extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoFlip', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: ProtoTransaction.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicPart', $pb.PbFieldType.OY, protoName: 'publicPart')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'privatePart', $pb.PbFieldType.OY, protoName: 'privatePart')
    ..hasRequiredFields = false
  ;

  ProtoFlip._() : super();
  factory ProtoFlip({
    ProtoTransaction? transaction,
    $core.List<$core.int>? publicPart,
    $core.List<$core.int>? privatePart,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    if (publicPart != null) {
      _result.publicPart = publicPart;
    }
    if (privatePart != null) {
      _result.privatePart = privatePart;
    }
    return _result;
  }
  factory ProtoFlip.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoFlip.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoFlip clone() => ProtoFlip()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoFlip copyWith(void Function(ProtoFlip) updates) => super.copyWith((message) => updates(message as ProtoFlip)) as ProtoFlip; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoFlip create() => ProtoFlip._();
  ProtoFlip createEmptyInstance() => create();
  static $pb.PbList<ProtoFlip> createRepeated() => $pb.PbList<ProtoFlip>();
  @$core.pragma('dart2js:noInline')
  static ProtoFlip getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoFlip>(create);
  static ProtoFlip? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(ProtoTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  ProtoTransaction ensureTransaction() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get publicPart => $_getN(1);
  @$pb.TagNumber(2)
  set publicPart($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPublicPart() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicPart() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get privatePart => $_getN(2);
  @$pb.TagNumber(3)
  set privatePart($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrivatePart() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrivatePart() => clearField(3);
}

class ProtoFlipKey_Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoFlipKey.Data', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epoch', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoFlipKey_Data._() : super();
  factory ProtoFlipKey_Data({
    $core.List<$core.int>? key,
    $core.int? epoch,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (epoch != null) {
      _result.epoch = epoch;
    }
    return _result;
  }
  factory ProtoFlipKey_Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoFlipKey_Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoFlipKey_Data clone() => ProtoFlipKey_Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoFlipKey_Data copyWith(void Function(ProtoFlipKey_Data) updates) => super.copyWith((message) => updates(message as ProtoFlipKey_Data)) as ProtoFlipKey_Data; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoFlipKey_Data create() => ProtoFlipKey_Data._();
  ProtoFlipKey_Data createEmptyInstance() => create();
  static $pb.PbList<ProtoFlipKey_Data> createRepeated() => $pb.PbList<ProtoFlipKey_Data>();
  @$core.pragma('dart2js:noInline')
  static ProtoFlipKey_Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoFlipKey_Data>(create);
  static ProtoFlipKey_Data? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get key => $_getN(0);
  @$pb.TagNumber(1)
  set key($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get epoch => $_getIZ(1);
  @$pb.TagNumber(2)
  set epoch($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpoch() => clearField(2);
}

class ProtoFlipKey extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoFlipKey', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoFlipKey_Data>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: ProtoFlipKey_Data.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoFlipKey._() : super();
  factory ProtoFlipKey({
    ProtoFlipKey_Data? data,
    $core.List<$core.int>? signature,
  }) {
    final _result = create();
    if (data != null) {
      _result.data = data;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory ProtoFlipKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoFlipKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoFlipKey clone() => ProtoFlipKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoFlipKey copyWith(void Function(ProtoFlipKey) updates) => super.copyWith((message) => updates(message as ProtoFlipKey)) as ProtoFlipKey; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoFlipKey create() => ProtoFlipKey._();
  ProtoFlipKey createEmptyInstance() => create();
  static $pb.PbList<ProtoFlipKey> createRepeated() => $pb.PbList<ProtoFlipKey>();
  @$core.pragma('dart2js:noInline')
  static ProtoFlipKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoFlipKey>(create);
  static ProtoFlipKey? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoFlipKey_Data get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(ProtoFlipKey_Data v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
  @$pb.TagNumber(1)
  ProtoFlipKey_Data ensureData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);
}

class ProtoManifest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoManifest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cid', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'root', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoManifest._() : super();
  factory ProtoManifest({
    $core.List<$core.int>? cid,
    $fixnum.Int64? height,
    $core.List<$core.int>? root,
  }) {
    final _result = create();
    if (cid != null) {
      _result.cid = cid;
    }
    if (height != null) {
      _result.height = height;
    }
    if (root != null) {
      _result.root = root;
    }
    return _result;
  }
  factory ProtoManifest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoManifest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoManifest clone() => ProtoManifest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoManifest copyWith(void Function(ProtoManifest) updates) => super.copyWith((message) => updates(message as ProtoManifest)) as ProtoManifest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoManifest create() => ProtoManifest._();
  ProtoManifest createEmptyInstance() => create();
  static $pb.PbList<ProtoManifest> createRepeated() => $pb.PbList<ProtoManifest>();
  @$core.pragma('dart2js:noInline')
  static ProtoManifest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoManifest>(create);
  static ProtoManifest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get cid => $_getN(0);
  @$pb.TagNumber(1)
  set cid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCid() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get height => $_getI64(1);
  @$pb.TagNumber(2)
  set height($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get root => $_getN(2);
  @$pb.TagNumber(3)
  set root($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRoot() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoot() => clearField(3);
}

class ProtoPrivateFlipKeysPackage_Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPrivateFlipKeysPackage.Data', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'package', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epoch', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoPrivateFlipKeysPackage_Data._() : super();
  factory ProtoPrivateFlipKeysPackage_Data({
    $core.List<$core.int>? package,
    $core.int? epoch,
  }) {
    final _result = create();
    if (package != null) {
      _result.package = package;
    }
    if (epoch != null) {
      _result.epoch = epoch;
    }
    return _result;
  }
  factory ProtoPrivateFlipKeysPackage_Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPrivateFlipKeysPackage_Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPrivateFlipKeysPackage_Data clone() => ProtoPrivateFlipKeysPackage_Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPrivateFlipKeysPackage_Data copyWith(void Function(ProtoPrivateFlipKeysPackage_Data) updates) => super.copyWith((message) => updates(message as ProtoPrivateFlipKeysPackage_Data)) as ProtoPrivateFlipKeysPackage_Data; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPrivateFlipKeysPackage_Data create() => ProtoPrivateFlipKeysPackage_Data._();
  ProtoPrivateFlipKeysPackage_Data createEmptyInstance() => create();
  static $pb.PbList<ProtoPrivateFlipKeysPackage_Data> createRepeated() => $pb.PbList<ProtoPrivateFlipKeysPackage_Data>();
  @$core.pragma('dart2js:noInline')
  static ProtoPrivateFlipKeysPackage_Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPrivateFlipKeysPackage_Data>(create);
  static ProtoPrivateFlipKeysPackage_Data? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get package => $_getN(0);
  @$pb.TagNumber(1)
  set package($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPackage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get epoch => $_getIZ(1);
  @$pb.TagNumber(2)
  set epoch($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpoch() => clearField(2);
}

class ProtoPrivateFlipKeysPackage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPrivateFlipKeysPackage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoPrivateFlipKeysPackage_Data>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: ProtoPrivateFlipKeysPackage_Data.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoPrivateFlipKeysPackage._() : super();
  factory ProtoPrivateFlipKeysPackage({
    ProtoPrivateFlipKeysPackage_Data? data,
    $core.List<$core.int>? signature,
  }) {
    final _result = create();
    if (data != null) {
      _result.data = data;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory ProtoPrivateFlipKeysPackage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPrivateFlipKeysPackage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPrivateFlipKeysPackage clone() => ProtoPrivateFlipKeysPackage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPrivateFlipKeysPackage copyWith(void Function(ProtoPrivateFlipKeysPackage) updates) => super.copyWith((message) => updates(message as ProtoPrivateFlipKeysPackage)) as ProtoPrivateFlipKeysPackage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPrivateFlipKeysPackage create() => ProtoPrivateFlipKeysPackage._();
  ProtoPrivateFlipKeysPackage createEmptyInstance() => create();
  static $pb.PbList<ProtoPrivateFlipKeysPackage> createRepeated() => $pb.PbList<ProtoPrivateFlipKeysPackage>();
  @$core.pragma('dart2js:noInline')
  static ProtoPrivateFlipKeysPackage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPrivateFlipKeysPackage>(create);
  static ProtoPrivateFlipKeysPackage? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoPrivateFlipKeysPackage_Data get data => $_getN(0);
  @$pb.TagNumber(1)
  set data(ProtoPrivateFlipKeysPackage_Data v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
  @$pb.TagNumber(1)
  ProtoPrivateFlipKeysPackage_Data ensureData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);
}

class ProtoPullPushHash extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPullPushHash', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoPullPushHash._() : super();
  factory ProtoPullPushHash({
    $core.int? type,
    $core.List<$core.int>? hash,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (hash != null) {
      _result.hash = hash;
    }
    return _result;
  }
  factory ProtoPullPushHash.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPullPushHash.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPullPushHash clone() => ProtoPullPushHash()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPullPushHash copyWith(void Function(ProtoPullPushHash) updates) => super.copyWith((message) => updates(message as ProtoPullPushHash)) as ProtoPullPushHash; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPullPushHash create() => ProtoPullPushHash._();
  ProtoPullPushHash createEmptyInstance() => create();
  static $pb.PbList<ProtoPullPushHash> createRepeated() => $pb.PbList<ProtoPullPushHash>();
  @$core.pragma('dart2js:noInline')
  static ProtoPullPushHash getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPullPushHash>(create);
  static ProtoPullPushHash? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get type => $_getIZ(0);
  @$pb.TagNumber(1)
  set type($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get hash => $_getN(1);
  @$pb.TagNumber(2)
  set hash($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearHash() => clearField(2);
}

class ProtoSnapshotManifestDb extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoSnapshotManifestDb', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cid', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileName', protoName: 'fileName')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'root', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoSnapshotManifestDb._() : super();
  factory ProtoSnapshotManifestDb({
    $core.List<$core.int>? cid,
    $fixnum.Int64? height,
    $core.String? fileName,
    $core.List<$core.int>? root,
  }) {
    final _result = create();
    if (cid != null) {
      _result.cid = cid;
    }
    if (height != null) {
      _result.height = height;
    }
    if (fileName != null) {
      _result.fileName = fileName;
    }
    if (root != null) {
      _result.root = root;
    }
    return _result;
  }
  factory ProtoSnapshotManifestDb.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoSnapshotManifestDb.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoSnapshotManifestDb clone() => ProtoSnapshotManifestDb()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoSnapshotManifestDb copyWith(void Function(ProtoSnapshotManifestDb) updates) => super.copyWith((message) => updates(message as ProtoSnapshotManifestDb)) as ProtoSnapshotManifestDb; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoSnapshotManifestDb create() => ProtoSnapshotManifestDb._();
  ProtoSnapshotManifestDb createEmptyInstance() => create();
  static $pb.PbList<ProtoSnapshotManifestDb> createRepeated() => $pb.PbList<ProtoSnapshotManifestDb>();
  @$core.pragma('dart2js:noInline')
  static ProtoSnapshotManifestDb getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoSnapshotManifestDb>(create);
  static ProtoSnapshotManifestDb? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get cid => $_getN(0);
  @$pb.TagNumber(1)
  set cid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCid() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get height => $_getI64(1);
  @$pb.TagNumber(2)
  set height($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get fileName => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFileName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileName() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get root => $_getN(3);
  @$pb.TagNumber(4)
  set root($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRoot() => $_has(3);
  @$pb.TagNumber(4)
  void clearRoot() => clearField(4);
}

class ProtoShortAnswerDb extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoShortAnswerDb', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hash', $pb.PbFieldType.OY)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  ProtoShortAnswerDb._() : super();
  factory ProtoShortAnswerDb({
    $core.List<$core.int>? hash,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (hash != null) {
      _result.hash = hash;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory ProtoShortAnswerDb.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoShortAnswerDb.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoShortAnswerDb clone() => ProtoShortAnswerDb()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoShortAnswerDb copyWith(void Function(ProtoShortAnswerDb) updates) => super.copyWith((message) => updates(message as ProtoShortAnswerDb)) as ProtoShortAnswerDb; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoShortAnswerDb create() => ProtoShortAnswerDb._();
  ProtoShortAnswerDb createEmptyInstance() => create();
  static $pb.PbList<ProtoShortAnswerDb> createRepeated() => $pb.PbList<ProtoShortAnswerDb>();
  @$core.pragma('dart2js:noInline')
  static ProtoShortAnswerDb getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoShortAnswerDb>(create);
  static ProtoShortAnswerDb? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get hash => $_getN(0);
  @$pb.TagNumber(1)
  set hash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set timestamp($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);
}

class ProtoAnswersDb_Answer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoAnswersDb.Answer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'answers', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoAnswersDb_Answer._() : super();
  factory ProtoAnswersDb_Answer({
    $core.List<$core.int>? address,
    $core.List<$core.int>? answers,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (answers != null) {
      _result.answers = answers;
    }
    return _result;
  }
  factory ProtoAnswersDb_Answer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoAnswersDb_Answer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoAnswersDb_Answer clone() => ProtoAnswersDb_Answer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoAnswersDb_Answer copyWith(void Function(ProtoAnswersDb_Answer) updates) => super.copyWith((message) => updates(message as ProtoAnswersDb_Answer)) as ProtoAnswersDb_Answer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoAnswersDb_Answer create() => ProtoAnswersDb_Answer._();
  ProtoAnswersDb_Answer createEmptyInstance() => create();
  static $pb.PbList<ProtoAnswersDb_Answer> createRepeated() => $pb.PbList<ProtoAnswersDb_Answer>();
  @$core.pragma('dart2js:noInline')
  static ProtoAnswersDb_Answer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoAnswersDb_Answer>(create);
  static ProtoAnswersDb_Answer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get address => $_getN(0);
  @$pb.TagNumber(1)
  set address($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get answers => $_getN(1);
  @$pb.TagNumber(2)
  set answers($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAnswers() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnswers() => clearField(2);
}

class ProtoAnswersDb extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoAnswersDb', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..pc<ProtoAnswersDb_Answer>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'answers', $pb.PbFieldType.PM, subBuilder: ProtoAnswersDb_Answer.create)
    ..hasRequiredFields = false
  ;

  ProtoAnswersDb._() : super();
  factory ProtoAnswersDb({
    $core.Iterable<ProtoAnswersDb_Answer>? answers,
  }) {
    final _result = create();
    if (answers != null) {
      _result.answers.addAll(answers);
    }
    return _result;
  }
  factory ProtoAnswersDb.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoAnswersDb.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoAnswersDb clone() => ProtoAnswersDb()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoAnswersDb copyWith(void Function(ProtoAnswersDb) updates) => super.copyWith((message) => updates(message as ProtoAnswersDb)) as ProtoAnswersDb; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoAnswersDb create() => ProtoAnswersDb._();
  ProtoAnswersDb createEmptyInstance() => create();
  static $pb.PbList<ProtoAnswersDb> createRepeated() => $pb.PbList<ProtoAnswersDb>();
  @$core.pragma('dart2js:noInline')
  static ProtoAnswersDb getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoAnswersDb>(create);
  static ProtoAnswersDb? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProtoAnswersDb_Answer> get answers => $_getList(0);
}

class ProtoBurntCoins extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBurntCoins', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoBurntCoins._() : super();
  factory ProtoBurntCoins({
    $core.List<$core.int>? address,
    $core.String? key,
    $core.List<$core.int>? amount,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (key != null) {
      _result.key = key;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    return _result;
  }
  factory ProtoBurntCoins.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBurntCoins.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBurntCoins clone() => ProtoBurntCoins()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBurntCoins copyWith(void Function(ProtoBurntCoins) updates) => super.copyWith((message) => updates(message as ProtoBurntCoins)) as ProtoBurntCoins; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBurntCoins create() => ProtoBurntCoins._();
  ProtoBurntCoins createEmptyInstance() => create();
  static $pb.PbList<ProtoBurntCoins> createRepeated() => $pb.PbList<ProtoBurntCoins>();
  @$core.pragma('dart2js:noInline')
  static ProtoBurntCoins getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBurntCoins>(create);
  static ProtoBurntCoins? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get address => $_getN(0);
  @$pb.TagNumber(1)
  set address($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get key => $_getSZ(1);
  @$pb.TagNumber(2)
  set key($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);
}

class ProtoSavedTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoSavedTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOM<ProtoTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tx', subBuilder: ProtoTransaction.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePerGas', $pb.PbFieldType.OY, protoName: 'feePerGas')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockHash', $pb.PbFieldType.OY, protoName: 'blockHash')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  ProtoSavedTransaction._() : super();
  factory ProtoSavedTransaction({
    ProtoTransaction? tx,
    $core.List<$core.int>? feePerGas,
    $core.List<$core.int>? blockHash,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (tx != null) {
      _result.tx = tx;
    }
    if (feePerGas != null) {
      _result.feePerGas = feePerGas;
    }
    if (blockHash != null) {
      _result.blockHash = blockHash;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory ProtoSavedTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoSavedTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoSavedTransaction clone() => ProtoSavedTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoSavedTransaction copyWith(void Function(ProtoSavedTransaction) updates) => super.copyWith((message) => updates(message as ProtoSavedTransaction)) as ProtoSavedTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoSavedTransaction create() => ProtoSavedTransaction._();
  ProtoSavedTransaction createEmptyInstance() => create();
  static $pb.PbList<ProtoSavedTransaction> createRepeated() => $pb.PbList<ProtoSavedTransaction>();
  @$core.pragma('dart2js:noInline')
  static ProtoSavedTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoSavedTransaction>(create);
  static ProtoSavedTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoTransaction get tx => $_getN(0);
  @$pb.TagNumber(1)
  set tx(ProtoTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTx() => $_has(0);
  @$pb.TagNumber(1)
  void clearTx() => clearField(1);
  @$pb.TagNumber(1)
  ProtoTransaction ensureTx() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get feePerGas => $_getN(1);
  @$pb.TagNumber(2)
  set feePerGas($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFeePerGas() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeePerGas() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get blockHash => $_getN(2);
  @$pb.TagNumber(3)
  set blockHash($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBlockHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlockHash() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);
}

class ProtoActivityMonitor_Activity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoActivityMonitor.Activity', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  ProtoActivityMonitor_Activity._() : super();
  factory ProtoActivityMonitor_Activity({
    $core.List<$core.int>? address,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory ProtoActivityMonitor_Activity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoActivityMonitor_Activity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoActivityMonitor_Activity clone() => ProtoActivityMonitor_Activity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoActivityMonitor_Activity copyWith(void Function(ProtoActivityMonitor_Activity) updates) => super.copyWith((message) => updates(message as ProtoActivityMonitor_Activity)) as ProtoActivityMonitor_Activity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoActivityMonitor_Activity create() => ProtoActivityMonitor_Activity._();
  ProtoActivityMonitor_Activity createEmptyInstance() => create();
  static $pb.PbList<ProtoActivityMonitor_Activity> createRepeated() => $pb.PbList<ProtoActivityMonitor_Activity>();
  @$core.pragma('dart2js:noInline')
  static ProtoActivityMonitor_Activity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoActivityMonitor_Activity>(create);
  static ProtoActivityMonitor_Activity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get address => $_getN(0);
  @$pb.TagNumber(1)
  set address($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set timestamp($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);
}

class ProtoActivityMonitor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoActivityMonitor', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..pc<ProtoActivityMonitor_Activity>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activities', $pb.PbFieldType.PM, subBuilder: ProtoActivityMonitor_Activity.create)
    ..hasRequiredFields = false
  ;

  ProtoActivityMonitor._() : super();
  factory ProtoActivityMonitor({
    $fixnum.Int64? timestamp,
    $core.Iterable<ProtoActivityMonitor_Activity>? activities,
  }) {
    final _result = create();
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (activities != null) {
      _result.activities.addAll(activities);
    }
    return _result;
  }
  factory ProtoActivityMonitor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoActivityMonitor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoActivityMonitor clone() => ProtoActivityMonitor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoActivityMonitor copyWith(void Function(ProtoActivityMonitor) updates) => super.copyWith((message) => updates(message as ProtoActivityMonitor)) as ProtoActivityMonitor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoActivityMonitor create() => ProtoActivityMonitor._();
  ProtoActivityMonitor createEmptyInstance() => create();
  static $pb.PbList<ProtoActivityMonitor> createRepeated() => $pb.PbList<ProtoActivityMonitor>();
  @$core.pragma('dart2js:noInline')
  static ProtoActivityMonitor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoActivityMonitor>(create);
  static ProtoActivityMonitor? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set timestamp($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<ProtoActivityMonitor_Activity> get activities => $_getList(1);
}

class ProtoShortAnswerAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoShortAnswerAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'answers', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rnd', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ProtoShortAnswerAttachment._() : super();
  factory ProtoShortAnswerAttachment({
    $core.List<$core.int>? answers,
    $fixnum.Int64? rnd,
  }) {
    final _result = create();
    if (answers != null) {
      _result.answers = answers;
    }
    if (rnd != null) {
      _result.rnd = rnd;
    }
    return _result;
  }
  factory ProtoShortAnswerAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoShortAnswerAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoShortAnswerAttachment clone() => ProtoShortAnswerAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoShortAnswerAttachment copyWith(void Function(ProtoShortAnswerAttachment) updates) => super.copyWith((message) => updates(message as ProtoShortAnswerAttachment)) as ProtoShortAnswerAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoShortAnswerAttachment create() => ProtoShortAnswerAttachment._();
  ProtoShortAnswerAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoShortAnswerAttachment> createRepeated() => $pb.PbList<ProtoShortAnswerAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoShortAnswerAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoShortAnswerAttachment>(create);
  static ProtoShortAnswerAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get answers => $_getN(0);
  @$pb.TagNumber(1)
  set answers($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAnswers() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnswers() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get rnd => $_getI64(1);
  @$pb.TagNumber(2)
  set rnd($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearRnd() => clearField(2);
}

class ProtoLongAnswerAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoLongAnswerAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'answers', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proof', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'salt', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoLongAnswerAttachment._() : super();
  factory ProtoLongAnswerAttachment({
    $core.List<$core.int>? answers,
    $core.List<$core.int>? proof,
    $core.List<$core.int>? key,
    $core.List<$core.int>? salt,
  }) {
    final _result = create();
    if (answers != null) {
      _result.answers = answers;
    }
    if (proof != null) {
      _result.proof = proof;
    }
    if (key != null) {
      _result.key = key;
    }
    if (salt != null) {
      _result.salt = salt;
    }
    return _result;
  }
  factory ProtoLongAnswerAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoLongAnswerAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoLongAnswerAttachment clone() => ProtoLongAnswerAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoLongAnswerAttachment copyWith(void Function(ProtoLongAnswerAttachment) updates) => super.copyWith((message) => updates(message as ProtoLongAnswerAttachment)) as ProtoLongAnswerAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoLongAnswerAttachment create() => ProtoLongAnswerAttachment._();
  ProtoLongAnswerAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoLongAnswerAttachment> createRepeated() => $pb.PbList<ProtoLongAnswerAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoLongAnswerAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoLongAnswerAttachment>(create);
  static ProtoLongAnswerAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get answers => $_getN(0);
  @$pb.TagNumber(1)
  set answers($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAnswers() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnswers() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get proof => $_getN(1);
  @$pb.TagNumber(2)
  set proof($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProof() => $_has(1);
  @$pb.TagNumber(2)
  void clearProof() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get key => $_getN(2);
  @$pb.TagNumber(3)
  set key($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get salt => $_getN(3);
  @$pb.TagNumber(4)
  set salt($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSalt() => $_has(3);
  @$pb.TagNumber(4)
  void clearSalt() => clearField(4);
}

class ProtoFlipSubmitAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoFlipSubmitAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cid', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pair', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoFlipSubmitAttachment._() : super();
  factory ProtoFlipSubmitAttachment({
    $core.List<$core.int>? cid,
    $core.int? pair,
  }) {
    final _result = create();
    if (cid != null) {
      _result.cid = cid;
    }
    if (pair != null) {
      _result.pair = pair;
    }
    return _result;
  }
  factory ProtoFlipSubmitAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoFlipSubmitAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoFlipSubmitAttachment clone() => ProtoFlipSubmitAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoFlipSubmitAttachment copyWith(void Function(ProtoFlipSubmitAttachment) updates) => super.copyWith((message) => updates(message as ProtoFlipSubmitAttachment)) as ProtoFlipSubmitAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoFlipSubmitAttachment create() => ProtoFlipSubmitAttachment._();
  ProtoFlipSubmitAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoFlipSubmitAttachment> createRepeated() => $pb.PbList<ProtoFlipSubmitAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoFlipSubmitAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoFlipSubmitAttachment>(create);
  static ProtoFlipSubmitAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get cid => $_getN(0);
  @$pb.TagNumber(1)
  set cid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCid() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pair => $_getIZ(1);
  @$pb.TagNumber(2)
  set pair($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPair() => $_has(1);
  @$pb.TagNumber(2)
  void clearPair() => clearField(2);
}

class ProtoOnlineStatusAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOnlineStatusAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'online')
    ..hasRequiredFields = false
  ;

  ProtoOnlineStatusAttachment._() : super();
  factory ProtoOnlineStatusAttachment({
    $core.bool? online,
  }) {
    final _result = create();
    if (online != null) {
      _result.online = online;
    }
    return _result;
  }
  factory ProtoOnlineStatusAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoOnlineStatusAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoOnlineStatusAttachment clone() => ProtoOnlineStatusAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoOnlineStatusAttachment copyWith(void Function(ProtoOnlineStatusAttachment) updates) => super.copyWith((message) => updates(message as ProtoOnlineStatusAttachment)) as ProtoOnlineStatusAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoOnlineStatusAttachment create() => ProtoOnlineStatusAttachment._();
  ProtoOnlineStatusAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoOnlineStatusAttachment> createRepeated() => $pb.PbList<ProtoOnlineStatusAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoOnlineStatusAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoOnlineStatusAttachment>(create);
  static ProtoOnlineStatusAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get online => $_getBF(0);
  @$pb.TagNumber(1)
  set online($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOnline() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnline() => clearField(1);
}

class ProtoBurnAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoBurnAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..hasRequiredFields = false
  ;

  ProtoBurnAttachment._() : super();
  factory ProtoBurnAttachment({
    $core.String? key,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    return _result;
  }
  factory ProtoBurnAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoBurnAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoBurnAttachment clone() => ProtoBurnAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoBurnAttachment copyWith(void Function(ProtoBurnAttachment) updates) => super.copyWith((message) => updates(message as ProtoBurnAttachment)) as ProtoBurnAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoBurnAttachment create() => ProtoBurnAttachment._();
  ProtoBurnAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoBurnAttachment> createRepeated() => $pb.PbList<ProtoBurnAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoBurnAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoBurnAttachment>(create);
  static ProtoBurnAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);
}

class ProtoChangeProfileAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoChangeProfileAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoChangeProfileAttachment._() : super();
  factory ProtoChangeProfileAttachment({
    $core.List<$core.int>? hash,
  }) {
    final _result = create();
    if (hash != null) {
      _result.hash = hash;
    }
    return _result;
  }
  factory ProtoChangeProfileAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoChangeProfileAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoChangeProfileAttachment clone() => ProtoChangeProfileAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoChangeProfileAttachment copyWith(void Function(ProtoChangeProfileAttachment) updates) => super.copyWith((message) => updates(message as ProtoChangeProfileAttachment)) as ProtoChangeProfileAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoChangeProfileAttachment create() => ProtoChangeProfileAttachment._();
  ProtoChangeProfileAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoChangeProfileAttachment> createRepeated() => $pb.PbList<ProtoChangeProfileAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoChangeProfileAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoChangeProfileAttachment>(create);
  static ProtoChangeProfileAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get hash => $_getN(0);
  @$pb.TagNumber(1)
  set hash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => clearField(1);
}

class ProtoDeleteFlipAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoDeleteFlipAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cid', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoDeleteFlipAttachment._() : super();
  factory ProtoDeleteFlipAttachment({
    $core.List<$core.int>? cid,
  }) {
    final _result = create();
    if (cid != null) {
      _result.cid = cid;
    }
    return _result;
  }
  factory ProtoDeleteFlipAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoDeleteFlipAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoDeleteFlipAttachment clone() => ProtoDeleteFlipAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoDeleteFlipAttachment copyWith(void Function(ProtoDeleteFlipAttachment) updates) => super.copyWith((message) => updates(message as ProtoDeleteFlipAttachment)) as ProtoDeleteFlipAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoDeleteFlipAttachment create() => ProtoDeleteFlipAttachment._();
  ProtoDeleteFlipAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoDeleteFlipAttachment> createRepeated() => $pb.PbList<ProtoDeleteFlipAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoDeleteFlipAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoDeleteFlipAttachment>(create);
  static ProtoDeleteFlipAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get cid => $_getN(0);
  @$pb.TagNumber(1)
  set cid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCid() => clearField(1);
}

class ProtoStateAccount_ProtoContractData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoStateAccount.ProtoContractData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'codeHash', $pb.PbFieldType.OY, protoName: 'codeHash')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stake', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoStateAccount_ProtoContractData._() : super();
  factory ProtoStateAccount_ProtoContractData({
    $core.List<$core.int>? codeHash,
    $core.List<$core.int>? stake,
  }) {
    final _result = create();
    if (codeHash != null) {
      _result.codeHash = codeHash;
    }
    if (stake != null) {
      _result.stake = stake;
    }
    return _result;
  }
  factory ProtoStateAccount_ProtoContractData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoStateAccount_ProtoContractData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoStateAccount_ProtoContractData clone() => ProtoStateAccount_ProtoContractData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoStateAccount_ProtoContractData copyWith(void Function(ProtoStateAccount_ProtoContractData) updates) => super.copyWith((message) => updates(message as ProtoStateAccount_ProtoContractData)) as ProtoStateAccount_ProtoContractData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoStateAccount_ProtoContractData create() => ProtoStateAccount_ProtoContractData._();
  ProtoStateAccount_ProtoContractData createEmptyInstance() => create();
  static $pb.PbList<ProtoStateAccount_ProtoContractData> createRepeated() => $pb.PbList<ProtoStateAccount_ProtoContractData>();
  @$core.pragma('dart2js:noInline')
  static ProtoStateAccount_ProtoContractData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoStateAccount_ProtoContractData>(create);
  static ProtoStateAccount_ProtoContractData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get codeHash => $_getN(0);
  @$pb.TagNumber(1)
  set codeHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCodeHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearCodeHash() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get stake => $_getN(1);
  @$pb.TagNumber(2)
  set stake($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStake() => $_has(1);
  @$pb.TagNumber(2)
  void clearStake() => clearField(2);
}

class ProtoStateAccount extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoStateAccount', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nonce', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epoch', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OY)
    ..aOM<ProtoStateAccount_ProtoContractData>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contractData', protoName: 'contractData', subBuilder: ProtoStateAccount_ProtoContractData.create)
    ..hasRequiredFields = false
  ;

  ProtoStateAccount._() : super();
  factory ProtoStateAccount({
    $core.int? nonce,
    $core.int? epoch,
    $core.List<$core.int>? balance,
    ProtoStateAccount_ProtoContractData? contractData,
  }) {
    final _result = create();
    if (nonce != null) {
      _result.nonce = nonce;
    }
    if (epoch != null) {
      _result.epoch = epoch;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (contractData != null) {
      _result.contractData = contractData;
    }
    return _result;
  }
  factory ProtoStateAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoStateAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoStateAccount clone() => ProtoStateAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoStateAccount copyWith(void Function(ProtoStateAccount) updates) => super.copyWith((message) => updates(message as ProtoStateAccount)) as ProtoStateAccount; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoStateAccount create() => ProtoStateAccount._();
  ProtoStateAccount createEmptyInstance() => create();
  static $pb.PbList<ProtoStateAccount> createRepeated() => $pb.PbList<ProtoStateAccount>();
  @$core.pragma('dart2js:noInline')
  static ProtoStateAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoStateAccount>(create);
  static ProtoStateAccount? _defaultInstance;

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
  $core.List<$core.int> get balance => $_getN(2);
  @$pb.TagNumber(3)
  set balance($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearBalance() => clearField(3);

  @$pb.TagNumber(4)
  ProtoStateAccount_ProtoContractData get contractData => $_getN(3);
  @$pb.TagNumber(4)
  set contractData(ProtoStateAccount_ProtoContractData v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasContractData() => $_has(3);
  @$pb.TagNumber(4)
  void clearContractData() => clearField(4);
  @$pb.TagNumber(4)
  ProtoStateAccount_ProtoContractData ensureContractData() => $_ensure(3);
}

class ProtoStateIdentity_Flip extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoStateIdentity.Flip', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cid', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pair', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoStateIdentity_Flip._() : super();
  factory ProtoStateIdentity_Flip({
    $core.List<$core.int>? cid,
    $core.int? pair,
  }) {
    final _result = create();
    if (cid != null) {
      _result.cid = cid;
    }
    if (pair != null) {
      _result.pair = pair;
    }
    return _result;
  }
  factory ProtoStateIdentity_Flip.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoStateIdentity_Flip.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoStateIdentity_Flip clone() => ProtoStateIdentity_Flip()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoStateIdentity_Flip copyWith(void Function(ProtoStateIdentity_Flip) updates) => super.copyWith((message) => updates(message as ProtoStateIdentity_Flip)) as ProtoStateIdentity_Flip; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoStateIdentity_Flip create() => ProtoStateIdentity_Flip._();
  ProtoStateIdentity_Flip createEmptyInstance() => create();
  static $pb.PbList<ProtoStateIdentity_Flip> createRepeated() => $pb.PbList<ProtoStateIdentity_Flip>();
  @$core.pragma('dart2js:noInline')
  static ProtoStateIdentity_Flip getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoStateIdentity_Flip>(create);
  static ProtoStateIdentity_Flip? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get cid => $_getN(0);
  @$pb.TagNumber(1)
  set cid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCid() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pair => $_getIZ(1);
  @$pb.TagNumber(2)
  set pair($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPair() => $_has(1);
  @$pb.TagNumber(2)
  void clearPair() => clearField(2);
}

class ProtoStateIdentity_TxAddr extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoStateIdentity.TxAddr', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoStateIdentity_TxAddr._() : super();
  factory ProtoStateIdentity_TxAddr({
    $core.List<$core.int>? hash,
    $core.List<$core.int>? address,
  }) {
    final _result = create();
    if (hash != null) {
      _result.hash = hash;
    }
    if (address != null) {
      _result.address = address;
    }
    return _result;
  }
  factory ProtoStateIdentity_TxAddr.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoStateIdentity_TxAddr.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoStateIdentity_TxAddr clone() => ProtoStateIdentity_TxAddr()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoStateIdentity_TxAddr copyWith(void Function(ProtoStateIdentity_TxAddr) updates) => super.copyWith((message) => updates(message as ProtoStateIdentity_TxAddr)) as ProtoStateIdentity_TxAddr; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoStateIdentity_TxAddr create() => ProtoStateIdentity_TxAddr._();
  ProtoStateIdentity_TxAddr createEmptyInstance() => create();
  static $pb.PbList<ProtoStateIdentity_TxAddr> createRepeated() => $pb.PbList<ProtoStateIdentity_TxAddr>();
  @$core.pragma('dart2js:noInline')
  static ProtoStateIdentity_TxAddr getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoStateIdentity_TxAddr>(create);
  static ProtoStateIdentity_TxAddr? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get hash => $_getN(0);
  @$pb.TagNumber(1)
  set hash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get address => $_getN(1);
  @$pb.TagNumber(2)
  set address($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => clearField(2);
}

class ProtoStateIdentity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoStateIdentity', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stake', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invites', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'birthday', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qualifiedFlips', $pb.PbFieldType.OU3, protoName: 'qualifiedFlips')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shortFlipPoints', $pb.PbFieldType.OU3, protoName: 'shortFlipPoints')
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pubKey', $pb.PbFieldType.OY, protoName: 'pubKey')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiredFlips', $pb.PbFieldType.OU3, protoName: 'requiredFlips')
    ..pc<ProtoStateIdentity_Flip>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flips', $pb.PbFieldType.PM, subBuilder: ProtoStateIdentity_Flip.create)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generation', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.OY)
    ..pc<ProtoStateIdentity_TxAddr>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitees', $pb.PbFieldType.PM, subBuilder: ProtoStateIdentity_TxAddr.create)
    ..aOM<ProtoStateIdentity_TxAddr>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inviter', subBuilder: ProtoStateIdentity_TxAddr.create)
    ..a<$core.List<$core.int>>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'penalty', $pb.PbFieldType.OY)
    ..a<$core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationBits', $pb.PbFieldType.OU3, protoName: 'validationBits')
    ..a<$core.int>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationStatus', $pb.PbFieldType.OU3, protoName: 'validationStatus')
    ..a<$core.List<$core.int>>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profileHash', $pb.PbFieldType.OY, protoName: 'profileHash')
    ..a<$core.List<$core.int>>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scores', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoStateIdentity._() : super();
  factory ProtoStateIdentity({
    $core.List<$core.int>? stake,
    $core.int? invites,
    $core.int? birthday,
    $core.int? state,
    $core.int? qualifiedFlips,
    $core.int? shortFlipPoints,
    $core.List<$core.int>? pubKey,
    $core.int? requiredFlips,
    $core.Iterable<ProtoStateIdentity_Flip>? flips,
    $core.int? generation,
    $core.List<$core.int>? code,
    $core.Iterable<ProtoStateIdentity_TxAddr>? invitees,
    ProtoStateIdentity_TxAddr? inviter,
    $core.List<$core.int>? penalty,
    $core.int? validationBits,
    $core.int? validationStatus,
    $core.List<$core.int>? profileHash,
    $core.List<$core.int>? scores,
  }) {
    final _result = create();
    if (stake != null) {
      _result.stake = stake;
    }
    if (invites != null) {
      _result.invites = invites;
    }
    if (birthday != null) {
      _result.birthday = birthday;
    }
    if (state != null) {
      _result.state = state;
    }
    if (qualifiedFlips != null) {
      _result.qualifiedFlips = qualifiedFlips;
    }
    if (shortFlipPoints != null) {
      _result.shortFlipPoints = shortFlipPoints;
    }
    if (pubKey != null) {
      _result.pubKey = pubKey;
    }
    if (requiredFlips != null) {
      _result.requiredFlips = requiredFlips;
    }
    if (flips != null) {
      _result.flips.addAll(flips);
    }
    if (generation != null) {
      _result.generation = generation;
    }
    if (code != null) {
      _result.code = code;
    }
    if (invitees != null) {
      _result.invitees.addAll(invitees);
    }
    if (inviter != null) {
      _result.inviter = inviter;
    }
    if (penalty != null) {
      _result.penalty = penalty;
    }
    if (validationBits != null) {
      _result.validationBits = validationBits;
    }
    if (validationStatus != null) {
      _result.validationStatus = validationStatus;
    }
    if (profileHash != null) {
      _result.profileHash = profileHash;
    }
    if (scores != null) {
      _result.scores = scores;
    }
    return _result;
  }
  factory ProtoStateIdentity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoStateIdentity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoStateIdentity clone() => ProtoStateIdentity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoStateIdentity copyWith(void Function(ProtoStateIdentity) updates) => super.copyWith((message) => updates(message as ProtoStateIdentity)) as ProtoStateIdentity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoStateIdentity create() => ProtoStateIdentity._();
  ProtoStateIdentity createEmptyInstance() => create();
  static $pb.PbList<ProtoStateIdentity> createRepeated() => $pb.PbList<ProtoStateIdentity>();
  @$core.pragma('dart2js:noInline')
  static ProtoStateIdentity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoStateIdentity>(create);
  static ProtoStateIdentity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get stake => $_getN(0);
  @$pb.TagNumber(1)
  set stake($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStake() => $_has(0);
  @$pb.TagNumber(1)
  void clearStake() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get invites => $_getIZ(1);
  @$pb.TagNumber(2)
  set invites($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvites() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvites() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get birthday => $_getIZ(2);
  @$pb.TagNumber(3)
  set birthday($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBirthday() => $_has(2);
  @$pb.TagNumber(3)
  void clearBirthday() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get state => $_getIZ(3);
  @$pb.TagNumber(4)
  set state($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get qualifiedFlips => $_getIZ(4);
  @$pb.TagNumber(5)
  set qualifiedFlips($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQualifiedFlips() => $_has(4);
  @$pb.TagNumber(5)
  void clearQualifiedFlips() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get shortFlipPoints => $_getIZ(5);
  @$pb.TagNumber(6)
  set shortFlipPoints($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasShortFlipPoints() => $_has(5);
  @$pb.TagNumber(6)
  void clearShortFlipPoints() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get pubKey => $_getN(6);
  @$pb.TagNumber(7)
  set pubKey($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPubKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearPubKey() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get requiredFlips => $_getIZ(7);
  @$pb.TagNumber(8)
  set requiredFlips($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRequiredFlips() => $_has(7);
  @$pb.TagNumber(8)
  void clearRequiredFlips() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<ProtoStateIdentity_Flip> get flips => $_getList(8);

  @$pb.TagNumber(10)
  $core.int get generation => $_getIZ(9);
  @$pb.TagNumber(10)
  set generation($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasGeneration() => $_has(9);
  @$pb.TagNumber(10)
  void clearGeneration() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.int> get code => $_getN(10);
  @$pb.TagNumber(11)
  set code($core.List<$core.int> v) { $_setBytes(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCode() => $_has(10);
  @$pb.TagNumber(11)
  void clearCode() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<ProtoStateIdentity_TxAddr> get invitees => $_getList(11);

  @$pb.TagNumber(13)
  ProtoStateIdentity_TxAddr get inviter => $_getN(12);
  @$pb.TagNumber(13)
  set inviter(ProtoStateIdentity_TxAddr v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasInviter() => $_has(12);
  @$pb.TagNumber(13)
  void clearInviter() => clearField(13);
  @$pb.TagNumber(13)
  ProtoStateIdentity_TxAddr ensureInviter() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.List<$core.int> get penalty => $_getN(13);
  @$pb.TagNumber(14)
  set penalty($core.List<$core.int> v) { $_setBytes(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPenalty() => $_has(13);
  @$pb.TagNumber(14)
  void clearPenalty() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get validationBits => $_getIZ(14);
  @$pb.TagNumber(15)
  set validationBits($core.int v) { $_setUnsignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasValidationBits() => $_has(14);
  @$pb.TagNumber(15)
  void clearValidationBits() => clearField(15);

  @$pb.TagNumber(16)
  $core.int get validationStatus => $_getIZ(15);
  @$pb.TagNumber(16)
  set validationStatus($core.int v) { $_setUnsignedInt32(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasValidationStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearValidationStatus() => clearField(16);

  @$pb.TagNumber(17)
  $core.List<$core.int> get profileHash => $_getN(16);
  @$pb.TagNumber(17)
  set profileHash($core.List<$core.int> v) { $_setBytes(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasProfileHash() => $_has(16);
  @$pb.TagNumber(17)
  void clearProfileHash() => clearField(17);

  @$pb.TagNumber(18)
  $core.List<$core.int> get scores => $_getN(17);
  @$pb.TagNumber(18)
  set scores($core.List<$core.int> v) { $_setBytes(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasScores() => $_has(17);
  @$pb.TagNumber(18)
  void clearScores() => clearField(18);
}

class ProtoStateGlobal extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoStateGlobal', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epoch', $pb.PbFieldType.OU3)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextValidationTime', protoName: 'nextValidationTime')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationPeriod', $pb.PbFieldType.OU3, protoName: 'validationPeriod')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'godAddress', $pb.PbFieldType.OY, protoName: 'godAddress')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wordsSeed', $pb.PbFieldType.OY, protoName: 'wordsSeed')
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastSnapshot', $pb.PbFieldType.OU6, protoName: 'lastSnapshot', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epochBlock', $pb.PbFieldType.OU6, protoName: 'epochBlock', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePerGas', $pb.PbFieldType.OY, protoName: 'feePerGas')
    ..a<$fixnum.Int64>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vrfProposerThreshold', $pb.PbFieldType.OU6, protoName: 'vrfProposerThreshold', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emptyBlocksBits', $pb.PbFieldType.OY, protoName: 'emptyBlocksBits')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'godAddressInvites', $pb.PbFieldType.OU3, protoName: 'godAddressInvites')
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blocksCntWithoutCeremonialTxs', $pb.PbFieldType.OU3, protoName: 'blocksCntWithoutCeremonialTxs')
    ..hasRequiredFields = false
  ;

  ProtoStateGlobal._() : super();
  factory ProtoStateGlobal({
    $core.int? epoch,
    $fixnum.Int64? nextValidationTime,
    $core.int? validationPeriod,
    $core.List<$core.int>? godAddress,
    $core.List<$core.int>? wordsSeed,
    $fixnum.Int64? lastSnapshot,
    $fixnum.Int64? epochBlock,
    $core.List<$core.int>? feePerGas,
    $fixnum.Int64? vrfProposerThreshold,
    $core.List<$core.int>? emptyBlocksBits,
    $core.int? godAddressInvites,
    $core.int? blocksCntWithoutCeremonialTxs,
  }) {
    final _result = create();
    if (epoch != null) {
      _result.epoch = epoch;
    }
    if (nextValidationTime != null) {
      _result.nextValidationTime = nextValidationTime;
    }
    if (validationPeriod != null) {
      _result.validationPeriod = validationPeriod;
    }
    if (godAddress != null) {
      _result.godAddress = godAddress;
    }
    if (wordsSeed != null) {
      _result.wordsSeed = wordsSeed;
    }
    if (lastSnapshot != null) {
      _result.lastSnapshot = lastSnapshot;
    }
    if (epochBlock != null) {
      _result.epochBlock = epochBlock;
    }
    if (feePerGas != null) {
      _result.feePerGas = feePerGas;
    }
    if (vrfProposerThreshold != null) {
      _result.vrfProposerThreshold = vrfProposerThreshold;
    }
    if (emptyBlocksBits != null) {
      _result.emptyBlocksBits = emptyBlocksBits;
    }
    if (godAddressInvites != null) {
      _result.godAddressInvites = godAddressInvites;
    }
    if (blocksCntWithoutCeremonialTxs != null) {
      _result.blocksCntWithoutCeremonialTxs = blocksCntWithoutCeremonialTxs;
    }
    return _result;
  }
  factory ProtoStateGlobal.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoStateGlobal.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoStateGlobal clone() => ProtoStateGlobal()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoStateGlobal copyWith(void Function(ProtoStateGlobal) updates) => super.copyWith((message) => updates(message as ProtoStateGlobal)) as ProtoStateGlobal; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoStateGlobal create() => ProtoStateGlobal._();
  ProtoStateGlobal createEmptyInstance() => create();
  static $pb.PbList<ProtoStateGlobal> createRepeated() => $pb.PbList<ProtoStateGlobal>();
  @$core.pragma('dart2js:noInline')
  static ProtoStateGlobal getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoStateGlobal>(create);
  static ProtoStateGlobal? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get epoch => $_getIZ(0);
  @$pb.TagNumber(1)
  set epoch($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get nextValidationTime => $_getI64(1);
  @$pb.TagNumber(2)
  set nextValidationTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextValidationTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextValidationTime() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get validationPeriod => $_getIZ(2);
  @$pb.TagNumber(3)
  set validationPeriod($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValidationPeriod() => $_has(2);
  @$pb.TagNumber(3)
  void clearValidationPeriod() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get godAddress => $_getN(3);
  @$pb.TagNumber(4)
  set godAddress($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGodAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearGodAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get wordsSeed => $_getN(4);
  @$pb.TagNumber(5)
  set wordsSeed($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWordsSeed() => $_has(4);
  @$pb.TagNumber(5)
  void clearWordsSeed() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get lastSnapshot => $_getI64(5);
  @$pb.TagNumber(6)
  set lastSnapshot($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastSnapshot() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastSnapshot() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get epochBlock => $_getI64(6);
  @$pb.TagNumber(7)
  set epochBlock($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEpochBlock() => $_has(6);
  @$pb.TagNumber(7)
  void clearEpochBlock() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get feePerGas => $_getN(7);
  @$pb.TagNumber(8)
  set feePerGas($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFeePerGas() => $_has(7);
  @$pb.TagNumber(8)
  void clearFeePerGas() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get vrfProposerThreshold => $_getI64(8);
  @$pb.TagNumber(9)
  set vrfProposerThreshold($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasVrfProposerThreshold() => $_has(8);
  @$pb.TagNumber(9)
  void clearVrfProposerThreshold() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.int> get emptyBlocksBits => $_getN(9);
  @$pb.TagNumber(10)
  set emptyBlocksBits($core.List<$core.int> v) { $_setBytes(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasEmptyBlocksBits() => $_has(9);
  @$pb.TagNumber(10)
  void clearEmptyBlocksBits() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get godAddressInvites => $_getIZ(10);
  @$pb.TagNumber(11)
  set godAddressInvites($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasGodAddressInvites() => $_has(10);
  @$pb.TagNumber(11)
  void clearGodAddressInvites() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get blocksCntWithoutCeremonialTxs => $_getIZ(11);
  @$pb.TagNumber(12)
  set blocksCntWithoutCeremonialTxs($core.int v) { $_setUnsignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBlocksCntWithoutCeremonialTxs() => $_has(11);
  @$pb.TagNumber(12)
  void clearBlocksCntWithoutCeremonialTxs() => clearField(12);
}

class ProtoStateApprovedIdentity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoStateApprovedIdentity', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approved')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'online')
    ..hasRequiredFields = false
  ;

  ProtoStateApprovedIdentity._() : super();
  factory ProtoStateApprovedIdentity({
    $core.bool? approved,
    $core.bool? online,
  }) {
    final _result = create();
    if (approved != null) {
      _result.approved = approved;
    }
    if (online != null) {
      _result.online = online;
    }
    return _result;
  }
  factory ProtoStateApprovedIdentity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoStateApprovedIdentity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoStateApprovedIdentity clone() => ProtoStateApprovedIdentity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoStateApprovedIdentity copyWith(void Function(ProtoStateApprovedIdentity) updates) => super.copyWith((message) => updates(message as ProtoStateApprovedIdentity)) as ProtoStateApprovedIdentity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoStateApprovedIdentity create() => ProtoStateApprovedIdentity._();
  ProtoStateApprovedIdentity createEmptyInstance() => create();
  static $pb.PbList<ProtoStateApprovedIdentity> createRepeated() => $pb.PbList<ProtoStateApprovedIdentity>();
  @$core.pragma('dart2js:noInline')
  static ProtoStateApprovedIdentity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoStateApprovedIdentity>(create);
  static ProtoStateApprovedIdentity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get approved => $_getBF(0);
  @$pb.TagNumber(1)
  set approved($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasApproved() => $_has(0);
  @$pb.TagNumber(1)
  void clearApproved() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get online => $_getBF(1);
  @$pb.TagNumber(2)
  set online($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOnline() => $_has(1);
  @$pb.TagNumber(2)
  void clearOnline() => clearField(2);
}

class ProtoStateIdentityStatusSwitch extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoStateIdentityStatusSwitch', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addresses', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoStateIdentityStatusSwitch._() : super();
  factory ProtoStateIdentityStatusSwitch({
    $core.Iterable<$core.List<$core.int>>? addresses,
  }) {
    final _result = create();
    if (addresses != null) {
      _result.addresses.addAll(addresses);
    }
    return _result;
  }
  factory ProtoStateIdentityStatusSwitch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoStateIdentityStatusSwitch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoStateIdentityStatusSwitch clone() => ProtoStateIdentityStatusSwitch()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoStateIdentityStatusSwitch copyWith(void Function(ProtoStateIdentityStatusSwitch) updates) => super.copyWith((message) => updates(message as ProtoStateIdentityStatusSwitch)) as ProtoStateIdentityStatusSwitch; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoStateIdentityStatusSwitch create() => ProtoStateIdentityStatusSwitch._();
  ProtoStateIdentityStatusSwitch createEmptyInstance() => create();
  static $pb.PbList<ProtoStateIdentityStatusSwitch> createRepeated() => $pb.PbList<ProtoStateIdentityStatusSwitch>();
  @$core.pragma('dart2js:noInline')
  static ProtoStateIdentityStatusSwitch getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoStateIdentityStatusSwitch>(create);
  static ProtoStateIdentityStatusSwitch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.List<$core.int>> get addresses => $_getList(0);
}

class ProtoPredefinedState_Global extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.Global', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epoch', $pb.PbFieldType.OU3)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextValidationTime', protoName: 'nextValidationTime')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationPeriod', $pb.PbFieldType.OU3, protoName: 'validationPeriod')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'godAddress', $pb.PbFieldType.OY, protoName: 'godAddress')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wordsSeed', $pb.PbFieldType.OY, protoName: 'wordsSeed')
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastSnapshot', $pb.PbFieldType.OU6, protoName: 'lastSnapshot', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epochBlock', $pb.PbFieldType.OU6, protoName: 'epochBlock', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePerGas', $pb.PbFieldType.OY, protoName: 'feePerGas')
    ..a<$fixnum.Int64>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vrfProposerThreshold', $pb.PbFieldType.OU6, protoName: 'vrfProposerThreshold', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emptyBlocksBits', $pb.PbFieldType.OY, protoName: 'emptyBlocksBits')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'godAddressInvites', $pb.PbFieldType.OU3, protoName: 'godAddressInvites')
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blocksCntWithoutCeremonialTxs', $pb.PbFieldType.OU3, protoName: 'blocksCntWithoutCeremonialTxs')
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_Global._() : super();
  factory ProtoPredefinedState_Global({
    $core.int? epoch,
    $fixnum.Int64? nextValidationTime,
    $core.int? validationPeriod,
    $core.List<$core.int>? godAddress,
    $core.List<$core.int>? wordsSeed,
    $fixnum.Int64? lastSnapshot,
    $fixnum.Int64? epochBlock,
    $core.List<$core.int>? feePerGas,
    $fixnum.Int64? vrfProposerThreshold,
    $core.List<$core.int>? emptyBlocksBits,
    $core.int? godAddressInvites,
    $core.int? blocksCntWithoutCeremonialTxs,
  }) {
    final _result = create();
    if (epoch != null) {
      _result.epoch = epoch;
    }
    if (nextValidationTime != null) {
      _result.nextValidationTime = nextValidationTime;
    }
    if (validationPeriod != null) {
      _result.validationPeriod = validationPeriod;
    }
    if (godAddress != null) {
      _result.godAddress = godAddress;
    }
    if (wordsSeed != null) {
      _result.wordsSeed = wordsSeed;
    }
    if (lastSnapshot != null) {
      _result.lastSnapshot = lastSnapshot;
    }
    if (epochBlock != null) {
      _result.epochBlock = epochBlock;
    }
    if (feePerGas != null) {
      _result.feePerGas = feePerGas;
    }
    if (vrfProposerThreshold != null) {
      _result.vrfProposerThreshold = vrfProposerThreshold;
    }
    if (emptyBlocksBits != null) {
      _result.emptyBlocksBits = emptyBlocksBits;
    }
    if (godAddressInvites != null) {
      _result.godAddressInvites = godAddressInvites;
    }
    if (blocksCntWithoutCeremonialTxs != null) {
      _result.blocksCntWithoutCeremonialTxs = blocksCntWithoutCeremonialTxs;
    }
    return _result;
  }
  factory ProtoPredefinedState_Global.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_Global.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Global clone() => ProtoPredefinedState_Global()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Global copyWith(void Function(ProtoPredefinedState_Global) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_Global)) as ProtoPredefinedState_Global; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Global create() => ProtoPredefinedState_Global._();
  ProtoPredefinedState_Global createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_Global> createRepeated() => $pb.PbList<ProtoPredefinedState_Global>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Global getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_Global>(create);
  static ProtoPredefinedState_Global? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get epoch => $_getIZ(0);
  @$pb.TagNumber(1)
  set epoch($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get nextValidationTime => $_getI64(1);
  @$pb.TagNumber(2)
  set nextValidationTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextValidationTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextValidationTime() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get validationPeriod => $_getIZ(2);
  @$pb.TagNumber(3)
  set validationPeriod($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValidationPeriod() => $_has(2);
  @$pb.TagNumber(3)
  void clearValidationPeriod() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get godAddress => $_getN(3);
  @$pb.TagNumber(4)
  set godAddress($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGodAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearGodAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get wordsSeed => $_getN(4);
  @$pb.TagNumber(5)
  set wordsSeed($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWordsSeed() => $_has(4);
  @$pb.TagNumber(5)
  void clearWordsSeed() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get lastSnapshot => $_getI64(5);
  @$pb.TagNumber(6)
  set lastSnapshot($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastSnapshot() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastSnapshot() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get epochBlock => $_getI64(6);
  @$pb.TagNumber(7)
  set epochBlock($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEpochBlock() => $_has(6);
  @$pb.TagNumber(7)
  void clearEpochBlock() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get feePerGas => $_getN(7);
  @$pb.TagNumber(8)
  set feePerGas($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFeePerGas() => $_has(7);
  @$pb.TagNumber(8)
  void clearFeePerGas() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get vrfProposerThreshold => $_getI64(8);
  @$pb.TagNumber(9)
  set vrfProposerThreshold($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasVrfProposerThreshold() => $_has(8);
  @$pb.TagNumber(9)
  void clearVrfProposerThreshold() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.int> get emptyBlocksBits => $_getN(9);
  @$pb.TagNumber(10)
  set emptyBlocksBits($core.List<$core.int> v) { $_setBytes(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasEmptyBlocksBits() => $_has(9);
  @$pb.TagNumber(10)
  void clearEmptyBlocksBits() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get godAddressInvites => $_getIZ(10);
  @$pb.TagNumber(11)
  set godAddressInvites($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasGodAddressInvites() => $_has(10);
  @$pb.TagNumber(11)
  void clearGodAddressInvites() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get blocksCntWithoutCeremonialTxs => $_getIZ(11);
  @$pb.TagNumber(12)
  set blocksCntWithoutCeremonialTxs($core.int v) { $_setUnsignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBlocksCntWithoutCeremonialTxs() => $_has(11);
  @$pb.TagNumber(12)
  void clearBlocksCntWithoutCeremonialTxs() => clearField(12);
}

class ProtoPredefinedState_StatusSwitch extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.StatusSwitch', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addresses', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_StatusSwitch._() : super();
  factory ProtoPredefinedState_StatusSwitch({
    $core.Iterable<$core.List<$core.int>>? addresses,
  }) {
    final _result = create();
    if (addresses != null) {
      _result.addresses.addAll(addresses);
    }
    return _result;
  }
  factory ProtoPredefinedState_StatusSwitch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_StatusSwitch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_StatusSwitch clone() => ProtoPredefinedState_StatusSwitch()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_StatusSwitch copyWith(void Function(ProtoPredefinedState_StatusSwitch) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_StatusSwitch)) as ProtoPredefinedState_StatusSwitch; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_StatusSwitch create() => ProtoPredefinedState_StatusSwitch._();
  ProtoPredefinedState_StatusSwitch createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_StatusSwitch> createRepeated() => $pb.PbList<ProtoPredefinedState_StatusSwitch>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_StatusSwitch getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_StatusSwitch>(create);
  static ProtoPredefinedState_StatusSwitch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.List<$core.int>> get addresses => $_getList(0);
}

class ProtoPredefinedState_Account_ContractData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.Account.ContractData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'codeHash', $pb.PbFieldType.OY, protoName: 'codeHash')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stake', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_Account_ContractData._() : super();
  factory ProtoPredefinedState_Account_ContractData({
    $core.List<$core.int>? codeHash,
    $core.List<$core.int>? stake,
  }) {
    final _result = create();
    if (codeHash != null) {
      _result.codeHash = codeHash;
    }
    if (stake != null) {
      _result.stake = stake;
    }
    return _result;
  }
  factory ProtoPredefinedState_Account_ContractData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_Account_ContractData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Account_ContractData clone() => ProtoPredefinedState_Account_ContractData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Account_ContractData copyWith(void Function(ProtoPredefinedState_Account_ContractData) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_Account_ContractData)) as ProtoPredefinedState_Account_ContractData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Account_ContractData create() => ProtoPredefinedState_Account_ContractData._();
  ProtoPredefinedState_Account_ContractData createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_Account_ContractData> createRepeated() => $pb.PbList<ProtoPredefinedState_Account_ContractData>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Account_ContractData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_Account_ContractData>(create);
  static ProtoPredefinedState_Account_ContractData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get codeHash => $_getN(0);
  @$pb.TagNumber(1)
  set codeHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCodeHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearCodeHash() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get stake => $_getN(1);
  @$pb.TagNumber(2)
  set stake($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStake() => $_has(1);
  @$pb.TagNumber(2)
  void clearStake() => clearField(2);
}

class ProtoPredefinedState_Account extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.Account', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nonce', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epoch', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OY)
    ..aOM<ProtoPredefinedState_Account_ContractData>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contractData', protoName: 'contractData', subBuilder: ProtoPredefinedState_Account_ContractData.create)
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_Account._() : super();
  factory ProtoPredefinedState_Account({
    $core.List<$core.int>? address,
    $core.int? nonce,
    $core.int? epoch,
    $core.List<$core.int>? balance,
    ProtoPredefinedState_Account_ContractData? contractData,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (nonce != null) {
      _result.nonce = nonce;
    }
    if (epoch != null) {
      _result.epoch = epoch;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (contractData != null) {
      _result.contractData = contractData;
    }
    return _result;
  }
  factory ProtoPredefinedState_Account.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_Account.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Account clone() => ProtoPredefinedState_Account()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Account copyWith(void Function(ProtoPredefinedState_Account) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_Account)) as ProtoPredefinedState_Account; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Account create() => ProtoPredefinedState_Account._();
  ProtoPredefinedState_Account createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_Account> createRepeated() => $pb.PbList<ProtoPredefinedState_Account>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Account getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_Account>(create);
  static ProtoPredefinedState_Account? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get address => $_getN(0);
  @$pb.TagNumber(1)
  set address($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get nonce => $_getIZ(1);
  @$pb.TagNumber(2)
  set nonce($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNonce() => $_has(1);
  @$pb.TagNumber(2)
  void clearNonce() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get epoch => $_getIZ(2);
  @$pb.TagNumber(3)
  set epoch($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEpoch() => $_has(2);
  @$pb.TagNumber(3)
  void clearEpoch() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get balance => $_getN(3);
  @$pb.TagNumber(4)
  set balance($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearBalance() => clearField(4);

  @$pb.TagNumber(5)
  ProtoPredefinedState_Account_ContractData get contractData => $_getN(4);
  @$pb.TagNumber(5)
  set contractData(ProtoPredefinedState_Account_ContractData v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasContractData() => $_has(4);
  @$pb.TagNumber(5)
  void clearContractData() => clearField(5);
  @$pb.TagNumber(5)
  ProtoPredefinedState_Account_ContractData ensureContractData() => $_ensure(4);
}

class ProtoPredefinedState_Identity_Flip extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.Identity.Flip', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cid', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pair', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_Identity_Flip._() : super();
  factory ProtoPredefinedState_Identity_Flip({
    $core.List<$core.int>? cid,
    $core.int? pair,
  }) {
    final _result = create();
    if (cid != null) {
      _result.cid = cid;
    }
    if (pair != null) {
      _result.pair = pair;
    }
    return _result;
  }
  factory ProtoPredefinedState_Identity_Flip.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_Identity_Flip.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Identity_Flip clone() => ProtoPredefinedState_Identity_Flip()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Identity_Flip copyWith(void Function(ProtoPredefinedState_Identity_Flip) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_Identity_Flip)) as ProtoPredefinedState_Identity_Flip; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Identity_Flip create() => ProtoPredefinedState_Identity_Flip._();
  ProtoPredefinedState_Identity_Flip createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_Identity_Flip> createRepeated() => $pb.PbList<ProtoPredefinedState_Identity_Flip>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Identity_Flip getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_Identity_Flip>(create);
  static ProtoPredefinedState_Identity_Flip? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get cid => $_getN(0);
  @$pb.TagNumber(1)
  set cid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCid() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pair => $_getIZ(1);
  @$pb.TagNumber(2)
  set pair($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPair() => $_has(1);
  @$pb.TagNumber(2)
  void clearPair() => clearField(2);
}

class ProtoPredefinedState_Identity_TxAddr extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.Identity.TxAddr', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_Identity_TxAddr._() : super();
  factory ProtoPredefinedState_Identity_TxAddr({
    $core.List<$core.int>? hash,
    $core.List<$core.int>? address,
  }) {
    final _result = create();
    if (hash != null) {
      _result.hash = hash;
    }
    if (address != null) {
      _result.address = address;
    }
    return _result;
  }
  factory ProtoPredefinedState_Identity_TxAddr.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_Identity_TxAddr.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Identity_TxAddr clone() => ProtoPredefinedState_Identity_TxAddr()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Identity_TxAddr copyWith(void Function(ProtoPredefinedState_Identity_TxAddr) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_Identity_TxAddr)) as ProtoPredefinedState_Identity_TxAddr; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Identity_TxAddr create() => ProtoPredefinedState_Identity_TxAddr._();
  ProtoPredefinedState_Identity_TxAddr createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_Identity_TxAddr> createRepeated() => $pb.PbList<ProtoPredefinedState_Identity_TxAddr>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Identity_TxAddr getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_Identity_TxAddr>(create);
  static ProtoPredefinedState_Identity_TxAddr? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get hash => $_getN(0);
  @$pb.TagNumber(1)
  set hash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get address => $_getN(1);
  @$pb.TagNumber(2)
  set address($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => clearField(2);
}

class ProtoPredefinedState_Identity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.Identity', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stake', $pb.PbFieldType.OY)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invites', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'birthday', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qualifiedFlips', $pb.PbFieldType.OU3, protoName: 'qualifiedFlips')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shortFlipPoints', $pb.PbFieldType.OU3, protoName: 'shortFlipPoints')
    ..a<$core.List<$core.int>>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pubKey', $pb.PbFieldType.OY, protoName: 'pubKey')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiredFlips', $pb.PbFieldType.OU3, protoName: 'requiredFlips')
    ..pc<ProtoPredefinedState_Identity_Flip>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flips', $pb.PbFieldType.PM, subBuilder: ProtoPredefinedState_Identity_Flip.create)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generation', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.OY)
    ..pc<ProtoPredefinedState_Identity_TxAddr>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invitees', $pb.PbFieldType.PM, subBuilder: ProtoPredefinedState_Identity_TxAddr.create)
    ..aOM<ProtoPredefinedState_Identity_TxAddr>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inviter', subBuilder: ProtoPredefinedState_Identity_TxAddr.create)
    ..a<$core.List<$core.int>>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'penalty', $pb.PbFieldType.OY)
    ..a<$core.int>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationBits', $pb.PbFieldType.OU3, protoName: 'validationBits')
    ..a<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationStatus', $pb.PbFieldType.OU3, protoName: 'validationStatus')
    ..a<$core.List<$core.int>>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profileHash', $pb.PbFieldType.OY, protoName: 'profileHash')
    ..a<$core.List<$core.int>>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scores', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_Identity._() : super();
  factory ProtoPredefinedState_Identity({
    $core.List<$core.int>? address,
    $core.List<$core.int>? stake,
    $core.int? invites,
    $core.int? birthday,
    $core.int? state,
    $core.int? qualifiedFlips,
    $core.int? shortFlipPoints,
    $core.List<$core.int>? pubKey,
    $core.int? requiredFlips,
    $core.Iterable<ProtoPredefinedState_Identity_Flip>? flips,
    $core.int? generation,
    $core.List<$core.int>? code,
    $core.Iterable<ProtoPredefinedState_Identity_TxAddr>? invitees,
    ProtoPredefinedState_Identity_TxAddr? inviter,
    $core.List<$core.int>? penalty,
    $core.int? validationBits,
    $core.int? validationStatus,
    $core.List<$core.int>? profileHash,
    $core.List<$core.int>? scores,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (stake != null) {
      _result.stake = stake;
    }
    if (invites != null) {
      _result.invites = invites;
    }
    if (birthday != null) {
      _result.birthday = birthday;
    }
    if (state != null) {
      _result.state = state;
    }
    if (qualifiedFlips != null) {
      _result.qualifiedFlips = qualifiedFlips;
    }
    if (shortFlipPoints != null) {
      _result.shortFlipPoints = shortFlipPoints;
    }
    if (pubKey != null) {
      _result.pubKey = pubKey;
    }
    if (requiredFlips != null) {
      _result.requiredFlips = requiredFlips;
    }
    if (flips != null) {
      _result.flips.addAll(flips);
    }
    if (generation != null) {
      _result.generation = generation;
    }
    if (code != null) {
      _result.code = code;
    }
    if (invitees != null) {
      _result.invitees.addAll(invitees);
    }
    if (inviter != null) {
      _result.inviter = inviter;
    }
    if (penalty != null) {
      _result.penalty = penalty;
    }
    if (validationBits != null) {
      _result.validationBits = validationBits;
    }
    if (validationStatus != null) {
      _result.validationStatus = validationStatus;
    }
    if (profileHash != null) {
      _result.profileHash = profileHash;
    }
    if (scores != null) {
      _result.scores = scores;
    }
    return _result;
  }
  factory ProtoPredefinedState_Identity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_Identity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Identity clone() => ProtoPredefinedState_Identity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_Identity copyWith(void Function(ProtoPredefinedState_Identity) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_Identity)) as ProtoPredefinedState_Identity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Identity create() => ProtoPredefinedState_Identity._();
  ProtoPredefinedState_Identity createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_Identity> createRepeated() => $pb.PbList<ProtoPredefinedState_Identity>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_Identity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_Identity>(create);
  static ProtoPredefinedState_Identity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get address => $_getN(0);
  @$pb.TagNumber(1)
  set address($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get stake => $_getN(1);
  @$pb.TagNumber(2)
  set stake($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStake() => $_has(1);
  @$pb.TagNumber(2)
  void clearStake() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get invites => $_getIZ(2);
  @$pb.TagNumber(3)
  set invites($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInvites() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvites() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get birthday => $_getIZ(3);
  @$pb.TagNumber(4)
  set birthday($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBirthday() => $_has(3);
  @$pb.TagNumber(4)
  void clearBirthday() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get state => $_getIZ(4);
  @$pb.TagNumber(5)
  set state($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasState() => $_has(4);
  @$pb.TagNumber(5)
  void clearState() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get qualifiedFlips => $_getIZ(5);
  @$pb.TagNumber(6)
  set qualifiedFlips($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasQualifiedFlips() => $_has(5);
  @$pb.TagNumber(6)
  void clearQualifiedFlips() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get shortFlipPoints => $_getIZ(6);
  @$pb.TagNumber(7)
  set shortFlipPoints($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasShortFlipPoints() => $_has(6);
  @$pb.TagNumber(7)
  void clearShortFlipPoints() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get pubKey => $_getN(7);
  @$pb.TagNumber(8)
  set pubKey($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPubKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearPubKey() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get requiredFlips => $_getIZ(8);
  @$pb.TagNumber(9)
  set requiredFlips($core.int v) { $_setUnsignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRequiredFlips() => $_has(8);
  @$pb.TagNumber(9)
  void clearRequiredFlips() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<ProtoPredefinedState_Identity_Flip> get flips => $_getList(9);

  @$pb.TagNumber(11)
  $core.int get generation => $_getIZ(10);
  @$pb.TagNumber(11)
  set generation($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasGeneration() => $_has(10);
  @$pb.TagNumber(11)
  void clearGeneration() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.int> get code => $_getN(11);
  @$pb.TagNumber(12)
  set code($core.List<$core.int> v) { $_setBytes(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearCode() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<ProtoPredefinedState_Identity_TxAddr> get invitees => $_getList(12);

  @$pb.TagNumber(14)
  ProtoPredefinedState_Identity_TxAddr get inviter => $_getN(13);
  @$pb.TagNumber(14)
  set inviter(ProtoPredefinedState_Identity_TxAddr v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasInviter() => $_has(13);
  @$pb.TagNumber(14)
  void clearInviter() => clearField(14);
  @$pb.TagNumber(14)
  ProtoPredefinedState_Identity_TxAddr ensureInviter() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.List<$core.int> get penalty => $_getN(14);
  @$pb.TagNumber(15)
  set penalty($core.List<$core.int> v) { $_setBytes(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasPenalty() => $_has(14);
  @$pb.TagNumber(15)
  void clearPenalty() => clearField(15);

  @$pb.TagNumber(16)
  $core.int get validationBits => $_getIZ(15);
  @$pb.TagNumber(16)
  set validationBits($core.int v) { $_setUnsignedInt32(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasValidationBits() => $_has(15);
  @$pb.TagNumber(16)
  void clearValidationBits() => clearField(16);

  @$pb.TagNumber(17)
  $core.int get validationStatus => $_getIZ(16);
  @$pb.TagNumber(17)
  set validationStatus($core.int v) { $_setUnsignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasValidationStatus() => $_has(16);
  @$pb.TagNumber(17)
  void clearValidationStatus() => clearField(17);

  @$pb.TagNumber(18)
  $core.List<$core.int> get profileHash => $_getN(17);
  @$pb.TagNumber(18)
  set profileHash($core.List<$core.int> v) { $_setBytes(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasProfileHash() => $_has(17);
  @$pb.TagNumber(18)
  void clearProfileHash() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<$core.int> get scores => $_getN(18);
  @$pb.TagNumber(19)
  set scores($core.List<$core.int> v) { $_setBytes(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasScores() => $_has(18);
  @$pb.TagNumber(19)
  void clearScores() => clearField(19);
}

class ProtoPredefinedState_ApprovedIdentity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.ApprovedIdentity', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OY)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approved')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'online')
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_ApprovedIdentity._() : super();
  factory ProtoPredefinedState_ApprovedIdentity({
    $core.List<$core.int>? address,
    $core.bool? approved,
    $core.bool? online,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (approved != null) {
      _result.approved = approved;
    }
    if (online != null) {
      _result.online = online;
    }
    return _result;
  }
  factory ProtoPredefinedState_ApprovedIdentity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_ApprovedIdentity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_ApprovedIdentity clone() => ProtoPredefinedState_ApprovedIdentity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_ApprovedIdentity copyWith(void Function(ProtoPredefinedState_ApprovedIdentity) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_ApprovedIdentity)) as ProtoPredefinedState_ApprovedIdentity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_ApprovedIdentity create() => ProtoPredefinedState_ApprovedIdentity._();
  ProtoPredefinedState_ApprovedIdentity createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_ApprovedIdentity> createRepeated() => $pb.PbList<ProtoPredefinedState_ApprovedIdentity>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_ApprovedIdentity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_ApprovedIdentity>(create);
  static ProtoPredefinedState_ApprovedIdentity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get address => $_getN(0);
  @$pb.TagNumber(1)
  set address($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get approved => $_getBF(1);
  @$pb.TagNumber(2)
  set approved($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasApproved() => $_has(1);
  @$pb.TagNumber(2)
  void clearApproved() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get online => $_getBF(2);
  @$pb.TagNumber(3)
  set online($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOnline() => $_has(2);
  @$pb.TagNumber(3)
  void clearOnline() => clearField(3);
}

class ProtoPredefinedState_ContractKeyValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState.ContractKeyValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState_ContractKeyValue._() : super();
  factory ProtoPredefinedState_ContractKeyValue({
    $core.List<$core.int>? key,
    $core.List<$core.int>? value,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ProtoPredefinedState_ContractKeyValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState_ContractKeyValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_ContractKeyValue clone() => ProtoPredefinedState_ContractKeyValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState_ContractKeyValue copyWith(void Function(ProtoPredefinedState_ContractKeyValue) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState_ContractKeyValue)) as ProtoPredefinedState_ContractKeyValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_ContractKeyValue create() => ProtoPredefinedState_ContractKeyValue._();
  ProtoPredefinedState_ContractKeyValue createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState_ContractKeyValue> createRepeated() => $pb.PbList<ProtoPredefinedState_ContractKeyValue>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState_ContractKeyValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState_ContractKeyValue>(create);
  static ProtoPredefinedState_ContractKeyValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get key => $_getN(0);
  @$pb.TagNumber(1)
  set key($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class ProtoPredefinedState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPredefinedState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'block', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'seed', $pb.PbFieldType.OY)
    ..aOM<ProtoPredefinedState_Global>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'global', subBuilder: ProtoPredefinedState_Global.create)
    ..aOM<ProtoPredefinedState_StatusSwitch>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusSwitch', protoName: 'statusSwitch', subBuilder: ProtoPredefinedState_StatusSwitch.create)
    ..pc<ProtoPredefinedState_Account>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: ProtoPredefinedState_Account.create)
    ..pc<ProtoPredefinedState_Identity>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identities', $pb.PbFieldType.PM, subBuilder: ProtoPredefinedState_Identity.create)
    ..pc<ProtoPredefinedState_ApprovedIdentity>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedIdentities', $pb.PbFieldType.PM, protoName: 'approvedIdentities', subBuilder: ProtoPredefinedState_ApprovedIdentity.create)
    ..pc<ProtoPredefinedState_ContractKeyValue>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contractValues', $pb.PbFieldType.PM, protoName: 'contractValues', subBuilder: ProtoPredefinedState_ContractKeyValue.create)
    ..hasRequiredFields = false
  ;

  ProtoPredefinedState._() : super();
  factory ProtoPredefinedState({
    $fixnum.Int64? block,
    $core.List<$core.int>? seed,
    ProtoPredefinedState_Global? global,
    ProtoPredefinedState_StatusSwitch? statusSwitch,
    $core.Iterable<ProtoPredefinedState_Account>? accounts,
    $core.Iterable<ProtoPredefinedState_Identity>? identities,
    $core.Iterable<ProtoPredefinedState_ApprovedIdentity>? approvedIdentities,
    $core.Iterable<ProtoPredefinedState_ContractKeyValue>? contractValues,
  }) {
    final _result = create();
    if (block != null) {
      _result.block = block;
    }
    if (seed != null) {
      _result.seed = seed;
    }
    if (global != null) {
      _result.global = global;
    }
    if (statusSwitch != null) {
      _result.statusSwitch = statusSwitch;
    }
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    if (identities != null) {
      _result.identities.addAll(identities);
    }
    if (approvedIdentities != null) {
      _result.approvedIdentities.addAll(approvedIdentities);
    }
    if (contractValues != null) {
      _result.contractValues.addAll(contractValues);
    }
    return _result;
  }
  factory ProtoPredefinedState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPredefinedState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState clone() => ProtoPredefinedState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPredefinedState copyWith(void Function(ProtoPredefinedState) updates) => super.copyWith((message) => updates(message as ProtoPredefinedState)) as ProtoPredefinedState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState create() => ProtoPredefinedState._();
  ProtoPredefinedState createEmptyInstance() => create();
  static $pb.PbList<ProtoPredefinedState> createRepeated() => $pb.PbList<ProtoPredefinedState>();
  @$core.pragma('dart2js:noInline')
  static ProtoPredefinedState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPredefinedState>(create);
  static ProtoPredefinedState? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get block => $_getI64(0);
  @$pb.TagNumber(1)
  set block($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlock() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlock() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get seed => $_getN(1);
  @$pb.TagNumber(2)
  set seed($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSeed() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeed() => clearField(2);

  @$pb.TagNumber(3)
  ProtoPredefinedState_Global get global => $_getN(2);
  @$pb.TagNumber(3)
  set global(ProtoPredefinedState_Global v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGlobal() => $_has(2);
  @$pb.TagNumber(3)
  void clearGlobal() => clearField(3);
  @$pb.TagNumber(3)
  ProtoPredefinedState_Global ensureGlobal() => $_ensure(2);

  @$pb.TagNumber(4)
  ProtoPredefinedState_StatusSwitch get statusSwitch => $_getN(3);
  @$pb.TagNumber(4)
  set statusSwitch(ProtoPredefinedState_StatusSwitch v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatusSwitch() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatusSwitch() => clearField(4);
  @$pb.TagNumber(4)
  ProtoPredefinedState_StatusSwitch ensureStatusSwitch() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.List<ProtoPredefinedState_Account> get accounts => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<ProtoPredefinedState_Identity> get identities => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<ProtoPredefinedState_ApprovedIdentity> get approvedIdentities => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<ProtoPredefinedState_ContractKeyValue> get contractValues => $_getList(7);
}

class ProtoCallContractAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoCallContractAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method')
    ..p<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'args', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoCallContractAttachment._() : super();
  factory ProtoCallContractAttachment({
    $core.String? method,
    $core.Iterable<$core.List<$core.int>>? args,
  }) {
    final _result = create();
    if (method != null) {
      _result.method = method;
    }
    if (args != null) {
      _result.args.addAll(args);
    }
    return _result;
  }
  factory ProtoCallContractAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoCallContractAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoCallContractAttachment clone() => ProtoCallContractAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoCallContractAttachment copyWith(void Function(ProtoCallContractAttachment) updates) => super.copyWith((message) => updates(message as ProtoCallContractAttachment)) as ProtoCallContractAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoCallContractAttachment create() => ProtoCallContractAttachment._();
  ProtoCallContractAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoCallContractAttachment> createRepeated() => $pb.PbList<ProtoCallContractAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoCallContractAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoCallContractAttachment>(create);
  static ProtoCallContractAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.List<$core.int>> get args => $_getList(1);
}

class ProtoDeployContractAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoDeployContractAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CodeHash', $pb.PbFieldType.OY, protoName: 'CodeHash')
    ..p<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'args', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoDeployContractAttachment._() : super();
  factory ProtoDeployContractAttachment({
    $core.List<$core.int>? codeHash,
    $core.Iterable<$core.List<$core.int>>? args,
  }) {
    final _result = create();
    if (codeHash != null) {
      _result.codeHash = codeHash;
    }
    if (args != null) {
      _result.args.addAll(args);
    }
    return _result;
  }
  factory ProtoDeployContractAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoDeployContractAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoDeployContractAttachment clone() => ProtoDeployContractAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoDeployContractAttachment copyWith(void Function(ProtoDeployContractAttachment) updates) => super.copyWith((message) => updates(message as ProtoDeployContractAttachment)) as ProtoDeployContractAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoDeployContractAttachment create() => ProtoDeployContractAttachment._();
  ProtoDeployContractAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoDeployContractAttachment> createRepeated() => $pb.PbList<ProtoDeployContractAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoDeployContractAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoDeployContractAttachment>(create);
  static ProtoDeployContractAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get codeHash => $_getN(0);
  @$pb.TagNumber(1)
  set codeHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCodeHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearCodeHash() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.List<$core.int>> get args => $_getList(1);
}

class ProtoTerminateContractAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoTerminateContractAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'args', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoTerminateContractAttachment._() : super();
  factory ProtoTerminateContractAttachment({
    $core.Iterable<$core.List<$core.int>>? args,
  }) {
    final _result = create();
    if (args != null) {
      _result.args.addAll(args);
    }
    return _result;
  }
  factory ProtoTerminateContractAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoTerminateContractAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoTerminateContractAttachment clone() => ProtoTerminateContractAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoTerminateContractAttachment copyWith(void Function(ProtoTerminateContractAttachment) updates) => super.copyWith((message) => updates(message as ProtoTerminateContractAttachment)) as ProtoTerminateContractAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTerminateContractAttachment create() => ProtoTerminateContractAttachment._();
  ProtoTerminateContractAttachment createEmptyInstance() => create();
  static $pb.PbList<ProtoTerminateContractAttachment> createRepeated() => $pb.PbList<ProtoTerminateContractAttachment>();
  @$core.pragma('dart2js:noInline')
  static ProtoTerminateContractAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTerminateContractAttachment>(create);
  static ProtoTerminateContractAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.List<$core.int>> get args => $_getList(0);
}

class ProtoTxReceipts_ProtoTxReceipt extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoTxReceipts.ProtoTxReceipt', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contract', $pb.PbFieldType.OY)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gasUsed', $pb.PbFieldType.OU6, protoName: 'gasUsed', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from', $pb.PbFieldType.OY)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error')
    ..a<$core.List<$core.int>>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gasCost', $pb.PbFieldType.OY, protoName: 'gasCost')
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txHash', $pb.PbFieldType.OY, protoName: 'txHash')
    ..pc<ProtoTxReceipts_ProtoEvent>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'events', $pb.PbFieldType.PM, subBuilder: ProtoTxReceipts_ProtoEvent.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method')
    ..hasRequiredFields = false
  ;

  ProtoTxReceipts_ProtoTxReceipt._() : super();
  factory ProtoTxReceipts_ProtoTxReceipt({
    $core.List<$core.int>? contract,
    $core.bool? success,
    $fixnum.Int64? gasUsed,
    $core.List<$core.int>? from,
    $core.String? error,
    $core.List<$core.int>? gasCost,
    $core.List<$core.int>? txHash,
    $core.Iterable<ProtoTxReceipts_ProtoEvent>? events,
    $core.String? method,
  }) {
    final _result = create();
    if (contract != null) {
      _result.contract = contract;
    }
    if (success != null) {
      _result.success = success;
    }
    if (gasUsed != null) {
      _result.gasUsed = gasUsed;
    }
    if (from != null) {
      _result.from = from;
    }
    if (error != null) {
      _result.error = error;
    }
    if (gasCost != null) {
      _result.gasCost = gasCost;
    }
    if (txHash != null) {
      _result.txHash = txHash;
    }
    if (events != null) {
      _result.events.addAll(events);
    }
    if (method != null) {
      _result.method = method;
    }
    return _result;
  }
  factory ProtoTxReceipts_ProtoTxReceipt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoTxReceipts_ProtoTxReceipt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoTxReceipts_ProtoTxReceipt clone() => ProtoTxReceipts_ProtoTxReceipt()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoTxReceipts_ProtoTxReceipt copyWith(void Function(ProtoTxReceipts_ProtoTxReceipt) updates) => super.copyWith((message) => updates(message as ProtoTxReceipts_ProtoTxReceipt)) as ProtoTxReceipts_ProtoTxReceipt; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTxReceipts_ProtoTxReceipt create() => ProtoTxReceipts_ProtoTxReceipt._();
  ProtoTxReceipts_ProtoTxReceipt createEmptyInstance() => create();
  static $pb.PbList<ProtoTxReceipts_ProtoTxReceipt> createRepeated() => $pb.PbList<ProtoTxReceipts_ProtoTxReceipt>();
  @$core.pragma('dart2js:noInline')
  static ProtoTxReceipts_ProtoTxReceipt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTxReceipts_ProtoTxReceipt>(create);
  static ProtoTxReceipts_ProtoTxReceipt? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get contract => $_getN(0);
  @$pb.TagNumber(1)
  set contract($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContract() => $_has(0);
  @$pb.TagNumber(1)
  void clearContract() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get gasUsed => $_getI64(2);
  @$pb.TagNumber(3)
  set gasUsed($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGasUsed() => $_has(2);
  @$pb.TagNumber(3)
  void clearGasUsed() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get from => $_getN(3);
  @$pb.TagNumber(4)
  set from($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrom() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrom() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get error => $_getSZ(4);
  @$pb.TagNumber(5)
  set error($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasError() => $_has(4);
  @$pb.TagNumber(5)
  void clearError() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get gasCost => $_getN(5);
  @$pb.TagNumber(6)
  set gasCost($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGasCost() => $_has(5);
  @$pb.TagNumber(6)
  void clearGasCost() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get txHash => $_getN(6);
  @$pb.TagNumber(7)
  set txHash($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTxHash() => $_has(6);
  @$pb.TagNumber(7)
  void clearTxHash() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<ProtoTxReceipts_ProtoEvent> get events => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get method => $_getSZ(8);
  @$pb.TagNumber(9)
  set method($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMethod() => $_has(8);
  @$pb.TagNumber(9)
  void clearMethod() => clearField(9);
}

class ProtoTxReceipts_ProtoEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoTxReceipts.ProtoEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event')
    ..p<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoTxReceipts_ProtoEvent._() : super();
  factory ProtoTxReceipts_ProtoEvent({
    $core.String? event,
    $core.Iterable<$core.List<$core.int>>? data,
  }) {
    final _result = create();
    if (event != null) {
      _result.event = event;
    }
    if (data != null) {
      _result.data.addAll(data);
    }
    return _result;
  }
  factory ProtoTxReceipts_ProtoEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoTxReceipts_ProtoEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoTxReceipts_ProtoEvent clone() => ProtoTxReceipts_ProtoEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoTxReceipts_ProtoEvent copyWith(void Function(ProtoTxReceipts_ProtoEvent) updates) => super.copyWith((message) => updates(message as ProtoTxReceipts_ProtoEvent)) as ProtoTxReceipts_ProtoEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTxReceipts_ProtoEvent create() => ProtoTxReceipts_ProtoEvent._();
  ProtoTxReceipts_ProtoEvent createEmptyInstance() => create();
  static $pb.PbList<ProtoTxReceipts_ProtoEvent> createRepeated() => $pb.PbList<ProtoTxReceipts_ProtoEvent>();
  @$core.pragma('dart2js:noInline')
  static ProtoTxReceipts_ProtoEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTxReceipts_ProtoEvent>(create);
  static ProtoTxReceipts_ProtoEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get event => $_getSZ(0);
  @$pb.TagNumber(1)
  set event($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.List<$core.int>> get data => $_getList(1);
}

class ProtoTxReceipts extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoTxReceipts', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..pc<ProtoTxReceipts_ProtoTxReceipt>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receipts', $pb.PbFieldType.PM, subBuilder: ProtoTxReceipts_ProtoTxReceipt.create)
    ..hasRequiredFields = false
  ;

  ProtoTxReceipts._() : super();
  factory ProtoTxReceipts({
    $core.Iterable<ProtoTxReceipts_ProtoTxReceipt>? receipts,
  }) {
    final _result = create();
    if (receipts != null) {
      _result.receipts.addAll(receipts);
    }
    return _result;
  }
  factory ProtoTxReceipts.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoTxReceipts.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoTxReceipts clone() => ProtoTxReceipts()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoTxReceipts copyWith(void Function(ProtoTxReceipts) updates) => super.copyWith((message) => updates(message as ProtoTxReceipts)) as ProtoTxReceipts; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTxReceipts create() => ProtoTxReceipts._();
  ProtoTxReceipts createEmptyInstance() => create();
  static $pb.PbList<ProtoTxReceipts> createRepeated() => $pb.PbList<ProtoTxReceipts>();
  @$core.pragma('dart2js:noInline')
  static ProtoTxReceipts getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTxReceipts>(create);
  static ProtoTxReceipts? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProtoTxReceipts_ProtoTxReceipt> get receipts => $_getList(0);
}

class ProtoTxReceiptIndex extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoTxReceiptIndex', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cid', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'index', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoTxReceiptIndex._() : super();
  factory ProtoTxReceiptIndex({
    $core.List<$core.int>? cid,
    $core.int? index,
  }) {
    final _result = create();
    if (cid != null) {
      _result.cid = cid;
    }
    if (index != null) {
      _result.index = index;
    }
    return _result;
  }
  factory ProtoTxReceiptIndex.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoTxReceiptIndex.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoTxReceiptIndex clone() => ProtoTxReceiptIndex()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoTxReceiptIndex copyWith(void Function(ProtoTxReceiptIndex) updates) => super.copyWith((message) => updates(message as ProtoTxReceiptIndex)) as ProtoTxReceiptIndex; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoTxReceiptIndex create() => ProtoTxReceiptIndex._();
  ProtoTxReceiptIndex createEmptyInstance() => create();
  static $pb.PbList<ProtoTxReceiptIndex> createRepeated() => $pb.PbList<ProtoTxReceiptIndex>();
  @$core.pragma('dart2js:noInline')
  static ProtoTxReceiptIndex getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoTxReceiptIndex>(create);
  static ProtoTxReceiptIndex? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get cid => $_getN(0);
  @$pb.TagNumber(1)
  set cid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCid() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get index => $_getIZ(1);
  @$pb.TagNumber(2)
  set index($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => clearField(2);
}

class ProtoDeferredTxs_ProtoDeferredTx extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoDeferredTxs.ProtoDeferredTx', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tips', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'block', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ProtoDeferredTxs_ProtoDeferredTx._() : super();
  factory ProtoDeferredTxs_ProtoDeferredTx({
    $core.List<$core.int>? from,
    $core.List<$core.int>? to,
    $core.List<$core.int>? amount,
    $core.List<$core.int>? payload,
    $core.List<$core.int>? tips,
    $fixnum.Int64? block,
  }) {
    final _result = create();
    if (from != null) {
      _result.from = from;
    }
    if (to != null) {
      _result.to = to;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (payload != null) {
      _result.payload = payload;
    }
    if (tips != null) {
      _result.tips = tips;
    }
    if (block != null) {
      _result.block = block;
    }
    return _result;
  }
  factory ProtoDeferredTxs_ProtoDeferredTx.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoDeferredTxs_ProtoDeferredTx.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoDeferredTxs_ProtoDeferredTx clone() => ProtoDeferredTxs_ProtoDeferredTx()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoDeferredTxs_ProtoDeferredTx copyWith(void Function(ProtoDeferredTxs_ProtoDeferredTx) updates) => super.copyWith((message) => updates(message as ProtoDeferredTxs_ProtoDeferredTx)) as ProtoDeferredTxs_ProtoDeferredTx; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoDeferredTxs_ProtoDeferredTx create() => ProtoDeferredTxs_ProtoDeferredTx._();
  ProtoDeferredTxs_ProtoDeferredTx createEmptyInstance() => create();
  static $pb.PbList<ProtoDeferredTxs_ProtoDeferredTx> createRepeated() => $pb.PbList<ProtoDeferredTxs_ProtoDeferredTx>();
  @$core.pragma('dart2js:noInline')
  static ProtoDeferredTxs_ProtoDeferredTx getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoDeferredTxs_ProtoDeferredTx>(create);
  static ProtoDeferredTxs_ProtoDeferredTx? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get from => $_getN(0);
  @$pb.TagNumber(1)
  set from($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get to => $_getN(1);
  @$pb.TagNumber(2)
  set to($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearTo() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get payload => $_getN(3);
  @$pb.TagNumber(4)
  set payload($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayload() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayload() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get tips => $_getN(4);
  @$pb.TagNumber(5)
  set tips($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTips() => $_has(4);
  @$pb.TagNumber(5)
  void clearTips() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get block => $_getI64(5);
  @$pb.TagNumber(6)
  set block($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBlock() => $_has(5);
  @$pb.TagNumber(6)
  void clearBlock() => clearField(6);
}

class ProtoDeferredTxs extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoDeferredTxs', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..pc<ProtoDeferredTxs_ProtoDeferredTx>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Txs', $pb.PbFieldType.PM, protoName: 'Txs', subBuilder: ProtoDeferredTxs_ProtoDeferredTx.create)
    ..hasRequiredFields = false
  ;

  ProtoDeferredTxs._() : super();
  factory ProtoDeferredTxs({
    $core.Iterable<ProtoDeferredTxs_ProtoDeferredTx>? txs,
  }) {
    final _result = create();
    if (txs != null) {
      _result.txs.addAll(txs);
    }
    return _result;
  }
  factory ProtoDeferredTxs.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoDeferredTxs.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoDeferredTxs clone() => ProtoDeferredTxs()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoDeferredTxs copyWith(void Function(ProtoDeferredTxs) updates) => super.copyWith((message) => updates(message as ProtoDeferredTxs)) as ProtoDeferredTxs; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoDeferredTxs create() => ProtoDeferredTxs._();
  ProtoDeferredTxs createEmptyInstance() => create();
  static $pb.PbList<ProtoDeferredTxs> createRepeated() => $pb.PbList<ProtoDeferredTxs>();
  @$core.pragma('dart2js:noInline')
  static ProtoDeferredTxs getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoDeferredTxs>(create);
  static ProtoDeferredTxs? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProtoDeferredTxs_ProtoDeferredTx> get txs => $_getList(0);
}

class ProtoSavedEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoSavedEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contract', $pb.PbFieldType.OY)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event')
    ..p<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'args', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ProtoSavedEvent._() : super();
  factory ProtoSavedEvent({
    $core.List<$core.int>? contract,
    $core.String? event,
    $core.Iterable<$core.List<$core.int>>? args,
  }) {
    final _result = create();
    if (contract != null) {
      _result.contract = contract;
    }
    if (event != null) {
      _result.event = event;
    }
    if (args != null) {
      _result.args.addAll(args);
    }
    return _result;
  }
  factory ProtoSavedEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoSavedEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoSavedEvent clone() => ProtoSavedEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoSavedEvent copyWith(void Function(ProtoSavedEvent) updates) => super.copyWith((message) => updates(message as ProtoSavedEvent)) as ProtoSavedEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoSavedEvent create() => ProtoSavedEvent._();
  ProtoSavedEvent createEmptyInstance() => create();
  static $pb.PbList<ProtoSavedEvent> createRepeated() => $pb.PbList<ProtoSavedEvent>();
  @$core.pragma('dart2js:noInline')
  static ProtoSavedEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoSavedEvent>(create);
  static ProtoSavedEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get contract => $_getN(0);
  @$pb.TagNumber(1)
  set contract($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContract() => $_has(0);
  @$pb.TagNumber(1)
  void clearContract() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get event => $_getSZ(1);
  @$pb.TagNumber(2)
  set event($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEvent() => $_has(1);
  @$pb.TagNumber(2)
  void clearEvent() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.List<$core.int>> get args => $_getList(2);
}

class ProtoUpgradeVotes_ProtoUpgradeVote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoUpgradeVotes.ProtoUpgradeVote', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'voter', $pb.PbFieldType.OY)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'upgrade', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ProtoUpgradeVotes_ProtoUpgradeVote._() : super();
  factory ProtoUpgradeVotes_ProtoUpgradeVote({
    $core.List<$core.int>? voter,
    $core.int? upgrade,
  }) {
    final _result = create();
    if (voter != null) {
      _result.voter = voter;
    }
    if (upgrade != null) {
      _result.upgrade = upgrade;
    }
    return _result;
  }
  factory ProtoUpgradeVotes_ProtoUpgradeVote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoUpgradeVotes_ProtoUpgradeVote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoUpgradeVotes_ProtoUpgradeVote clone() => ProtoUpgradeVotes_ProtoUpgradeVote()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoUpgradeVotes_ProtoUpgradeVote copyWith(void Function(ProtoUpgradeVotes_ProtoUpgradeVote) updates) => super.copyWith((message) => updates(message as ProtoUpgradeVotes_ProtoUpgradeVote)) as ProtoUpgradeVotes_ProtoUpgradeVote; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpgradeVotes_ProtoUpgradeVote create() => ProtoUpgradeVotes_ProtoUpgradeVote._();
  ProtoUpgradeVotes_ProtoUpgradeVote createEmptyInstance() => create();
  static $pb.PbList<ProtoUpgradeVotes_ProtoUpgradeVote> createRepeated() => $pb.PbList<ProtoUpgradeVotes_ProtoUpgradeVote>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpgradeVotes_ProtoUpgradeVote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpgradeVotes_ProtoUpgradeVote>(create);
  static ProtoUpgradeVotes_ProtoUpgradeVote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get voter => $_getN(0);
  @$pb.TagNumber(1)
  set voter($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVoter() => $_has(0);
  @$pb.TagNumber(1)
  void clearVoter() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get upgrade => $_getIZ(1);
  @$pb.TagNumber(2)
  set upgrade($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpgrade() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpgrade() => clearField(2);
}

class ProtoUpgradeVotes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoUpgradeVotes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'models'), createEmptyInstance: create)
    ..pc<ProtoUpgradeVotes_ProtoUpgradeVote>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'votes', $pb.PbFieldType.PM, subBuilder: ProtoUpgradeVotes_ProtoUpgradeVote.create)
    ..hasRequiredFields = false
  ;

  ProtoUpgradeVotes._() : super();
  factory ProtoUpgradeVotes({
    $core.Iterable<ProtoUpgradeVotes_ProtoUpgradeVote>? votes,
  }) {
    final _result = create();
    if (votes != null) {
      _result.votes.addAll(votes);
    }
    return _result;
  }
  factory ProtoUpgradeVotes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoUpgradeVotes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoUpgradeVotes clone() => ProtoUpgradeVotes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoUpgradeVotes copyWith(void Function(ProtoUpgradeVotes) updates) => super.copyWith((message) => updates(message as ProtoUpgradeVotes)) as ProtoUpgradeVotes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpgradeVotes create() => ProtoUpgradeVotes._();
  ProtoUpgradeVotes createEmptyInstance() => create();
  static $pb.PbList<ProtoUpgradeVotes> createRepeated() => $pb.PbList<ProtoUpgradeVotes>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpgradeVotes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpgradeVotes>(create);
  static ProtoUpgradeVotes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProtoUpgradeVotes_ProtoUpgradeVote> get votes => $_getList(0);
}

