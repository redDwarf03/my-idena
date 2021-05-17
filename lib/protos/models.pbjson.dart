///
//  Generated code. Do not modify.
//  source: models.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use protoTransactionDescriptor instead')
const ProtoTransaction$json = const {
  '1': 'ProtoTransaction',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoTransaction.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
    const {'1': 'useRlp', '3': 3, '4': 1, '5': 8, '10': 'useRlp'},
  ],
  '3': const [ProtoTransaction_Data$json],
};

@$core.Deprecated('Use protoTransactionDescriptor instead')
const ProtoTransaction_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'nonce', '3': 1, '4': 1, '5': 13, '10': 'nonce'},
    const {'1': 'epoch', '3': 2, '4': 1, '5': 13, '10': 'epoch'},
    const {'1': 'type', '3': 3, '4': 1, '5': 13, '10': 'type'},
    const {'1': 'to', '3': 4, '4': 1, '5': 12, '10': 'to'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 12, '10': 'amount'},
    const {'1': 'maxFee', '3': 6, '4': 1, '5': 12, '10': 'maxFee'},
    const {'1': 'tips', '3': 7, '4': 1, '5': 12, '10': 'tips'},
    const {'1': 'payload', '3': 8, '4': 1, '5': 12, '10': 'payload'},
  ],
};

/// Descriptor for `ProtoTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoTransactionDescriptor = $convert.base64Decode('ChBQcm90b1RyYW5zYWN0aW9uEjEKBGRhdGEYASABKAsyHS5tb2RlbHMuUHJvdG9UcmFuc2FjdGlvbi5EYXRhUgRkYXRhEhwKCXNpZ25hdHVyZRgCIAEoDFIJc2lnbmF0dXJlEhYKBnVzZVJscBgDIAEoCFIGdXNlUmxwGrQBCgREYXRhEhQKBW5vbmNlGAEgASgNUgVub25jZRIUCgVlcG9jaBgCIAEoDVIFZXBvY2gSEgoEdHlwZRgDIAEoDVIEdHlwZRIOCgJ0bxgEIAEoDFICdG8SFgoGYW1vdW50GAUgASgMUgZhbW91bnQSFgoGbWF4RmVlGAYgASgMUgZtYXhGZWUSEgoEdGlwcxgHIAEoDFIEdGlwcxIYCgdwYXlsb2FkGAggASgMUgdwYXlsb2Fk');
@$core.Deprecated('Use protoBlockHeaderDescriptor instead')
const ProtoBlockHeader$json = const {
  '1': 'ProtoBlockHeader',
  '2': const [
    const {'1': 'proposedHeader', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader.Proposed', '10': 'proposedHeader'},
    const {'1': 'emptyHeader', '3': 2, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader.Empty', '10': 'emptyHeader'},
  ],
  '3': const [ProtoBlockHeader_Proposed$json, ProtoBlockHeader_Empty$json],
};

@$core.Deprecated('Use protoBlockHeaderDescriptor instead')
const ProtoBlockHeader_Proposed$json = const {
  '1': 'Proposed',
  '2': const [
    const {'1': 'parentHash', '3': 1, '4': 1, '5': 12, '10': 'parentHash'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'txHash', '3': 4, '4': 1, '5': 12, '10': 'txHash'},
    const {'1': 'proposerPubKey', '3': 5, '4': 1, '5': 12, '10': 'proposerPubKey'},
    const {'1': 'root', '3': 6, '4': 1, '5': 12, '10': 'root'},
    const {'1': 'identityRoot', '3': 7, '4': 1, '5': 12, '10': 'identityRoot'},
    const {'1': 'flags', '3': 8, '4': 1, '5': 13, '10': 'flags'},
    const {'1': 'ipfsHash', '3': 9, '4': 1, '5': 12, '10': 'ipfsHash'},
    const {'1': 'offlineAddr', '3': 10, '4': 1, '5': 12, '10': 'offlineAddr'},
    const {'1': 'txBloom', '3': 11, '4': 1, '5': 12, '10': 'txBloom'},
    const {'1': 'blockSeed', '3': 12, '4': 1, '5': 12, '10': 'blockSeed'},
    const {'1': 'feePerGas', '3': 13, '4': 1, '5': 12, '10': 'feePerGas'},
    const {'1': 'upgrade', '3': 14, '4': 1, '5': 13, '10': 'upgrade'},
    const {'1': 'seedProof', '3': 15, '4': 1, '5': 12, '10': 'seedProof'},
    const {'1': 'receiptsCid', '3': 16, '4': 1, '5': 12, '10': 'receiptsCid'},
  ],
};

@$core.Deprecated('Use protoBlockHeaderDescriptor instead')
const ProtoBlockHeader_Empty$json = const {
  '1': 'Empty',
  '2': const [
    const {'1': 'parentHash', '3': 1, '4': 1, '5': 12, '10': 'parentHash'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'root', '3': 3, '4': 1, '5': 12, '10': 'root'},
    const {'1': 'identityRoot', '3': 4, '4': 1, '5': 12, '10': 'identityRoot'},
    const {'1': 'timestamp', '3': 5, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'blockSeed', '3': 6, '4': 1, '5': 12, '10': 'blockSeed'},
    const {'1': 'flags', '3': 7, '4': 1, '5': 13, '10': 'flags'},
  ],
};

/// Descriptor for `ProtoBlockHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoBlockHeaderDescriptor = $convert.base64Decode('ChBQcm90b0Jsb2NrSGVhZGVyEkkKDnByb3Bvc2VkSGVhZGVyGAEgASgLMiEubW9kZWxzLlByb3RvQmxvY2tIZWFkZXIuUHJvcG9zZWRSDnByb3Bvc2VkSGVhZGVyEkAKC2VtcHR5SGVhZGVyGAIgASgLMh4ubW9kZWxzLlByb3RvQmxvY2tIZWFkZXIuRW1wdHlSC2VtcHR5SGVhZGVyGtwDCghQcm9wb3NlZBIeCgpwYXJlbnRIYXNoGAEgASgMUgpwYXJlbnRIYXNoEhYKBmhlaWdodBgCIAEoBFIGaGVpZ2h0EhwKCXRpbWVzdGFtcBgDIAEoA1IJdGltZXN0YW1wEhYKBnR4SGFzaBgEIAEoDFIGdHhIYXNoEiYKDnByb3Bvc2VyUHViS2V5GAUgASgMUg5wcm9wb3NlclB1YktleRISCgRyb290GAYgASgMUgRyb290EiIKDGlkZW50aXR5Um9vdBgHIAEoDFIMaWRlbnRpdHlSb290EhQKBWZsYWdzGAggASgNUgVmbGFncxIaCghpcGZzSGFzaBgJIAEoDFIIaXBmc0hhc2gSIAoLb2ZmbGluZUFkZHIYCiABKAxSC29mZmxpbmVBZGRyEhgKB3R4Qmxvb20YCyABKAxSB3R4Qmxvb20SHAoJYmxvY2tTZWVkGAwgASgMUglibG9ja1NlZWQSHAoJZmVlUGVyR2FzGA0gASgMUglmZWVQZXJHYXMSGAoHdXBncmFkZRgOIAEoDVIHdXBncmFkZRIcCglzZWVkUHJvb2YYDyABKAxSCXNlZWRQcm9vZhIgCgtyZWNlaXB0c0NpZBgQIAEoDFILcmVjZWlwdHNDaWQayQEKBUVtcHR5Eh4KCnBhcmVudEhhc2gYASABKAxSCnBhcmVudEhhc2gSFgoGaGVpZ2h0GAIgASgEUgZoZWlnaHQSEgoEcm9vdBgDIAEoDFIEcm9vdBIiCgxpZGVudGl0eVJvb3QYBCABKAxSDGlkZW50aXR5Um9vdBIcCgl0aW1lc3RhbXAYBSABKANSCXRpbWVzdGFtcBIcCglibG9ja1NlZWQYBiABKAxSCWJsb2NrU2VlZBIUCgVmbGFncxgHIAEoDVIFZmxhZ3M=');
@$core.Deprecated('Use protoBlockBodyDescriptor instead')
const ProtoBlockBody$json = const {
  '1': 'ProtoBlockBody',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoTransaction', '10': 'transactions'},
  ],
};

/// Descriptor for `ProtoBlockBody`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoBlockBodyDescriptor = $convert.base64Decode('Cg5Qcm90b0Jsb2NrQm9keRI8Cgx0cmFuc2FjdGlvbnMYASADKAsyGC5tb2RlbHMuUHJvdG9UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25z');
@$core.Deprecated('Use protoBlockDescriptor instead')
const ProtoBlock$json = const {
  '1': 'ProtoBlock',
  '2': const [
    const {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader', '10': 'header'},
    const {'1': 'body', '3': 2, '4': 1, '5': 11, '6': '.models.ProtoBlockBody', '10': 'body'},
  ],
};

/// Descriptor for `ProtoBlock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoBlockDescriptor = $convert.base64Decode('CgpQcm90b0Jsb2NrEjAKBmhlYWRlchgBIAEoCzIYLm1vZGVscy5Qcm90b0Jsb2NrSGVhZGVyUgZoZWFkZXISKgoEYm9keRgCIAEoCzIWLm1vZGVscy5Qcm90b0Jsb2NrQm9keVIEYm9keQ==');
@$core.Deprecated('Use protoBlockProposalDescriptor instead')
const ProtoBlockProposal$json = const {
  '1': 'ProtoBlockProposal',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockProposal.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoBlockProposal_Data$json],
};

@$core.Deprecated('Use protoBlockProposalDescriptor instead')
const ProtoBlockProposal_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader', '10': 'header'},
    const {'1': 'body', '3': 2, '4': 1, '5': 11, '6': '.models.ProtoBlockBody', '10': 'body'},
    const {'1': 'proof', '3': 3, '4': 1, '5': 12, '10': 'proof'},
  ],
};

/// Descriptor for `ProtoBlockProposal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoBlockProposalDescriptor = $convert.base64Decode('ChJQcm90b0Jsb2NrUHJvcG9zYWwSMwoEZGF0YRgBIAEoCzIfLm1vZGVscy5Qcm90b0Jsb2NrUHJvcG9zYWwuRGF0YVIEZGF0YRIcCglzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZRp6CgREYXRhEjAKBmhlYWRlchgBIAEoCzIYLm1vZGVscy5Qcm90b0Jsb2NrSGVhZGVyUgZoZWFkZXISKgoEYm9keRgCIAEoCzIWLm1vZGVscy5Qcm90b0Jsb2NrQm9keVIEYm9keRIUCgVwcm9vZhgDIAEoDFIFcHJvb2Y=');
@$core.Deprecated('Use protoIpfsFlipDescriptor instead')
const ProtoIpfsFlip$json = const {
  '1': 'ProtoIpfsFlip',
  '2': const [
    const {'1': 'pubKey', '3': 1, '4': 1, '5': 12, '10': 'pubKey'},
    const {'1': 'publicPart', '3': 2, '4': 1, '5': 12, '10': 'publicPart'},
    const {'1': 'privatePart', '3': 3, '4': 1, '5': 12, '10': 'privatePart'},
  ],
};

/// Descriptor for `ProtoIpfsFlip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoIpfsFlipDescriptor = $convert.base64Decode('Cg1Qcm90b0lwZnNGbGlwEhYKBnB1YktleRgBIAEoDFIGcHViS2V5Eh4KCnB1YmxpY1BhcnQYAiABKAxSCnB1YmxpY1BhcnQSIAoLcHJpdmF0ZVBhcnQYAyABKAxSC3ByaXZhdGVQYXJ0');
@$core.Deprecated('Use protoBlockCertDescriptor instead')
const ProtoBlockCert$json = const {
  '1': 'ProtoBlockCert',
  '2': const [
    const {'1': 'round', '3': 1, '4': 1, '5': 4, '10': 'round'},
    const {'1': 'step', '3': 2, '4': 1, '5': 13, '10': 'step'},
    const {'1': 'votedHash', '3': 3, '4': 1, '5': 12, '10': 'votedHash'},
    const {'1': 'signatures', '3': 4, '4': 3, '5': 11, '6': '.models.ProtoBlockCert.Signature', '10': 'signatures'},
  ],
  '3': const [ProtoBlockCert_Signature$json],
};

@$core.Deprecated('Use protoBlockCertDescriptor instead')
const ProtoBlockCert_Signature$json = const {
  '1': 'Signature',
  '2': const [
    const {'1': 'turnOffline', '3': 1, '4': 1, '5': 8, '10': 'turnOffline'},
    const {'1': 'upgrade', '3': 2, '4': 1, '5': 13, '10': 'upgrade'},
    const {'1': 'signature', '3': 3, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `ProtoBlockCert`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoBlockCertDescriptor = $convert.base64Decode('Cg5Qcm90b0Jsb2NrQ2VydBIUCgVyb3VuZBgBIAEoBFIFcm91bmQSEgoEc3RlcBgCIAEoDVIEc3RlcBIcCgl2b3RlZEhhc2gYAyABKAxSCXZvdGVkSGFzaBJACgpzaWduYXR1cmVzGAQgAygLMiAubW9kZWxzLlByb3RvQmxvY2tDZXJ0LlNpZ25hdHVyZVIKc2lnbmF0dXJlcxplCglTaWduYXR1cmUSIAoLdHVybk9mZmxpbmUYASABKAhSC3R1cm5PZmZsaW5lEhgKB3VwZ3JhZGUYAiABKA1SB3VwZ3JhZGUSHAoJc2lnbmF0dXJlGAMgASgMUglzaWduYXR1cmU=');
@$core.Deprecated('Use protoWeakCertificatesDescriptor instead')
const ProtoWeakCertificates$json = const {
  '1': 'ProtoWeakCertificates',
  '2': const [
    const {'1': 'hashes', '3': 1, '4': 3, '5': 12, '10': 'hashes'},
  ],
};

/// Descriptor for `ProtoWeakCertificates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoWeakCertificatesDescriptor = $convert.base64Decode('ChVQcm90b1dlYWtDZXJ0aWZpY2F0ZXMSFgoGaGFzaGVzGAEgAygMUgZoYXNoZXM=');
@$core.Deprecated('Use protoTransactionIndexDescriptor instead')
const ProtoTransactionIndex$json = const {
  '1': 'ProtoTransactionIndex',
  '2': const [
    const {'1': 'blockHash', '3': 1, '4': 1, '5': 12, '10': 'blockHash'},
    const {'1': 'idx', '3': 2, '4': 1, '5': 13, '10': 'idx'},
  ],
};

/// Descriptor for `ProtoTransactionIndex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoTransactionIndexDescriptor = $convert.base64Decode('ChVQcm90b1RyYW5zYWN0aW9uSW5kZXgSHAoJYmxvY2tIYXNoGAEgASgMUglibG9ja0hhc2gSEAoDaWR4GAIgASgNUgNpZHg=');
@$core.Deprecated('Use protoFlipPrivateKeysDescriptor instead')
const ProtoFlipPrivateKeys$json = const {
  '1': 'ProtoFlipPrivateKeys',
  '2': const [
    const {'1': 'keys', '3': 1, '4': 3, '5': 12, '10': 'keys'},
  ],
};

/// Descriptor for `ProtoFlipPrivateKeys`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoFlipPrivateKeysDescriptor = $convert.base64Decode('ChRQcm90b0ZsaXBQcml2YXRlS2V5cxISCgRrZXlzGAEgAygMUgRrZXlz');
@$core.Deprecated('Use protoProfileDescriptor instead')
const ProtoProfile$json = const {
  '1': 'ProtoProfile',
  '2': const [
    const {'1': 'nickname', '3': 1, '4': 1, '5': 12, '10': 'nickname'},
    const {'1': 'info', '3': 2, '4': 1, '5': 12, '10': 'info'},
  ],
};

/// Descriptor for `ProtoProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoProfileDescriptor = $convert.base64Decode('CgxQcm90b1Byb2ZpbGUSGgoIbmlja25hbWUYASABKAxSCG5pY2tuYW1lEhIKBGluZm8YAiABKAxSBGluZm8=');
@$core.Deprecated('Use protoHandshakeDescriptor instead')
const ProtoHandshake$json = const {
  '1': 'ProtoHandshake',
  '2': const [
    const {'1': 'networkId', '3': 1, '4': 1, '5': 13, '10': 'networkId'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'genesis', '3': 3, '4': 1, '5': 12, '10': 'genesis'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'appVersion', '3': 5, '4': 1, '5': 9, '10': 'appVersion'},
    const {'1': 'peers', '3': 6, '4': 1, '5': 13, '10': 'peers'},
    const {'1': 'oldGenesis', '3': 7, '4': 1, '5': 12, '10': 'oldGenesis'},
  ],
};

/// Descriptor for `ProtoHandshake`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoHandshakeDescriptor = $convert.base64Decode('Cg5Qcm90b0hhbmRzaGFrZRIcCgluZXR3b3JrSWQYASABKA1SCW5ldHdvcmtJZBIWCgZoZWlnaHQYAiABKARSBmhlaWdodBIYCgdnZW5lc2lzGAMgASgMUgdnZW5lc2lzEhwKCXRpbWVzdGFtcBgEIAEoA1IJdGltZXN0YW1wEh4KCmFwcFZlcnNpb24YBSABKAlSCmFwcFZlcnNpb24SFAoFcGVlcnMYBiABKA1SBXBlZXJzEh4KCm9sZEdlbmVzaXMYByABKAxSCm9sZEdlbmVzaXM=');
@$core.Deprecated('Use protoMsgDescriptor instead')
const ProtoMsg$json = const {
  '1': 'ProtoMsg',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 4, '10': 'code'},
    const {'1': 'payload', '3': 2, '4': 1, '5': 12, '10': 'payload'},
  ],
};

/// Descriptor for `ProtoMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoMsgDescriptor = $convert.base64Decode('CghQcm90b01zZxISCgRjb2RlGAEgASgEUgRjb2RlEhgKB3BheWxvYWQYAiABKAxSB3BheWxvYWQ=');
@$core.Deprecated('Use protoIdentityStateDiffDescriptor instead')
const ProtoIdentityStateDiff$json = const {
  '1': 'ProtoIdentityStateDiff',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoIdentityStateDiff.IdentityStateDiffValue', '10': 'values'},
  ],
  '3': const [ProtoIdentityStateDiff_IdentityStateDiffValue$json],
};

@$core.Deprecated('Use protoIdentityStateDiffDescriptor instead')
const ProtoIdentityStateDiff_IdentityStateDiffValue$json = const {
  '1': 'IdentityStateDiffValue',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'deleted', '3': 2, '4': 1, '5': 8, '10': 'deleted'},
    const {'1': 'value', '3': 3, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `ProtoIdentityStateDiff`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoIdentityStateDiffDescriptor = $convert.base64Decode('ChZQcm90b0lkZW50aXR5U3RhdGVEaWZmEk0KBnZhbHVlcxgBIAMoCzI1Lm1vZGVscy5Qcm90b0lkZW50aXR5U3RhdGVEaWZmLklkZW50aXR5U3RhdGVEaWZmVmFsdWVSBnZhbHVlcxpiChZJZGVudGl0eVN0YXRlRGlmZlZhbHVlEhgKB2FkZHJlc3MYASABKAxSB2FkZHJlc3MSGAoHZGVsZXRlZBgCIAEoCFIHZGVsZXRlZBIUCgV2YWx1ZRgDIAEoDFIFdmFsdWU=');
@$core.Deprecated('Use protoSnapshotBlockDescriptor instead')
const ProtoSnapshotBlock$json = const {
  '1': 'ProtoSnapshotBlock',
  '2': const [
    const {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoSnapshotBlock.KeyValue', '10': 'data'},
  ],
  '3': const [ProtoSnapshotBlock_KeyValue$json],
};

@$core.Deprecated('Use protoSnapshotBlockDescriptor instead')
const ProtoSnapshotBlock_KeyValue$json = const {
  '1': 'KeyValue',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 12, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `ProtoSnapshotBlock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoSnapshotBlockDescriptor = $convert.base64Decode('ChJQcm90b1NuYXBzaG90QmxvY2sSNwoEZGF0YRgBIAMoCzIjLm1vZGVscy5Qcm90b1NuYXBzaG90QmxvY2suS2V5VmFsdWVSBGRhdGEaMgoIS2V5VmFsdWUSEAoDa2V5GAEgASgMUgNrZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVl');
@$core.Deprecated('Use protoGossipBlockRangeDescriptor instead')
const ProtoGossipBlockRange$json = const {
  '1': 'ProtoGossipBlockRange',
  '2': const [
    const {'1': 'batchId', '3': 1, '4': 1, '5': 13, '10': 'batchId'},
    const {'1': 'blocks', '3': 2, '4': 3, '5': 11, '6': '.models.ProtoGossipBlockRange.Block', '10': 'blocks'},
  ],
  '3': const [ProtoGossipBlockRange_Block$json],
};

@$core.Deprecated('Use protoGossipBlockRangeDescriptor instead')
const ProtoGossipBlockRange_Block$json = const {
  '1': 'Block',
  '2': const [
    const {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader', '10': 'header'},
    const {'1': 'cert', '3': 2, '4': 1, '5': 11, '6': '.models.ProtoBlockCert', '10': 'cert'},
    const {'1': 'diff', '3': 3, '4': 1, '5': 11, '6': '.models.ProtoIdentityStateDiff', '10': 'diff'},
  ],
};

/// Descriptor for `ProtoGossipBlockRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoGossipBlockRangeDescriptor = $convert.base64Decode('ChVQcm90b0dvc3NpcEJsb2NrUmFuZ2USGAoHYmF0Y2hJZBgBIAEoDVIHYmF0Y2hJZBI7CgZibG9ja3MYAiADKAsyIy5tb2RlbHMuUHJvdG9Hb3NzaXBCbG9ja1JhbmdlLkJsb2NrUgZibG9ja3MamQEKBUJsb2NrEjAKBmhlYWRlchgBIAEoCzIYLm1vZGVscy5Qcm90b0Jsb2NrSGVhZGVyUgZoZWFkZXISKgoEY2VydBgCIAEoCzIWLm1vZGVscy5Qcm90b0Jsb2NrQ2VydFIEY2VydBIyCgRkaWZmGAMgASgLMh4ubW9kZWxzLlByb3RvSWRlbnRpdHlTdGF0ZURpZmZSBGRpZmY=');
@$core.Deprecated('Use protoProposeProofDescriptor instead')
const ProtoProposeProof$json = const {
  '1': 'ProtoProposeProof',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoProposeProof.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoProposeProof_Data$json],
};

@$core.Deprecated('Use protoProposeProofDescriptor instead')
const ProtoProposeProof_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'proof', '3': 1, '4': 1, '5': 12, '10': 'proof'},
    const {'1': 'round', '3': 2, '4': 1, '5': 4, '10': 'round'},
  ],
};

/// Descriptor for `ProtoProposeProof`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoProposeProofDescriptor = $convert.base64Decode('ChFQcm90b1Byb3Bvc2VQcm9vZhIyCgRkYXRhGAEgASgLMh4ubW9kZWxzLlByb3RvUHJvcG9zZVByb29mLkRhdGFSBGRhdGESHAoJc2lnbmF0dXJlGAIgASgMUglzaWduYXR1cmUaMgoERGF0YRIUCgVwcm9vZhgBIAEoDFIFcHJvb2YSFAoFcm91bmQYAiABKARSBXJvdW5k');
@$core.Deprecated('Use protoVoteDescriptor instead')
const ProtoVote$json = const {
  '1': 'ProtoVote',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoVote.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoVote_Data$json],
};

@$core.Deprecated('Use protoVoteDescriptor instead')
const ProtoVote_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'round', '3': 1, '4': 1, '5': 4, '10': 'round'},
    const {'1': 'step', '3': 2, '4': 1, '5': 13, '10': 'step'},
    const {'1': 'parentHash', '3': 3, '4': 1, '5': 12, '10': 'parentHash'},
    const {'1': 'votedHash', '3': 4, '4': 1, '5': 12, '10': 'votedHash'},
    const {'1': 'turnOffline', '3': 5, '4': 1, '5': 8, '10': 'turnOffline'},
    const {'1': 'upgrade', '3': 6, '4': 1, '5': 13, '10': 'upgrade'},
  ],
};

/// Descriptor for `ProtoVote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoVoteDescriptor = $convert.base64Decode('CglQcm90b1ZvdGUSKgoEZGF0YRgBIAEoCzIWLm1vZGVscy5Qcm90b1ZvdGUuRGF0YVIEZGF0YRIcCglzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZRqqAQoERGF0YRIUCgVyb3VuZBgBIAEoBFIFcm91bmQSEgoEc3RlcBgCIAEoDVIEc3RlcBIeCgpwYXJlbnRIYXNoGAMgASgMUgpwYXJlbnRIYXNoEhwKCXZvdGVkSGFzaBgEIAEoDFIJdm90ZWRIYXNoEiAKC3R1cm5PZmZsaW5lGAUgASgIUgt0dXJuT2ZmbGluZRIYCgd1cGdyYWRlGAYgASgNUgd1cGdyYWRl');
@$core.Deprecated('Use protoGetBlockByHashRequestDescriptor instead')
const ProtoGetBlockByHashRequest$json = const {
  '1': 'ProtoGetBlockByHashRequest',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
  ],
};

/// Descriptor for `ProtoGetBlockByHashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoGetBlockByHashRequestDescriptor = $convert.base64Decode('ChpQcm90b0dldEJsb2NrQnlIYXNoUmVxdWVzdBISCgRoYXNoGAEgASgMUgRoYXNo');
@$core.Deprecated('Use protoGetBlocksRangeRequestDescriptor instead')
const ProtoGetBlocksRangeRequest$json = const {
  '1': 'ProtoGetBlocksRangeRequest',
  '2': const [
    const {'1': 'batchId', '3': 1, '4': 1, '5': 13, '10': 'batchId'},
    const {'1': 'from', '3': 2, '4': 1, '5': 4, '10': 'from'},
    const {'1': 'to', '3': 3, '4': 1, '5': 4, '10': 'to'},
  ],
};

/// Descriptor for `ProtoGetBlocksRangeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoGetBlocksRangeRequestDescriptor = $convert.base64Decode('ChpQcm90b0dldEJsb2Nrc1JhbmdlUmVxdWVzdBIYCgdiYXRjaElkGAEgASgNUgdiYXRjaElkEhIKBGZyb20YAiABKARSBGZyb20SDgoCdG8YAyABKARSAnRv');
@$core.Deprecated('Use protoGetForkBlockRangeRequestDescriptor instead')
const ProtoGetForkBlockRangeRequest$json = const {
  '1': 'ProtoGetForkBlockRangeRequest',
  '2': const [
    const {'1': 'batchId', '3': 1, '4': 1, '5': 13, '10': 'batchId'},
    const {'1': 'blocks', '3': 2, '4': 3, '5': 12, '10': 'blocks'},
  ],
};

/// Descriptor for `ProtoGetForkBlockRangeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoGetForkBlockRangeRequestDescriptor = $convert.base64Decode('Ch1Qcm90b0dldEZvcmtCbG9ja1JhbmdlUmVxdWVzdBIYCgdiYXRjaElkGAEgASgNUgdiYXRjaElkEhYKBmJsb2NrcxgCIAMoDFIGYmxvY2tz');
@$core.Deprecated('Use protoFlipDescriptor instead')
const ProtoFlip$json = const {
  '1': 'ProtoFlip',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoTransaction', '10': 'transaction'},
    const {'1': 'publicPart', '3': 2, '4': 1, '5': 12, '10': 'publicPart'},
    const {'1': 'privatePart', '3': 3, '4': 1, '5': 12, '10': 'privatePart'},
  ],
};

/// Descriptor for `ProtoFlip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoFlipDescriptor = $convert.base64Decode('CglQcm90b0ZsaXASOgoLdHJhbnNhY3Rpb24YASABKAsyGC5tb2RlbHMuUHJvdG9UcmFuc2FjdGlvblILdHJhbnNhY3Rpb24SHgoKcHVibGljUGFydBgCIAEoDFIKcHVibGljUGFydBIgCgtwcml2YXRlUGFydBgDIAEoDFILcHJpdmF0ZVBhcnQ=');
@$core.Deprecated('Use protoFlipKeyDescriptor instead')
const ProtoFlipKey$json = const {
  '1': 'ProtoFlipKey',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoFlipKey.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoFlipKey_Data$json],
};

@$core.Deprecated('Use protoFlipKeyDescriptor instead')
const ProtoFlipKey_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 12, '10': 'key'},
    const {'1': 'epoch', '3': 2, '4': 1, '5': 13, '10': 'epoch'},
  ],
};

/// Descriptor for `ProtoFlipKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoFlipKeyDescriptor = $convert.base64Decode('CgxQcm90b0ZsaXBLZXkSLQoEZGF0YRgBIAEoCzIZLm1vZGVscy5Qcm90b0ZsaXBLZXkuRGF0YVIEZGF0YRIcCglzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZRouCgREYXRhEhAKA2tleRgBIAEoDFIDa2V5EhQKBWVwb2NoGAIgASgNUgVlcG9jaA==');
@$core.Deprecated('Use protoManifestDescriptor instead')
const ProtoManifest$json = const {
  '1': 'ProtoManifest',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'root', '3': 3, '4': 1, '5': 12, '10': 'root'},
  ],
};

/// Descriptor for `ProtoManifest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoManifestDescriptor = $convert.base64Decode('Cg1Qcm90b01hbmlmZXN0EhAKA2NpZBgBIAEoDFIDY2lkEhYKBmhlaWdodBgCIAEoBFIGaGVpZ2h0EhIKBHJvb3QYAyABKAxSBHJvb3Q=');
@$core.Deprecated('Use protoPrivateFlipKeysPackageDescriptor instead')
const ProtoPrivateFlipKeysPackage$json = const {
  '1': 'ProtoPrivateFlipKeysPackage',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoPrivateFlipKeysPackage.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoPrivateFlipKeysPackage_Data$json],
};

@$core.Deprecated('Use protoPrivateFlipKeysPackageDescriptor instead')
const ProtoPrivateFlipKeysPackage_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'package', '3': 1, '4': 1, '5': 12, '10': 'package'},
    const {'1': 'epoch', '3': 2, '4': 1, '5': 13, '10': 'epoch'},
  ],
};

/// Descriptor for `ProtoPrivateFlipKeysPackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoPrivateFlipKeysPackageDescriptor = $convert.base64Decode('ChtQcm90b1ByaXZhdGVGbGlwS2V5c1BhY2thZ2USPAoEZGF0YRgBIAEoCzIoLm1vZGVscy5Qcm90b1ByaXZhdGVGbGlwS2V5c1BhY2thZ2UuRGF0YVIEZGF0YRIcCglzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZRo2CgREYXRhEhgKB3BhY2thZ2UYASABKAxSB3BhY2thZ2USFAoFZXBvY2gYAiABKA1SBWVwb2No');
@$core.Deprecated('Use protoPullPushHashDescriptor instead')
const ProtoPullPushHash$json = const {
  '1': 'ProtoPullPushHash',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 13, '10': 'type'},
    const {'1': 'hash', '3': 2, '4': 1, '5': 12, '10': 'hash'},
  ],
};

/// Descriptor for `ProtoPullPushHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoPullPushHashDescriptor = $convert.base64Decode('ChFQcm90b1B1bGxQdXNoSGFzaBISCgR0eXBlGAEgASgNUgR0eXBlEhIKBGhhc2gYAiABKAxSBGhhc2g=');
@$core.Deprecated('Use protoSnapshotManifestDbDescriptor instead')
const ProtoSnapshotManifestDb$json = const {
  '1': 'ProtoSnapshotManifestDb',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'fileName', '3': 3, '4': 1, '5': 9, '10': 'fileName'},
    const {'1': 'root', '3': 4, '4': 1, '5': 12, '10': 'root'},
  ],
};

/// Descriptor for `ProtoSnapshotManifestDb`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoSnapshotManifestDbDescriptor = $convert.base64Decode('ChdQcm90b1NuYXBzaG90TWFuaWZlc3REYhIQCgNjaWQYASABKAxSA2NpZBIWCgZoZWlnaHQYAiABKARSBmhlaWdodBIaCghmaWxlTmFtZRgDIAEoCVIIZmlsZU5hbWUSEgoEcm9vdBgEIAEoDFIEcm9vdA==');
@$core.Deprecated('Use protoShortAnswerDbDescriptor instead')
const ProtoShortAnswerDb$json = const {
  '1': 'ProtoShortAnswerDb',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `ProtoShortAnswerDb`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoShortAnswerDbDescriptor = $convert.base64Decode('ChJQcm90b1Nob3J0QW5zd2VyRGISEgoEaGFzaBgBIAEoDFIEaGFzaBIcCgl0aW1lc3RhbXAYAiABKANSCXRpbWVzdGFtcA==');
@$core.Deprecated('Use protoAnswersDbDescriptor instead')
const ProtoAnswersDb$json = const {
  '1': 'ProtoAnswersDb',
  '2': const [
    const {'1': 'answers', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoAnswersDb.Answer', '10': 'answers'},
  ],
  '3': const [ProtoAnswersDb_Answer$json],
};

@$core.Deprecated('Use protoAnswersDbDescriptor instead')
const ProtoAnswersDb_Answer$json = const {
  '1': 'Answer',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'answers', '3': 2, '4': 1, '5': 12, '10': 'answers'},
  ],
};

/// Descriptor for `ProtoAnswersDb`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoAnswersDbDescriptor = $convert.base64Decode('Cg5Qcm90b0Fuc3dlcnNEYhI3CgdhbnN3ZXJzGAEgAygLMh0ubW9kZWxzLlByb3RvQW5zd2Vyc0RiLkFuc3dlclIHYW5zd2Vycxo8CgZBbnN3ZXISGAoHYWRkcmVzcxgBIAEoDFIHYWRkcmVzcxIYCgdhbnN3ZXJzGAIgASgMUgdhbnN3ZXJz');
@$core.Deprecated('Use protoBurntCoinsDescriptor instead')
const ProtoBurntCoins$json = const {
  '1': 'ProtoBurntCoins',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'key', '3': 2, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 12, '10': 'amount'},
  ],
};

/// Descriptor for `ProtoBurntCoins`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoBurntCoinsDescriptor = $convert.base64Decode('Cg9Qcm90b0J1cm50Q29pbnMSGAoHYWRkcmVzcxgBIAEoDFIHYWRkcmVzcxIQCgNrZXkYAiABKAlSA2tleRIWCgZhbW91bnQYAyABKAxSBmFtb3VudA==');
@$core.Deprecated('Use protoSavedTransactionDescriptor instead')
const ProtoSavedTransaction$json = const {
  '1': 'ProtoSavedTransaction',
  '2': const [
    const {'1': 'tx', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoTransaction', '10': 'tx'},
    const {'1': 'feePerGas', '3': 2, '4': 1, '5': 12, '10': 'feePerGas'},
    const {'1': 'blockHash', '3': 3, '4': 1, '5': 12, '10': 'blockHash'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `ProtoSavedTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoSavedTransactionDescriptor = $convert.base64Decode('ChVQcm90b1NhdmVkVHJhbnNhY3Rpb24SKAoCdHgYASABKAsyGC5tb2RlbHMuUHJvdG9UcmFuc2FjdGlvblICdHgSHAoJZmVlUGVyR2FzGAIgASgMUglmZWVQZXJHYXMSHAoJYmxvY2tIYXNoGAMgASgMUglibG9ja0hhc2gSHAoJdGltZXN0YW1wGAQgASgDUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use protoActivityMonitorDescriptor instead')
const ProtoActivityMonitor$json = const {
  '1': 'ProtoActivityMonitor',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'activities', '3': 2, '4': 3, '5': 11, '6': '.models.ProtoActivityMonitor.Activity', '10': 'activities'},
  ],
  '3': const [ProtoActivityMonitor_Activity$json],
};

@$core.Deprecated('Use protoActivityMonitorDescriptor instead')
const ProtoActivityMonitor_Activity$json = const {
  '1': 'Activity',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `ProtoActivityMonitor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoActivityMonitorDescriptor = $convert.base64Decode('ChRQcm90b0FjdGl2aXR5TW9uaXRvchIcCgl0aW1lc3RhbXAYASABKANSCXRpbWVzdGFtcBJFCgphY3Rpdml0aWVzGAIgAygLMiUubW9kZWxzLlByb3RvQWN0aXZpdHlNb25pdG9yLkFjdGl2aXR5UgphY3Rpdml0aWVzGkIKCEFjdGl2aXR5EhgKB2FkZHJlc3MYASABKAxSB2FkZHJlc3MSHAoJdGltZXN0YW1wGAIgASgDUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use protoShortAnswerAttachmentDescriptor instead')
const ProtoShortAnswerAttachment$json = const {
  '1': 'ProtoShortAnswerAttachment',
  '2': const [
    const {'1': 'answers', '3': 1, '4': 1, '5': 12, '10': 'answers'},
    const {'1': 'rnd', '3': 2, '4': 1, '5': 4, '10': 'rnd'},
  ],
};

/// Descriptor for `ProtoShortAnswerAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoShortAnswerAttachmentDescriptor = $convert.base64Decode('ChpQcm90b1Nob3J0QW5zd2VyQXR0YWNobWVudBIYCgdhbnN3ZXJzGAEgASgMUgdhbnN3ZXJzEhAKA3JuZBgCIAEoBFIDcm5k');
@$core.Deprecated('Use protoLongAnswerAttachmentDescriptor instead')
const ProtoLongAnswerAttachment$json = const {
  '1': 'ProtoLongAnswerAttachment',
  '2': const [
    const {'1': 'answers', '3': 1, '4': 1, '5': 12, '10': 'answers'},
    const {'1': 'proof', '3': 2, '4': 1, '5': 12, '10': 'proof'},
    const {'1': 'key', '3': 3, '4': 1, '5': 12, '10': 'key'},
    const {'1': 'salt', '3': 4, '4': 1, '5': 12, '10': 'salt'},
  ],
};

/// Descriptor for `ProtoLongAnswerAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoLongAnswerAttachmentDescriptor = $convert.base64Decode('ChlQcm90b0xvbmdBbnN3ZXJBdHRhY2htZW50EhgKB2Fuc3dlcnMYASABKAxSB2Fuc3dlcnMSFAoFcHJvb2YYAiABKAxSBXByb29mEhAKA2tleRgDIAEoDFIDa2V5EhIKBHNhbHQYBCABKAxSBHNhbHQ=');
@$core.Deprecated('Use protoFlipSubmitAttachmentDescriptor instead')
const ProtoFlipSubmitAttachment$json = const {
  '1': 'ProtoFlipSubmitAttachment',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'pair', '3': 2, '4': 1, '5': 13, '10': 'pair'},
  ],
};

/// Descriptor for `ProtoFlipSubmitAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoFlipSubmitAttachmentDescriptor = $convert.base64Decode('ChlQcm90b0ZsaXBTdWJtaXRBdHRhY2htZW50EhAKA2NpZBgBIAEoDFIDY2lkEhIKBHBhaXIYAiABKA1SBHBhaXI=');
@$core.Deprecated('Use protoOnlineStatusAttachmentDescriptor instead')
const ProtoOnlineStatusAttachment$json = const {
  '1': 'ProtoOnlineStatusAttachment',
  '2': const [
    const {'1': 'online', '3': 1, '4': 1, '5': 8, '10': 'online'},
  ],
};

/// Descriptor for `ProtoOnlineStatusAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoOnlineStatusAttachmentDescriptor = $convert.base64Decode('ChtQcm90b09ubGluZVN0YXR1c0F0dGFjaG1lbnQSFgoGb25saW5lGAEgASgIUgZvbmxpbmU=');
@$core.Deprecated('Use protoBurnAttachmentDescriptor instead')
const ProtoBurnAttachment$json = const {
  '1': 'ProtoBurnAttachment',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
  ],
};

/// Descriptor for `ProtoBurnAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoBurnAttachmentDescriptor = $convert.base64Decode('ChNQcm90b0J1cm5BdHRhY2htZW50EhAKA2tleRgBIAEoCVIDa2V5');
@$core.Deprecated('Use protoChangeProfileAttachmentDescriptor instead')
const ProtoChangeProfileAttachment$json = const {
  '1': 'ProtoChangeProfileAttachment',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
  ],
};

/// Descriptor for `ProtoChangeProfileAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoChangeProfileAttachmentDescriptor = $convert.base64Decode('ChxQcm90b0NoYW5nZVByb2ZpbGVBdHRhY2htZW50EhIKBGhhc2gYASABKAxSBGhhc2g=');
@$core.Deprecated('Use protoDeleteFlipAttachmentDescriptor instead')
const ProtoDeleteFlipAttachment$json = const {
  '1': 'ProtoDeleteFlipAttachment',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
  ],
};

/// Descriptor for `ProtoDeleteFlipAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoDeleteFlipAttachmentDescriptor = $convert.base64Decode('ChlQcm90b0RlbGV0ZUZsaXBBdHRhY2htZW50EhAKA2NpZBgBIAEoDFIDY2lk');
@$core.Deprecated('Use protoStateAccountDescriptor instead')
const ProtoStateAccount$json = const {
  '1': 'ProtoStateAccount',
  '2': const [
    const {'1': 'nonce', '3': 1, '4': 1, '5': 13, '10': 'nonce'},
    const {'1': 'epoch', '3': 2, '4': 1, '5': 13, '10': 'epoch'},
    const {'1': 'balance', '3': 3, '4': 1, '5': 12, '10': 'balance'},
    const {'1': 'contractData', '3': 4, '4': 1, '5': 11, '6': '.models.ProtoStateAccount.ProtoContractData', '10': 'contractData'},
  ],
  '3': const [ProtoStateAccount_ProtoContractData$json],
};

@$core.Deprecated('Use protoStateAccountDescriptor instead')
const ProtoStateAccount_ProtoContractData$json = const {
  '1': 'ProtoContractData',
  '2': const [
    const {'1': 'codeHash', '3': 1, '4': 1, '5': 12, '10': 'codeHash'},
    const {'1': 'stake', '3': 2, '4': 1, '5': 12, '10': 'stake'},
  ],
};

/// Descriptor for `ProtoStateAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoStateAccountDescriptor = $convert.base64Decode('ChFQcm90b1N0YXRlQWNjb3VudBIUCgVub25jZRgBIAEoDVIFbm9uY2USFAoFZXBvY2gYAiABKA1SBWVwb2NoEhgKB2JhbGFuY2UYAyABKAxSB2JhbGFuY2USTwoMY29udHJhY3REYXRhGAQgASgLMisubW9kZWxzLlByb3RvU3RhdGVBY2NvdW50LlByb3RvQ29udHJhY3REYXRhUgxjb250cmFjdERhdGEaRQoRUHJvdG9Db250cmFjdERhdGESGgoIY29kZUhhc2gYASABKAxSCGNvZGVIYXNoEhQKBXN0YWtlGAIgASgMUgVzdGFrZQ==');
@$core.Deprecated('Use protoStateIdentityDescriptor instead')
const ProtoStateIdentity$json = const {
  '1': 'ProtoStateIdentity',
  '2': const [
    const {'1': 'stake', '3': 1, '4': 1, '5': 12, '10': 'stake'},
    const {'1': 'invites', '3': 2, '4': 1, '5': 13, '10': 'invites'},
    const {'1': 'birthday', '3': 3, '4': 1, '5': 13, '10': 'birthday'},
    const {'1': 'state', '3': 4, '4': 1, '5': 13, '10': 'state'},
    const {'1': 'qualifiedFlips', '3': 5, '4': 1, '5': 13, '10': 'qualifiedFlips'},
    const {'1': 'shortFlipPoints', '3': 6, '4': 1, '5': 13, '10': 'shortFlipPoints'},
    const {'1': 'pubKey', '3': 7, '4': 1, '5': 12, '10': 'pubKey'},
    const {'1': 'requiredFlips', '3': 8, '4': 1, '5': 13, '10': 'requiredFlips'},
    const {'1': 'flips', '3': 9, '4': 3, '5': 11, '6': '.models.ProtoStateIdentity.Flip', '10': 'flips'},
    const {'1': 'generation', '3': 10, '4': 1, '5': 13, '10': 'generation'},
    const {'1': 'code', '3': 11, '4': 1, '5': 12, '10': 'code'},
    const {'1': 'invitees', '3': 12, '4': 3, '5': 11, '6': '.models.ProtoStateIdentity.TxAddr', '10': 'invitees'},
    const {'1': 'inviter', '3': 13, '4': 1, '5': 11, '6': '.models.ProtoStateIdentity.TxAddr', '10': 'inviter'},
    const {'1': 'penalty', '3': 14, '4': 1, '5': 12, '10': 'penalty'},
    const {'1': 'validationBits', '3': 15, '4': 1, '5': 13, '10': 'validationBits'},
    const {'1': 'validationStatus', '3': 16, '4': 1, '5': 13, '10': 'validationStatus'},
    const {'1': 'profileHash', '3': 17, '4': 1, '5': 12, '10': 'profileHash'},
    const {'1': 'scores', '3': 18, '4': 1, '5': 12, '10': 'scores'},
  ],
  '3': const [ProtoStateIdentity_Flip$json, ProtoStateIdentity_TxAddr$json],
};

@$core.Deprecated('Use protoStateIdentityDescriptor instead')
const ProtoStateIdentity_Flip$json = const {
  '1': 'Flip',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'pair', '3': 2, '4': 1, '5': 13, '10': 'pair'},
  ],
};

@$core.Deprecated('Use protoStateIdentityDescriptor instead')
const ProtoStateIdentity_TxAddr$json = const {
  '1': 'TxAddr',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
    const {'1': 'address', '3': 2, '4': 1, '5': 12, '10': 'address'},
  ],
};

/// Descriptor for `ProtoStateIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoStateIdentityDescriptor = $convert.base64Decode('ChJQcm90b1N0YXRlSWRlbnRpdHkSFAoFc3Rha2UYASABKAxSBXN0YWtlEhgKB2ludml0ZXMYAiABKA1SB2ludml0ZXMSGgoIYmlydGhkYXkYAyABKA1SCGJpcnRoZGF5EhQKBXN0YXRlGAQgASgNUgVzdGF0ZRImCg5xdWFsaWZpZWRGbGlwcxgFIAEoDVIOcXVhbGlmaWVkRmxpcHMSKAoPc2hvcnRGbGlwUG9pbnRzGAYgASgNUg9zaG9ydEZsaXBQb2ludHMSFgoGcHViS2V5GAcgASgMUgZwdWJLZXkSJAoNcmVxdWlyZWRGbGlwcxgIIAEoDVINcmVxdWlyZWRGbGlwcxI1CgVmbGlwcxgJIAMoCzIfLm1vZGVscy5Qcm90b1N0YXRlSWRlbnRpdHkuRmxpcFIFZmxpcHMSHgoKZ2VuZXJhdGlvbhgKIAEoDVIKZ2VuZXJhdGlvbhISCgRjb2RlGAsgASgMUgRjb2RlEj0KCGludml0ZWVzGAwgAygLMiEubW9kZWxzLlByb3RvU3RhdGVJZGVudGl0eS5UeEFkZHJSCGludml0ZWVzEjsKB2ludml0ZXIYDSABKAsyIS5tb2RlbHMuUHJvdG9TdGF0ZUlkZW50aXR5LlR4QWRkclIHaW52aXRlchIYCgdwZW5hbHR5GA4gASgMUgdwZW5hbHR5EiYKDnZhbGlkYXRpb25CaXRzGA8gASgNUg52YWxpZGF0aW9uQml0cxIqChB2YWxpZGF0aW9uU3RhdHVzGBAgASgNUhB2YWxpZGF0aW9uU3RhdHVzEiAKC3Byb2ZpbGVIYXNoGBEgASgMUgtwcm9maWxlSGFzaBIWCgZzY29yZXMYEiABKAxSBnNjb3JlcxosCgRGbGlwEhAKA2NpZBgBIAEoDFIDY2lkEhIKBHBhaXIYAiABKA1SBHBhaXIaNgoGVHhBZGRyEhIKBGhhc2gYASABKAxSBGhhc2gSGAoHYWRkcmVzcxgCIAEoDFIHYWRkcmVzcw==');
@$core.Deprecated('Use protoStateGlobalDescriptor instead')
const ProtoStateGlobal$json = const {
  '1': 'ProtoStateGlobal',
  '2': const [
    const {'1': 'epoch', '3': 1, '4': 1, '5': 13, '10': 'epoch'},
    const {'1': 'nextValidationTime', '3': 2, '4': 1, '5': 3, '10': 'nextValidationTime'},
    const {'1': 'validationPeriod', '3': 3, '4': 1, '5': 13, '10': 'validationPeriod'},
    const {'1': 'godAddress', '3': 4, '4': 1, '5': 12, '10': 'godAddress'},
    const {'1': 'wordsSeed', '3': 5, '4': 1, '5': 12, '10': 'wordsSeed'},
    const {'1': 'lastSnapshot', '3': 6, '4': 1, '5': 4, '10': 'lastSnapshot'},
    const {'1': 'epochBlock', '3': 7, '4': 1, '5': 4, '10': 'epochBlock'},
    const {'1': 'feePerGas', '3': 8, '4': 1, '5': 12, '10': 'feePerGas'},
    const {'1': 'vrfProposerThreshold', '3': 9, '4': 1, '5': 4, '10': 'vrfProposerThreshold'},
    const {'1': 'emptyBlocksBits', '3': 10, '4': 1, '5': 12, '10': 'emptyBlocksBits'},
    const {'1': 'godAddressInvites', '3': 11, '4': 1, '5': 13, '10': 'godAddressInvites'},
    const {'1': 'blocksCntWithoutCeremonialTxs', '3': 12, '4': 1, '5': 13, '10': 'blocksCntWithoutCeremonialTxs'},
  ],
};

/// Descriptor for `ProtoStateGlobal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoStateGlobalDescriptor = $convert.base64Decode('ChBQcm90b1N0YXRlR2xvYmFsEhQKBWVwb2NoGAEgASgNUgVlcG9jaBIuChJuZXh0VmFsaWRhdGlvblRpbWUYAiABKANSEm5leHRWYWxpZGF0aW9uVGltZRIqChB2YWxpZGF0aW9uUGVyaW9kGAMgASgNUhB2YWxpZGF0aW9uUGVyaW9kEh4KCmdvZEFkZHJlc3MYBCABKAxSCmdvZEFkZHJlc3MSHAoJd29yZHNTZWVkGAUgASgMUgl3b3Jkc1NlZWQSIgoMbGFzdFNuYXBzaG90GAYgASgEUgxsYXN0U25hcHNob3QSHgoKZXBvY2hCbG9jaxgHIAEoBFIKZXBvY2hCbG9jaxIcCglmZWVQZXJHYXMYCCABKAxSCWZlZVBlckdhcxIyChR2cmZQcm9wb3NlclRocmVzaG9sZBgJIAEoBFIUdnJmUHJvcG9zZXJUaHJlc2hvbGQSKAoPZW1wdHlCbG9ja3NCaXRzGAogASgMUg9lbXB0eUJsb2Nrc0JpdHMSLAoRZ29kQWRkcmVzc0ludml0ZXMYCyABKA1SEWdvZEFkZHJlc3NJbnZpdGVzEkQKHWJsb2Nrc0NudFdpdGhvdXRDZXJlbW9uaWFsVHhzGAwgASgNUh1ibG9ja3NDbnRXaXRob3V0Q2VyZW1vbmlhbFR4cw==');
@$core.Deprecated('Use protoStateApprovedIdentityDescriptor instead')
const ProtoStateApprovedIdentity$json = const {
  '1': 'ProtoStateApprovedIdentity',
  '2': const [
    const {'1': 'approved', '3': 1, '4': 1, '5': 8, '10': 'approved'},
    const {'1': 'online', '3': 2, '4': 1, '5': 8, '10': 'online'},
  ],
};

/// Descriptor for `ProtoStateApprovedIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoStateApprovedIdentityDescriptor = $convert.base64Decode('ChpQcm90b1N0YXRlQXBwcm92ZWRJZGVudGl0eRIaCghhcHByb3ZlZBgBIAEoCFIIYXBwcm92ZWQSFgoGb25saW5lGAIgASgIUgZvbmxpbmU=');
@$core.Deprecated('Use protoStateIdentityStatusSwitchDescriptor instead')
const ProtoStateIdentityStatusSwitch$json = const {
  '1': 'ProtoStateIdentityStatusSwitch',
  '2': const [
    const {'1': 'addresses', '3': 1, '4': 3, '5': 12, '10': 'addresses'},
  ],
};

/// Descriptor for `ProtoStateIdentityStatusSwitch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoStateIdentityStatusSwitchDescriptor = $convert.base64Decode('Ch5Qcm90b1N0YXRlSWRlbnRpdHlTdGF0dXNTd2l0Y2gSHAoJYWRkcmVzc2VzGAEgAygMUglhZGRyZXNzZXM=');
@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState$json = const {
  '1': 'ProtoPredefinedState',
  '2': const [
    const {'1': 'block', '3': 1, '4': 1, '5': 4, '10': 'block'},
    const {'1': 'seed', '3': 2, '4': 1, '5': 12, '10': 'seed'},
    const {'1': 'global', '3': 3, '4': 1, '5': 11, '6': '.models.ProtoPredefinedState.Global', '10': 'global'},
    const {'1': 'statusSwitch', '3': 4, '4': 1, '5': 11, '6': '.models.ProtoPredefinedState.StatusSwitch', '10': 'statusSwitch'},
    const {'1': 'accounts', '3': 5, '4': 3, '5': 11, '6': '.models.ProtoPredefinedState.Account', '10': 'accounts'},
    const {'1': 'identities', '3': 6, '4': 3, '5': 11, '6': '.models.ProtoPredefinedState.Identity', '10': 'identities'},
    const {'1': 'approvedIdentities', '3': 7, '4': 3, '5': 11, '6': '.models.ProtoPredefinedState.ApprovedIdentity', '10': 'approvedIdentities'},
    const {'1': 'contractValues', '3': 8, '4': 3, '5': 11, '6': '.models.ProtoPredefinedState.ContractKeyValue', '10': 'contractValues'},
  ],
  '3': const [ProtoPredefinedState_Global$json, ProtoPredefinedState_StatusSwitch$json, ProtoPredefinedState_Account$json, ProtoPredefinedState_Identity$json, ProtoPredefinedState_ApprovedIdentity$json, ProtoPredefinedState_ContractKeyValue$json],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_Global$json = const {
  '1': 'Global',
  '2': const [
    const {'1': 'epoch', '3': 1, '4': 1, '5': 13, '10': 'epoch'},
    const {'1': 'nextValidationTime', '3': 2, '4': 1, '5': 3, '10': 'nextValidationTime'},
    const {'1': 'validationPeriod', '3': 3, '4': 1, '5': 13, '10': 'validationPeriod'},
    const {'1': 'godAddress', '3': 4, '4': 1, '5': 12, '10': 'godAddress'},
    const {'1': 'wordsSeed', '3': 5, '4': 1, '5': 12, '10': 'wordsSeed'},
    const {'1': 'lastSnapshot', '3': 6, '4': 1, '5': 4, '10': 'lastSnapshot'},
    const {'1': 'epochBlock', '3': 7, '4': 1, '5': 4, '10': 'epochBlock'},
    const {'1': 'feePerGas', '3': 8, '4': 1, '5': 12, '10': 'feePerGas'},
    const {'1': 'vrfProposerThreshold', '3': 9, '4': 1, '5': 4, '10': 'vrfProposerThreshold'},
    const {'1': 'emptyBlocksBits', '3': 10, '4': 1, '5': 12, '10': 'emptyBlocksBits'},
    const {'1': 'godAddressInvites', '3': 11, '4': 1, '5': 13, '10': 'godAddressInvites'},
    const {'1': 'blocksCntWithoutCeremonialTxs', '3': 12, '4': 1, '5': 13, '10': 'blocksCntWithoutCeremonialTxs'},
  ],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_StatusSwitch$json = const {
  '1': 'StatusSwitch',
  '2': const [
    const {'1': 'addresses', '3': 1, '4': 3, '5': 12, '10': 'addresses'},
  ],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_Account$json = const {
  '1': 'Account',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'nonce', '3': 2, '4': 1, '5': 13, '10': 'nonce'},
    const {'1': 'epoch', '3': 3, '4': 1, '5': 13, '10': 'epoch'},
    const {'1': 'balance', '3': 4, '4': 1, '5': 12, '10': 'balance'},
    const {'1': 'contractData', '3': 5, '4': 1, '5': 11, '6': '.models.ProtoPredefinedState.Account.ContractData', '10': 'contractData'},
  ],
  '3': const [ProtoPredefinedState_Account_ContractData$json],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_Account_ContractData$json = const {
  '1': 'ContractData',
  '2': const [
    const {'1': 'codeHash', '3': 1, '4': 1, '5': 12, '10': 'codeHash'},
    const {'1': 'stake', '3': 2, '4': 1, '5': 12, '10': 'stake'},
  ],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_Identity$json = const {
  '1': 'Identity',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'stake', '3': 2, '4': 1, '5': 12, '10': 'stake'},
    const {'1': 'invites', '3': 3, '4': 1, '5': 13, '10': 'invites'},
    const {'1': 'birthday', '3': 4, '4': 1, '5': 13, '10': 'birthday'},
    const {'1': 'state', '3': 5, '4': 1, '5': 13, '10': 'state'},
    const {'1': 'qualifiedFlips', '3': 6, '4': 1, '5': 13, '10': 'qualifiedFlips'},
    const {'1': 'shortFlipPoints', '3': 7, '4': 1, '5': 13, '10': 'shortFlipPoints'},
    const {'1': 'pubKey', '3': 8, '4': 1, '5': 12, '10': 'pubKey'},
    const {'1': 'requiredFlips', '3': 9, '4': 1, '5': 13, '10': 'requiredFlips'},
    const {'1': 'flips', '3': 10, '4': 3, '5': 11, '6': '.models.ProtoPredefinedState.Identity.Flip', '10': 'flips'},
    const {'1': 'generation', '3': 11, '4': 1, '5': 13, '10': 'generation'},
    const {'1': 'code', '3': 12, '4': 1, '5': 12, '10': 'code'},
    const {'1': 'invitees', '3': 13, '4': 3, '5': 11, '6': '.models.ProtoPredefinedState.Identity.TxAddr', '10': 'invitees'},
    const {'1': 'inviter', '3': 14, '4': 1, '5': 11, '6': '.models.ProtoPredefinedState.Identity.TxAddr', '10': 'inviter'},
    const {'1': 'penalty', '3': 15, '4': 1, '5': 12, '10': 'penalty'},
    const {'1': 'validationBits', '3': 16, '4': 1, '5': 13, '10': 'validationBits'},
    const {'1': 'validationStatus', '3': 17, '4': 1, '5': 13, '10': 'validationStatus'},
    const {'1': 'profileHash', '3': 18, '4': 1, '5': 12, '10': 'profileHash'},
    const {'1': 'scores', '3': 19, '4': 1, '5': 12, '10': 'scores'},
  ],
  '3': const [ProtoPredefinedState_Identity_Flip$json, ProtoPredefinedState_Identity_TxAddr$json],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_Identity_Flip$json = const {
  '1': 'Flip',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'pair', '3': 2, '4': 1, '5': 13, '10': 'pair'},
  ],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_Identity_TxAddr$json = const {
  '1': 'TxAddr',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
    const {'1': 'address', '3': 2, '4': 1, '5': 12, '10': 'address'},
  ],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_ApprovedIdentity$json = const {
  '1': 'ApprovedIdentity',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'approved', '3': 2, '4': 1, '5': 8, '10': 'approved'},
    const {'1': 'online', '3': 3, '4': 1, '5': 8, '10': 'online'},
  ],
};

@$core.Deprecated('Use protoPredefinedStateDescriptor instead')
const ProtoPredefinedState_ContractKeyValue$json = const {
  '1': 'ContractKeyValue',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 12, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `ProtoPredefinedState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoPredefinedStateDescriptor = $convert.base64Decode('ChRQcm90b1ByZWRlZmluZWRTdGF0ZRIUCgVibG9jaxgBIAEoBFIFYmxvY2sSEgoEc2VlZBgCIAEoDFIEc2VlZBI7CgZnbG9iYWwYAyABKAsyIy5tb2RlbHMuUHJvdG9QcmVkZWZpbmVkU3RhdGUuR2xvYmFsUgZnbG9iYWwSTQoMc3RhdHVzU3dpdGNoGAQgASgLMikubW9kZWxzLlByb3RvUHJlZGVmaW5lZFN0YXRlLlN0YXR1c1N3aXRjaFIMc3RhdHVzU3dpdGNoEkAKCGFjY291bnRzGAUgAygLMiQubW9kZWxzLlByb3RvUHJlZGVmaW5lZFN0YXRlLkFjY291bnRSCGFjY291bnRzEkUKCmlkZW50aXRpZXMYBiADKAsyJS5tb2RlbHMuUHJvdG9QcmVkZWZpbmVkU3RhdGUuSWRlbnRpdHlSCmlkZW50aXRpZXMSXQoSYXBwcm92ZWRJZGVudGl0aWVzGAcgAygLMi0ubW9kZWxzLlByb3RvUHJlZGVmaW5lZFN0YXRlLkFwcHJvdmVkSWRlbnRpdHlSEmFwcHJvdmVkSWRlbnRpdGllcxJVCg5jb250cmFjdFZhbHVlcxgIIAMoCzItLm1vZGVscy5Qcm90b1ByZWRlZmluZWRTdGF0ZS5Db250cmFjdEtleVZhbHVlUg5jb250cmFjdFZhbHVlcxrsAwoGR2xvYmFsEhQKBWVwb2NoGAEgASgNUgVlcG9jaBIuChJuZXh0VmFsaWRhdGlvblRpbWUYAiABKANSEm5leHRWYWxpZGF0aW9uVGltZRIqChB2YWxpZGF0aW9uUGVyaW9kGAMgASgNUhB2YWxpZGF0aW9uUGVyaW9kEh4KCmdvZEFkZHJlc3MYBCABKAxSCmdvZEFkZHJlc3MSHAoJd29yZHNTZWVkGAUgASgMUgl3b3Jkc1NlZWQSIgoMbGFzdFNuYXBzaG90GAYgASgEUgxsYXN0U25hcHNob3QSHgoKZXBvY2hCbG9jaxgHIAEoBFIKZXBvY2hCbG9jaxIcCglmZWVQZXJHYXMYCCABKAxSCWZlZVBlckdhcxIyChR2cmZQcm9wb3NlclRocmVzaG9sZBgJIAEoBFIUdnJmUHJvcG9zZXJUaHJlc2hvbGQSKAoPZW1wdHlCbG9ja3NCaXRzGAogASgMUg9lbXB0eUJsb2Nrc0JpdHMSLAoRZ29kQWRkcmVzc0ludml0ZXMYCyABKA1SEWdvZEFkZHJlc3NJbnZpdGVzEkQKHWJsb2Nrc0NudFdpdGhvdXRDZXJlbW9uaWFsVHhzGAwgASgNUh1ibG9ja3NDbnRXaXRob3V0Q2VyZW1vbmlhbFR4cxosCgxTdGF0dXNTd2l0Y2gSHAoJYWRkcmVzc2VzGAEgAygMUglhZGRyZXNzZXMaggIKB0FjY291bnQSGAoHYWRkcmVzcxgBIAEoDFIHYWRkcmVzcxIUCgVub25jZRgCIAEoDVIFbm9uY2USFAoFZXBvY2gYAyABKA1SBWVwb2NoEhgKB2JhbGFuY2UYBCABKAxSB2JhbGFuY2USVQoMY29udHJhY3REYXRhGAUgASgLMjEubW9kZWxzLlByb3RvUHJlZGVmaW5lZFN0YXRlLkFjY291bnQuQ29udHJhY3REYXRhUgxjb250cmFjdERhdGEaQAoMQ29udHJhY3REYXRhEhoKCGNvZGVIYXNoGAEgASgMUghjb2RlSGFzaBIUCgVzdGFrZRgCIAEoDFIFc3Rha2UarAYKCElkZW50aXR5EhgKB2FkZHJlc3MYASABKAxSB2FkZHJlc3MSFAoFc3Rha2UYAiABKAxSBXN0YWtlEhgKB2ludml0ZXMYAyABKA1SB2ludml0ZXMSGgoIYmlydGhkYXkYBCABKA1SCGJpcnRoZGF5EhQKBXN0YXRlGAUgASgNUgVzdGF0ZRImCg5xdWFsaWZpZWRGbGlwcxgGIAEoDVIOcXVhbGlmaWVkRmxpcHMSKAoPc2hvcnRGbGlwUG9pbnRzGAcgASgNUg9zaG9ydEZsaXBQb2ludHMSFgoGcHViS2V5GAggASgMUgZwdWJLZXkSJAoNcmVxdWlyZWRGbGlwcxgJIAEoDVINcmVxdWlyZWRGbGlwcxJACgVmbGlwcxgKIAMoCzIqLm1vZGVscy5Qcm90b1ByZWRlZmluZWRTdGF0ZS5JZGVudGl0eS5GbGlwUgVmbGlwcxIeCgpnZW5lcmF0aW9uGAsgASgNUgpnZW5lcmF0aW9uEhIKBGNvZGUYDCABKAxSBGNvZGUSSAoIaW52aXRlZXMYDSADKAsyLC5tb2RlbHMuUHJvdG9QcmVkZWZpbmVkU3RhdGUuSWRlbnRpdHkuVHhBZGRyUghpbnZpdGVlcxJGCgdpbnZpdGVyGA4gASgLMiwubW9kZWxzLlByb3RvUHJlZGVmaW5lZFN0YXRlLklkZW50aXR5LlR4QWRkclIHaW52aXRlchIYCgdwZW5hbHR5GA8gASgMUgdwZW5hbHR5EiYKDnZhbGlkYXRpb25CaXRzGBAgASgNUg52YWxpZGF0aW9uQml0cxIqChB2YWxpZGF0aW9uU3RhdHVzGBEgASgNUhB2YWxpZGF0aW9uU3RhdHVzEiAKC3Byb2ZpbGVIYXNoGBIgASgMUgtwcm9maWxlSGFzaBIWCgZzY29yZXMYEyABKAxSBnNjb3JlcxosCgRGbGlwEhAKA2NpZBgBIAEoDFIDY2lkEhIKBHBhaXIYAiABKA1SBHBhaXIaNgoGVHhBZGRyEhIKBGhhc2gYASABKAxSBGhhc2gSGAoHYWRkcmVzcxgCIAEoDFIHYWRkcmVzcxpgChBBcHByb3ZlZElkZW50aXR5EhgKB2FkZHJlc3MYASABKAxSB2FkZHJlc3MSGgoIYXBwcm92ZWQYAiABKAhSCGFwcHJvdmVkEhYKBm9ubGluZRgDIAEoCFIGb25saW5lGjoKEENvbnRyYWN0S2V5VmFsdWUSEAoDa2V5GAEgASgMUgNrZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVl');
@$core.Deprecated('Use protoCallContractAttachmentDescriptor instead')
const ProtoCallContractAttachment$json = const {
  '1': 'ProtoCallContractAttachment',
  '2': const [
    const {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    const {'1': 'args', '3': 2, '4': 3, '5': 12, '10': 'args'},
  ],
};

/// Descriptor for `ProtoCallContractAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoCallContractAttachmentDescriptor = $convert.base64Decode('ChtQcm90b0NhbGxDb250cmFjdEF0dGFjaG1lbnQSFgoGbWV0aG9kGAEgASgJUgZtZXRob2QSEgoEYXJncxgCIAMoDFIEYXJncw==');
@$core.Deprecated('Use protoDeployContractAttachmentDescriptor instead')
const ProtoDeployContractAttachment$json = const {
  '1': 'ProtoDeployContractAttachment',
  '2': const [
    const {'1': 'CodeHash', '3': 1, '4': 1, '5': 12, '10': 'CodeHash'},
    const {'1': 'args', '3': 2, '4': 3, '5': 12, '10': 'args'},
  ],
};

/// Descriptor for `ProtoDeployContractAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoDeployContractAttachmentDescriptor = $convert.base64Decode('Ch1Qcm90b0RlcGxveUNvbnRyYWN0QXR0YWNobWVudBIaCghDb2RlSGFzaBgBIAEoDFIIQ29kZUhhc2gSEgoEYXJncxgCIAMoDFIEYXJncw==');
@$core.Deprecated('Use protoTerminateContractAttachmentDescriptor instead')
const ProtoTerminateContractAttachment$json = const {
  '1': 'ProtoTerminateContractAttachment',
  '2': const [
    const {'1': 'args', '3': 1, '4': 3, '5': 12, '10': 'args'},
  ],
};

/// Descriptor for `ProtoTerminateContractAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoTerminateContractAttachmentDescriptor = $convert.base64Decode('CiBQcm90b1Rlcm1pbmF0ZUNvbnRyYWN0QXR0YWNobWVudBISCgRhcmdzGAEgAygMUgRhcmdz');
@$core.Deprecated('Use protoTxReceiptsDescriptor instead')
const ProtoTxReceipts$json = const {
  '1': 'ProtoTxReceipts',
  '2': const [
    const {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoTxReceipts.ProtoTxReceipt', '10': 'receipts'},
  ],
  '3': const [ProtoTxReceipts_ProtoTxReceipt$json, ProtoTxReceipts_ProtoEvent$json],
};

@$core.Deprecated('Use protoTxReceiptsDescriptor instead')
const ProtoTxReceipts_ProtoTxReceipt$json = const {
  '1': 'ProtoTxReceipt',
  '2': const [
    const {'1': 'contract', '3': 1, '4': 1, '5': 12, '10': 'contract'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'gasUsed', '3': 3, '4': 1, '5': 4, '10': 'gasUsed'},
    const {'1': 'from', '3': 4, '4': 1, '5': 12, '10': 'from'},
    const {'1': 'error', '3': 5, '4': 1, '5': 9, '10': 'error'},
    const {'1': 'gasCost', '3': 6, '4': 1, '5': 12, '10': 'gasCost'},
    const {'1': 'txHash', '3': 7, '4': 1, '5': 12, '10': 'txHash'},
    const {'1': 'events', '3': 8, '4': 3, '5': 11, '6': '.models.ProtoTxReceipts.ProtoEvent', '10': 'events'},
    const {'1': 'method', '3': 9, '4': 1, '5': 9, '10': 'method'},
  ],
};

@$core.Deprecated('Use protoTxReceiptsDescriptor instead')
const ProtoTxReceipts_ProtoEvent$json = const {
  '1': 'ProtoEvent',
  '2': const [
    const {'1': 'event', '3': 1, '4': 1, '5': 9, '10': 'event'},
    const {'1': 'data', '3': 2, '4': 3, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `ProtoTxReceipts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoTxReceiptsDescriptor = $convert.base64Decode('Cg9Qcm90b1R4UmVjZWlwdHMSQgoIcmVjZWlwdHMYASADKAsyJi5tb2RlbHMuUHJvdG9UeFJlY2VpcHRzLlByb3RvVHhSZWNlaXB0UghyZWNlaXB0cxqQAgoOUHJvdG9UeFJlY2VpcHQSGgoIY29udHJhY3QYASABKAxSCGNvbnRyYWN0EhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHZ2FzVXNlZBgDIAEoBFIHZ2FzVXNlZBISCgRmcm9tGAQgASgMUgRmcm9tEhQKBWVycm9yGAUgASgJUgVlcnJvchIYCgdnYXNDb3N0GAYgASgMUgdnYXNDb3N0EhYKBnR4SGFzaBgHIAEoDFIGdHhIYXNoEjoKBmV2ZW50cxgIIAMoCzIiLm1vZGVscy5Qcm90b1R4UmVjZWlwdHMuUHJvdG9FdmVudFIGZXZlbnRzEhYKBm1ldGhvZBgJIAEoCVIGbWV0aG9kGjYKClByb3RvRXZlbnQSFAoFZXZlbnQYASABKAlSBWV2ZW50EhIKBGRhdGEYAiADKAxSBGRhdGE=');
@$core.Deprecated('Use protoTxReceiptIndexDescriptor instead')
const ProtoTxReceiptIndex$json = const {
  '1': 'ProtoTxReceiptIndex',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'index', '3': 2, '4': 1, '5': 13, '10': 'index'},
  ],
};

/// Descriptor for `ProtoTxReceiptIndex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoTxReceiptIndexDescriptor = $convert.base64Decode('ChNQcm90b1R4UmVjZWlwdEluZGV4EhAKA2NpZBgBIAEoDFIDY2lkEhQKBWluZGV4GAIgASgNUgVpbmRleA==');
@$core.Deprecated('Use protoDeferredTxsDescriptor instead')
const ProtoDeferredTxs$json = const {
  '1': 'ProtoDeferredTxs',
  '2': const [
    const {'1': 'Txs', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoDeferredTxs.ProtoDeferredTx', '10': 'Txs'},
  ],
  '3': const [ProtoDeferredTxs_ProtoDeferredTx$json],
};

@$core.Deprecated('Use protoDeferredTxsDescriptor instead')
const ProtoDeferredTxs_ProtoDeferredTx$json = const {
  '1': 'ProtoDeferredTx',
  '2': const [
    const {'1': 'from', '3': 1, '4': 1, '5': 12, '10': 'from'},
    const {'1': 'to', '3': 2, '4': 1, '5': 12, '10': 'to'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 12, '10': 'amount'},
    const {'1': 'payload', '3': 4, '4': 1, '5': 12, '10': 'payload'},
    const {'1': 'tips', '3': 5, '4': 1, '5': 12, '10': 'tips'},
    const {'1': 'block', '3': 6, '4': 1, '5': 4, '10': 'block'},
  ],
};

/// Descriptor for `ProtoDeferredTxs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoDeferredTxsDescriptor = $convert.base64Decode('ChBQcm90b0RlZmVycmVkVHhzEjoKA1R4cxgBIAMoCzIoLm1vZGVscy5Qcm90b0RlZmVycmVkVHhzLlByb3RvRGVmZXJyZWRUeFIDVHhzGpEBCg9Qcm90b0RlZmVycmVkVHgSEgoEZnJvbRgBIAEoDFIEZnJvbRIOCgJ0bxgCIAEoDFICdG8SFgoGYW1vdW50GAMgASgMUgZhbW91bnQSGAoHcGF5bG9hZBgEIAEoDFIHcGF5bG9hZBISCgR0aXBzGAUgASgMUgR0aXBzEhQKBWJsb2NrGAYgASgEUgVibG9jaw==');
@$core.Deprecated('Use protoSavedEventDescriptor instead')
const ProtoSavedEvent$json = const {
  '1': 'ProtoSavedEvent',
  '2': const [
    const {'1': 'contract', '3': 1, '4': 1, '5': 12, '10': 'contract'},
    const {'1': 'event', '3': 2, '4': 1, '5': 9, '10': 'event'},
    const {'1': 'args', '3': 3, '4': 3, '5': 12, '10': 'args'},
  ],
};

/// Descriptor for `ProtoSavedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoSavedEventDescriptor = $convert.base64Decode('Cg9Qcm90b1NhdmVkRXZlbnQSGgoIY29udHJhY3QYASABKAxSCGNvbnRyYWN0EhQKBWV2ZW50GAIgASgJUgVldmVudBISCgRhcmdzGAMgAygMUgRhcmdz');
@$core.Deprecated('Use protoUpgradeVotesDescriptor instead')
const ProtoUpgradeVotes$json = const {
  '1': 'ProtoUpgradeVotes',
  '2': const [
    const {'1': 'votes', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoUpgradeVotes.ProtoUpgradeVote', '10': 'votes'},
  ],
  '3': const [ProtoUpgradeVotes_ProtoUpgradeVote$json],
};

@$core.Deprecated('Use protoUpgradeVotesDescriptor instead')
const ProtoUpgradeVotes_ProtoUpgradeVote$json = const {
  '1': 'ProtoUpgradeVote',
  '2': const [
    const {'1': 'voter', '3': 1, '4': 1, '5': 12, '10': 'voter'},
    const {'1': 'upgrade', '3': 2, '4': 1, '5': 13, '10': 'upgrade'},
  ],
};

/// Descriptor for `ProtoUpgradeVotes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpgradeVotesDescriptor = $convert.base64Decode('ChFQcm90b1VwZ3JhZGVWb3RlcxJACgV2b3RlcxgBIAMoCzIqLm1vZGVscy5Qcm90b1VwZ3JhZGVWb3Rlcy5Qcm90b1VwZ3JhZGVWb3RlUgV2b3RlcxpCChBQcm90b1VwZ3JhZGVWb3RlEhQKBXZvdGVyGAEgASgMUgV2b3RlchIYCgd1cGdyYWRlGAIgASgNUgd1cGdyYWRl');
