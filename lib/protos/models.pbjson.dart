///
//  Generated code. Do not modify.
//  source: models.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const ProtoTransaction$json = const {
  '1': 'ProtoTransaction',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoTransaction.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
    const {'1': 'useRlp', '3': 3, '4': 1, '5': 8, '10': 'useRlp'},
  ],
  '3': const [ProtoTransaction_Data$json],
};

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

const ProtoBlockHeader$json = const {
  '1': 'ProtoBlockHeader',
  '2': const [
    const {'1': 'proposedHeader', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader.Proposed', '10': 'proposedHeader'},
    const {'1': 'emptyHeader', '3': 2, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader.Empty', '10': 'emptyHeader'},
  ],
  '3': const [ProtoBlockHeader_Proposed$json, ProtoBlockHeader_Empty$json],
};

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

const ProtoBlockBody$json = const {
  '1': 'ProtoBlockBody',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoTransaction', '10': 'transactions'},
  ],
};

const ProtoBlock$json = const {
  '1': 'ProtoBlock',
  '2': const [
    const {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader', '10': 'header'},
    const {'1': 'body', '3': 2, '4': 1, '5': 11, '6': '.models.ProtoBlockBody', '10': 'body'},
  ],
};

const ProtoBlockProposal$json = const {
  '1': 'ProtoBlockProposal',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockProposal.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoBlockProposal_Data$json],
};

const ProtoBlockProposal_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader', '10': 'header'},
    const {'1': 'body', '3': 2, '4': 1, '5': 11, '6': '.models.ProtoBlockBody', '10': 'body'},
    const {'1': 'proof', '3': 3, '4': 1, '5': 12, '10': 'proof'},
  ],
};

const ProtoIpfsFlip$json = const {
  '1': 'ProtoIpfsFlip',
  '2': const [
    const {'1': 'pubKey', '3': 1, '4': 1, '5': 12, '10': 'pubKey'},
    const {'1': 'publicPart', '3': 2, '4': 1, '5': 12, '10': 'publicPart'},
    const {'1': 'privatePart', '3': 3, '4': 1, '5': 12, '10': 'privatePart'},
  ],
};

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

const ProtoBlockCert_Signature$json = const {
  '1': 'Signature',
  '2': const [
    const {'1': 'turnOffline', '3': 1, '4': 1, '5': 8, '10': 'turnOffline'},
    const {'1': 'upgrade', '3': 2, '4': 1, '5': 13, '10': 'upgrade'},
    const {'1': 'signature', '3': 3, '4': 1, '5': 12, '10': 'signature'},
  ],
};

const ProtoWeakCertificates$json = const {
  '1': 'ProtoWeakCertificates',
  '2': const [
    const {'1': 'hashes', '3': 1, '4': 3, '5': 12, '10': 'hashes'},
  ],
};

const ProtoTransactionIndex$json = const {
  '1': 'ProtoTransactionIndex',
  '2': const [
    const {'1': 'blockHash', '3': 1, '4': 1, '5': 12, '10': 'blockHash'},
    const {'1': 'idx', '3': 2, '4': 1, '5': 13, '10': 'idx'},
  ],
};

const ProtoFlipPrivateKeys$json = const {
  '1': 'ProtoFlipPrivateKeys',
  '2': const [
    const {'1': 'keys', '3': 1, '4': 3, '5': 12, '10': 'keys'},
  ],
};

const ProtoProfile$json = const {
  '1': 'ProtoProfile',
  '2': const [
    const {'1': 'nickname', '3': 1, '4': 1, '5': 12, '10': 'nickname'},
    const {'1': 'info', '3': 2, '4': 1, '5': 12, '10': 'info'},
  ],
};

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

const ProtoMsg$json = const {
  '1': 'ProtoMsg',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 4, '10': 'code'},
    const {'1': 'payload', '3': 2, '4': 1, '5': 12, '10': 'payload'},
  ],
};

const ProtoIdentityStateDiff$json = const {
  '1': 'ProtoIdentityStateDiff',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoIdentityStateDiff.IdentityStateDiffValue', '10': 'values'},
  ],
  '3': const [ProtoIdentityStateDiff_IdentityStateDiffValue$json],
};

const ProtoIdentityStateDiff_IdentityStateDiffValue$json = const {
  '1': 'IdentityStateDiffValue',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'deleted', '3': 2, '4': 1, '5': 8, '10': 'deleted'},
    const {'1': 'value', '3': 3, '4': 1, '5': 12, '10': 'value'},
  ],
};

const ProtoSnapshotBlock$json = const {
  '1': 'ProtoSnapshotBlock',
  '2': const [
    const {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoSnapshotBlock.KeyValue', '10': 'data'},
  ],
  '3': const [ProtoSnapshotBlock_KeyValue$json],
};

const ProtoSnapshotBlock_KeyValue$json = const {
  '1': 'KeyValue',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 12, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

const ProtoGossipBlockRange$json = const {
  '1': 'ProtoGossipBlockRange',
  '2': const [
    const {'1': 'batchId', '3': 1, '4': 1, '5': 13, '10': 'batchId'},
    const {'1': 'blocks', '3': 2, '4': 3, '5': 11, '6': '.models.ProtoGossipBlockRange.Block', '10': 'blocks'},
  ],
  '3': const [ProtoGossipBlockRange_Block$json],
};

const ProtoGossipBlockRange_Block$json = const {
  '1': 'Block',
  '2': const [
    const {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoBlockHeader', '10': 'header'},
    const {'1': 'cert', '3': 2, '4': 1, '5': 11, '6': '.models.ProtoBlockCert', '10': 'cert'},
    const {'1': 'diff', '3': 3, '4': 1, '5': 11, '6': '.models.ProtoIdentityStateDiff', '10': 'diff'},
  ],
};

const ProtoProposeProof$json = const {
  '1': 'ProtoProposeProof',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoProposeProof.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoProposeProof_Data$json],
};

const ProtoProposeProof_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'proof', '3': 1, '4': 1, '5': 12, '10': 'proof'},
    const {'1': 'round', '3': 2, '4': 1, '5': 4, '10': 'round'},
  ],
};

const ProtoVote$json = const {
  '1': 'ProtoVote',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoVote.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoVote_Data$json],
};

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

const ProtoGetBlockByHashRequest$json = const {
  '1': 'ProtoGetBlockByHashRequest',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
  ],
};

const ProtoGetBlocksRangeRequest$json = const {
  '1': 'ProtoGetBlocksRangeRequest',
  '2': const [
    const {'1': 'batchId', '3': 1, '4': 1, '5': 13, '10': 'batchId'},
    const {'1': 'from', '3': 2, '4': 1, '5': 4, '10': 'from'},
    const {'1': 'to', '3': 3, '4': 1, '5': 4, '10': 'to'},
  ],
};

const ProtoGetForkBlockRangeRequest$json = const {
  '1': 'ProtoGetForkBlockRangeRequest',
  '2': const [
    const {'1': 'batchId', '3': 1, '4': 1, '5': 13, '10': 'batchId'},
    const {'1': 'blocks', '3': 2, '4': 3, '5': 12, '10': 'blocks'},
  ],
};

const ProtoFlip$json = const {
  '1': 'ProtoFlip',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoTransaction', '10': 'transaction'},
    const {'1': 'publicPart', '3': 2, '4': 1, '5': 12, '10': 'publicPart'},
    const {'1': 'privatePart', '3': 3, '4': 1, '5': 12, '10': 'privatePart'},
  ],
};

const ProtoFlipKey$json = const {
  '1': 'ProtoFlipKey',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoFlipKey.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoFlipKey_Data$json],
};

const ProtoFlipKey_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 12, '10': 'key'},
    const {'1': 'epoch', '3': 2, '4': 1, '5': 13, '10': 'epoch'},
  ],
};

const ProtoManifest$json = const {
  '1': 'ProtoManifest',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'root', '3': 3, '4': 1, '5': 12, '10': 'root'},
  ],
};

const ProtoPrivateFlipKeysPackage$json = const {
  '1': 'ProtoPrivateFlipKeysPackage',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoPrivateFlipKeysPackage.Data', '10': 'data'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
  '3': const [ProtoPrivateFlipKeysPackage_Data$json],
};

const ProtoPrivateFlipKeysPackage_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'package', '3': 1, '4': 1, '5': 12, '10': 'package'},
    const {'1': 'epoch', '3': 2, '4': 1, '5': 13, '10': 'epoch'},
  ],
};

const ProtoPullPushHash$json = const {
  '1': 'ProtoPullPushHash',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 13, '10': 'type'},
    const {'1': 'hash', '3': 2, '4': 1, '5': 12, '10': 'hash'},
  ],
};

const ProtoSnapshotManifestDb$json = const {
  '1': 'ProtoSnapshotManifestDb',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'fileName', '3': 3, '4': 1, '5': 9, '10': 'fileName'},
    const {'1': 'root', '3': 4, '4': 1, '5': 12, '10': 'root'},
  ],
};

const ProtoShortAnswerDb$json = const {
  '1': 'ProtoShortAnswerDb',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

const ProtoAnswersDb$json = const {
  '1': 'ProtoAnswersDb',
  '2': const [
    const {'1': 'answers', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoAnswersDb.Answer', '10': 'answers'},
  ],
  '3': const [ProtoAnswersDb_Answer$json],
};

const ProtoAnswersDb_Answer$json = const {
  '1': 'Answer',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'answers', '3': 2, '4': 1, '5': 12, '10': 'answers'},
  ],
};

const ProtoBurntCoins$json = const {
  '1': 'ProtoBurntCoins',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'key', '3': 2, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 12, '10': 'amount'},
  ],
};

const ProtoSavedTransaction$json = const {
  '1': 'ProtoSavedTransaction',
  '2': const [
    const {'1': 'tx', '3': 1, '4': 1, '5': 11, '6': '.models.ProtoTransaction', '10': 'tx'},
    const {'1': 'feePerGas', '3': 2, '4': 1, '5': 12, '10': 'feePerGas'},
    const {'1': 'blockHash', '3': 3, '4': 1, '5': 12, '10': 'blockHash'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

const ProtoActivityMonitor$json = const {
  '1': 'ProtoActivityMonitor',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'activities', '3': 2, '4': 3, '5': 11, '6': '.models.ProtoActivityMonitor.Activity', '10': 'activities'},
  ],
  '3': const [ProtoActivityMonitor_Activity$json],
};

const ProtoActivityMonitor_Activity$json = const {
  '1': 'Activity',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

const ProtoShortAnswerAttachment$json = const {
  '1': 'ProtoShortAnswerAttachment',
  '2': const [
    const {'1': 'answers', '3': 1, '4': 1, '5': 12, '10': 'answers'},
    const {'1': 'rnd', '3': 2, '4': 1, '5': 4, '10': 'rnd'},
  ],
};

const ProtoLongAnswerAttachment$json = const {
  '1': 'ProtoLongAnswerAttachment',
  '2': const [
    const {'1': 'answers', '3': 1, '4': 1, '5': 12, '10': 'answers'},
    const {'1': 'proof', '3': 2, '4': 1, '5': 12, '10': 'proof'},
    const {'1': 'key', '3': 3, '4': 1, '5': 12, '10': 'key'},
    const {'1': 'salt', '3': 4, '4': 1, '5': 12, '10': 'salt'},
  ],
};

const ProtoFlipSubmitAttachment$json = const {
  '1': 'ProtoFlipSubmitAttachment',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'pair', '3': 2, '4': 1, '5': 13, '10': 'pair'},
  ],
};

const ProtoOnlineStatusAttachment$json = const {
  '1': 'ProtoOnlineStatusAttachment',
  '2': const [
    const {'1': 'online', '3': 1, '4': 1, '5': 8, '10': 'online'},
  ],
};

const ProtoBurnAttachment$json = const {
  '1': 'ProtoBurnAttachment',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
  ],
};

const ProtoChangeProfileAttachment$json = const {
  '1': 'ProtoChangeProfileAttachment',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
  ],
};

const ProtoDeleteFlipAttachment$json = const {
  '1': 'ProtoDeleteFlipAttachment',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
  ],
};

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

const ProtoStateAccount_ProtoContractData$json = const {
  '1': 'ProtoContractData',
  '2': const [
    const {'1': 'codeHash', '3': 1, '4': 1, '5': 12, '10': 'codeHash'},
    const {'1': 'stake', '3': 2, '4': 1, '5': 12, '10': 'stake'},
  ],
};

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

const ProtoStateIdentity_Flip$json = const {
  '1': 'Flip',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'pair', '3': 2, '4': 1, '5': 13, '10': 'pair'},
  ],
};

const ProtoStateIdentity_TxAddr$json = const {
  '1': 'TxAddr',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
    const {'1': 'address', '3': 2, '4': 1, '5': 12, '10': 'address'},
  ],
};

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

const ProtoStateApprovedIdentity$json = const {
  '1': 'ProtoStateApprovedIdentity',
  '2': const [
    const {'1': 'approved', '3': 1, '4': 1, '5': 8, '10': 'approved'},
    const {'1': 'online', '3': 2, '4': 1, '5': 8, '10': 'online'},
  ],
};

const ProtoStateIdentityStatusSwitch$json = const {
  '1': 'ProtoStateIdentityStatusSwitch',
  '2': const [
    const {'1': 'addresses', '3': 1, '4': 3, '5': 12, '10': 'addresses'},
  ],
};

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

const ProtoPredefinedState_StatusSwitch$json = const {
  '1': 'StatusSwitch',
  '2': const [
    const {'1': 'addresses', '3': 1, '4': 3, '5': 12, '10': 'addresses'},
  ],
};

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

const ProtoPredefinedState_Account_ContractData$json = const {
  '1': 'ContractData',
  '2': const [
    const {'1': 'codeHash', '3': 1, '4': 1, '5': 12, '10': 'codeHash'},
    const {'1': 'stake', '3': 2, '4': 1, '5': 12, '10': 'stake'},
  ],
};

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

const ProtoPredefinedState_Identity_Flip$json = const {
  '1': 'Flip',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'pair', '3': 2, '4': 1, '5': 13, '10': 'pair'},
  ],
};

const ProtoPredefinedState_Identity_TxAddr$json = const {
  '1': 'TxAddr',
  '2': const [
    const {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
    const {'1': 'address', '3': 2, '4': 1, '5': 12, '10': 'address'},
  ],
};

const ProtoPredefinedState_ApprovedIdentity$json = const {
  '1': 'ApprovedIdentity',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 12, '10': 'address'},
    const {'1': 'approved', '3': 2, '4': 1, '5': 8, '10': 'approved'},
    const {'1': 'online', '3': 3, '4': 1, '5': 8, '10': 'online'},
  ],
};

const ProtoPredefinedState_ContractKeyValue$json = const {
  '1': 'ContractKeyValue',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 12, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

const ProtoCallContractAttachment$json = const {
  '1': 'ProtoCallContractAttachment',
  '2': const [
    const {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    const {'1': 'args', '3': 2, '4': 3, '5': 12, '10': 'args'},
  ],
};

const ProtoDeployContractAttachment$json = const {
  '1': 'ProtoDeployContractAttachment',
  '2': const [
    const {'1': 'CodeHash', '3': 1, '4': 1, '5': 12, '10': 'CodeHash'},
    const {'1': 'args', '3': 2, '4': 3, '5': 12, '10': 'args'},
  ],
};

const ProtoTerminateContractAttachment$json = const {
  '1': 'ProtoTerminateContractAttachment',
  '2': const [
    const {'1': 'args', '3': 1, '4': 3, '5': 12, '10': 'args'},
  ],
};

const ProtoTxReceipts$json = const {
  '1': 'ProtoTxReceipts',
  '2': const [
    const {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoTxReceipts.ProtoTxReceipt', '10': 'receipts'},
  ],
  '3': const [ProtoTxReceipts_ProtoTxReceipt$json, ProtoTxReceipts_ProtoEvent$json],
};

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

const ProtoTxReceipts_ProtoEvent$json = const {
  '1': 'ProtoEvent',
  '2': const [
    const {'1': 'event', '3': 1, '4': 1, '5': 9, '10': 'event'},
    const {'1': 'data', '3': 2, '4': 3, '5': 12, '10': 'data'},
  ],
};

const ProtoTxReceiptIndex$json = const {
  '1': 'ProtoTxReceiptIndex',
  '2': const [
    const {'1': 'cid', '3': 1, '4': 1, '5': 12, '10': 'cid'},
    const {'1': 'index', '3': 2, '4': 1, '5': 13, '10': 'index'},
  ],
};

const ProtoDeferredTxs$json = const {
  '1': 'ProtoDeferredTxs',
  '2': const [
    const {'1': 'Txs', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoDeferredTxs.ProtoDeferredTx', '10': 'Txs'},
  ],
  '3': const [ProtoDeferredTxs_ProtoDeferredTx$json],
};

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

const ProtoSavedEvent$json = const {
  '1': 'ProtoSavedEvent',
  '2': const [
    const {'1': 'contract', '3': 1, '4': 1, '5': 12, '10': 'contract'},
    const {'1': 'event', '3': 2, '4': 1, '5': 9, '10': 'event'},
    const {'1': 'args', '3': 3, '4': 3, '5': 12, '10': 'args'},
  ],
};

const ProtoUpgradeVotes$json = const {
  '1': 'ProtoUpgradeVotes',
  '2': const [
    const {'1': 'votes', '3': 1, '4': 3, '5': 11, '6': '.models.ProtoUpgradeVotes.ProtoUpgradeVote', '10': 'votes'},
  ],
  '3': const [ProtoUpgradeVotes_ProtoUpgradeVote$json],
};

const ProtoUpgradeVotes_ProtoUpgradeVote$json = const {
  '1': 'ProtoUpgradeVote',
  '2': const [
    const {'1': 'voter', '3': 1, '4': 1, '5': 12, '10': 'voter'},
    const {'1': 'upgrade', '3': 2, '4': 1, '5': 13, '10': 'upgrade'},
  ],
};

