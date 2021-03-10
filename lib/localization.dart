import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/model/available_language.dart';

import 'l10n/messages_all.dart';

/// Localization
class AppLocalization {
  static Locale currentLocale = Locale('en', 'US');

  static Future<AppLocalization> load(Locale locale) {
    currentLocale = locale;
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  /// -- GENERIC ITEMS
  String get cancel {
    return Intl.message('Cancel', desc: 'dialog_cancel', name: 'cancel');
  }

  String get close {
    return Intl.message('Close', desc: 'dialog_close', name: 'close');
  }

  String get confirm {
    return Intl.message('Confirm', desc: 'dialog_confirm', name: 'confirm');
  }

  String get no {
    return Intl.message('No', desc: 'intro_new_wallet_backup_no', name: 'no');
  }

  String get yes {
    return Intl.message('Yes',
        desc: 'intro_new_wallet_backup_yes', name: 'yes');
  }

  String get onStr {
    return Intl.message('On', desc: 'generic_on', name: 'onStr');
  }

  String get off {
    return Intl.message('Off', desc: 'generic_off', name: 'off');
  }

  String get send {
    return Intl.message('Send', desc: 'home_send_cta', name: 'send');
  }

  String get receive {
    return Intl.message('Receive', desc: 'home_receive_cta', name: 'receive');
  }

  String get sent {
    return Intl.message('Sent', desc: 'history_sent', name: 'sent');
  }

  String get received {
    return Intl.message('Received', desc: 'history_received', name: 'received');
  }

  String get transactions {
    return Intl.message('Tx', desc: 'transaction_header', name: 'transactions');
  }

  String get addressCopied {
    return Intl.message('Address Copied',
        desc: 'receive_copied', name: 'addressCopied');
  }

  String get copyAddress {
    return Intl.message('Copy Address',
        desc: 'receive_copy_cta', name: 'copyAddress');
  }

  String get addressShare {
    return Intl.message('Share Address',
        desc: 'receive_share_cta', name: 'addressShare');
  }

  String get addressHint {
    return Intl.message('Enter Address',
        desc: 'send_address_hint', name: 'addressHint');
  }

  String get seed {
    return Intl.message('Seed',
        desc: 'intro_new_wallet_seed_header', name: 'seed');
  }

  String get seedInvalid {
    return Intl.message('Seed is Invalid',
        desc: 'intro_seed_invalid', name: 'seedInvalid');
  }

  String get seedCopied {
    return Intl.message(
        'Seed Copied to Clipboard\nIt is pasteable for 2 minutes.',
        desc: 'intro_new_wallet_seed_copied',
        name: 'seedCopied');
  }

  String get scanQrCode {
    return Intl.message('Scan QR Code',
        desc: 'send_scan_qr', name: 'scanQrCode');
  }

  String get qrInvalidSeed {
    return Intl.message("QR code does not contain a valid seed or private key",
        desc: "qr_invalid_seed", name: 'qrInvalidSeed');
  }

  String get qrInvalidAddress {
    return Intl.message("QR code does not contain a valid destination",
        desc: "qr_invalid_address", name: 'qrInvalidAddress');
  }

  String get qrInvalidPermissions {
    return Intl.message("Please Grant Camera Permissions to scan QR Codes",
        desc: "User did not grant camera permissions to the app",
        name: "qrInvalidPermissions");
  }

  String get qrUnknownError {
    return Intl.message("Could not Read QR Code",
        desc: "An unknown error occurred with the QR scanner",
        name: "qrUnknownError");
  }

  /// -- END GENERIC ITEMS

  /// -- CHART
  String get chartHeader {
    return Intl.message('Chart', desc: '', name: 'chartHeader');
  }

  String get chartDate {
    return Intl.message('Date', desc: '', name: 'chartDate');
  }

  String get chartPrice {
    return Intl.message('Price', desc: '', name: 'chartPrice');
  }

  String get chartVolume {
    return Intl.message('Volume', desc: '', name: 'chartVolume');
  }

  /// -- END CHART

  /// -- DEEP LINKS
  String get signinConfirmation {
    return Intl.message('Signin confirmation',
        desc: '', name: 'signinConfirmation');
  }

  /// -- DEEP LINKS END

  /// -- CONTACT ITEMS

  String get removeContact {
    return Intl.message('Remove Contact',
        desc: 'contact_remove_btn', name: 'removeContact');
  }

  String get removeContactConfirmation {
    return Intl.message('Are you sure you want to delete %1?',
        desc: 'contact_remove_sure', name: 'removeContactConfirmation');
  }

  String get contactHeader {
    return Intl.message('Contact',
        desc: 'contact_view_header', name: 'contactHeader');
  }

  String get contactsHeader {
    return Intl.message('Contacts',
        desc: 'contact_header', name: 'contactsHeader');
  }

  String get addContact {
    return Intl.message('Add Contact',
        desc: 'contact_add_button', name: 'addContact');
  }

  String get contactNameHint {
    return Intl.message('Enter a Name @',
        desc: 'contact_name_hint', name: 'contactNameHint');
  }

  String get contactInvalid {
    return Intl.message("Invalid Contact Name",
        desc: 'contact_invalid_name', name: 'contactInvalid');
  }

  String get contactAdded {
    return Intl.message("%1 added to contacts.",
        desc: 'contact_added', name: 'contactAdded');
  }

  String get contactRemoved {
    return Intl.message("%1 has been removed from contacts!",
        desc: 'contact_removed', name: 'contactRemoved');
  }

  String get contactNameMissing {
    return Intl.message("Choose a Name for this Contact",
        desc: 'contact_name_missing', name: 'contactNameMissing');
  }

  String get contactExists {
    return Intl.message("Contact Already Exists",
        desc: 'contact_name_exists', name: 'contactExists');
  }

  /// -- END CONTACT ITEMS

  /// -- CONFIGURE NODE
  String get configureAccessNodeHeader {
    return Intl.message("Configure your access",
        desc: '', name: 'configureAccessNodeHeader');
  }

  String get enterApiUrl {
    return Intl.message("Enter your node address", desc: '', name: 'enterApiUrl');
  }

  String get enterDemoMode {
    return Intl.message("Demo mode activation ?",
        desc: '', name: 'enterDemoMode');
  }

  String get enterSharedNode {
    return Intl.message("Access to a Shared Node ?",
        desc: '', name: 'enterSharedNode');
  }

  String get enterKeyApp {
    return Intl.message("Enter your api key", desc: '', name: 'enterKeyApp');
  }

  String get enterOperator {
    return Intl.message("Enter your shared node URL", desc: '', name: 'enterOperator');
  }

  String get enterEncryptedPk {
    return Intl.message("Enter your encrypted private key",
        desc: '', name: 'enterEncryptedPk');
  }

  String get enterPasswordPk {
    return Intl.message("Enter your password",
        desc: '', name: 'enterPasswordPk');
  }

  String get enterVps {
    return Intl.message("Access to a VPS ?", desc: '', name: 'enterVps');
  }

  String get enterPublicNode {
    return Intl.message("Access to a Public Node ?",
        desc: '', name: 'enterPublicNode');
  }

  String get enterVpsUser {
    return Intl.message("Enter a VPS user", desc: '', name: 'enterVpsUser');
  }

  String get enterVpsIp {
    return Intl.message("Enter the VPS IP Address", desc: '', name: 'enterVpsIp');
  }

  String get enterVpsTunnel {
    return Intl.message("Enter the node address",
        desc: '', name: 'enterVpsTunnel');
  }

  String get enterVpsPassword {
    return Intl.message("Enter the VPS user password",
        desc: '', name: 'enterVpsPassword');
  }

  String get enterVpsTunnelExample {
    return Intl.message("e.g.: 'http://localhost:9009' with http or https",
        desc: '', name: 'enterVpsTunnelExample');
  }

  String get enterVpsIpExample {
    return Intl.message("e.g.: '11.22.33.44:22'",
        desc: '', name: 'enterVpsIpExample');
  }

  String get enterVpsUserExample {
    return Intl.message("e.g.: 'root'", desc: '', name: 'enterVpsUserExample');
  }

  String get enterOperatorExample {
    return Intl.message("e.g.: 'https://node.idena.io'",
        desc: '', name: 'enterOperatorExample');
  }

  String get apiUrlMissing {
    return Intl.message("Please Enter your node address",
        desc: '', name: 'apiUrlMissing');
  }

  String get operatorMissing {
    return Intl.message("Please Enter your shared node URL",
        desc: '', name: 'operatorMissing');
  }

  String get encryptedPkMissing {
    return Intl.message("Please Enter your encrypted private key",
        desc: '', name: 'encryptedPkMissing');
  }

  String get passwordPkMissing {
    return Intl.message("Please Enter your password",
        desc: '', name: 'passwordPkMissing');
  }

  String get wrongApiUrl {
    return Intl.message("The node address is not an url valid",
        desc: '', name: 'wrongApiUrl');
  }

  String get keyAppMissing {
    return Intl.message("Please Enter your api key",
        desc: '', name: 'keyAppMissing');
  }

  /// -- AND CONFIGURE NODE

  /// -- INTRO ITEMS
  String get backupYourSeed {
    return Intl.message('Backup your seed',
        desc: 'intro_new_wallet_seed_backup_header', name: 'backupYourSeed');
  }

  String get backupSeedConfirm {
    return Intl.message('Are you sure that you have backed up your wallet seed?',
        desc: 'intro_new_wallet_backup', name: 'backupSeedConfirm');
  }

  String get seedBackupInfo {
    return Intl.message(
        "Below is your wallet's seed. It is crucial that you backup your seed and never store it as plaintext or a screenshot.",
        desc: 'intro_new_wallet_seed',
        name: 'seedBackupInfo');
  }

  String get copySeed {
    return Intl.message("Copy Seed", desc: 'copy_seed_btn', name: 'copySeed');
  }

  String get seedCopiedShort {
    return Intl.message("Seed Copied",
        desc: 'seed_copied_btn', name: 'seedCopiedShort');
  }

  String get importSeed {
    return Intl.message("Import Seed",
        desc: 'intro_seed_header', name: 'importSeed');
  }

  String get importSeedHint {
    return Intl.message("Please enter your seed below.",
        desc: 'intro_seed_info', name: 'importSeedHint');
  }

  String get newSeed {
    return Intl.message("New Seed",
        desc: 'intro_welcome_new_seed', name: 'newSeed');
  }

  String get newAccount {
    return Intl.message("New Account",
        desc: 'intro_welcome_new_account', name: 'newAccount');
  }

  String get newAccountInfoDerivationPath {
    return Intl.message(
        "Please note, the address that will be generated for your new account will use type 515 for derive path and not type 60 dedicated to Ether (cf: Registered coin types for BIP-0044).",
        desc: 'intro_welcome_new_account',
        name: 'newAccountInfoDerivationPath');
  }

  String get enterSeedFrom {
    return Intl.message(
        "Please specify the origin of your seed (HD Wallet / Paper Wallet).",
        desc: '',
        name: 'enterSeedFrom');
  }

  String get displaySeedOrigin {
    return Intl.message("Origin : ", desc: '', name: 'displaySeedOrigin');
  }

  String get addressUnknown {
    return Intl.message("Address unknown", desc: '', name: 'addressUnknown');
  }

  String get ackBackedUp {
    return Intl.message(
        "Are you sure that you've backed up your secret phrase or seed?",
        desc: 'Ack backed up',
        name: 'ackBackedUp');
  }

  String get secretWarning {
    return Intl.message(
        "If you lose your device or uninstall the application, you'll need your secret phrase or seed to recover your funds!",
        desc: 'Secret warning',
        name: 'secretWarning');
  }

  String get welcomeText {
    return Intl.message(
        "Welcome to my Idena. To begin, you need configure the access to your Idena node.",
        desc: 'intro_welcome_title',
        name: 'welcomeText');
  }

  String get configureNode {
    return Intl.message("Configure node",
        desc: 'intro_welcome_configure_node', name: 'configureNode');
  }

  /// -- END INTRO ITEMS

  /// -- TRANSACTION DETAILS

  String get transactionDetailBlock {
    return Intl.message('Block',
        desc: 'transaction_detail', name: 'transactionDetailBlock');
  }

  String get transactionDetailDate {
    return Intl.message('Date',
        desc: 'transaction_detail', name: 'transactionDetailDate');
  }

  String get transactionDetailFrom {
    return Intl.message('From address',
        desc: 'transaction_detail', name: 'transactionDetailFrom');
  }

  String get transactionDetailTo {
    return Intl.message('To address',
        desc: 'transaction_detail', name: 'transactionDetailTo');
  }

  String get transactionDetailTxId {
    return Intl.message('Transaction id',
        desc: 'transaction_detail', name: 'transactionDetailTxId');
  }

  String get transactionDetailAmount {
    return Intl.message('Amount',
        desc: 'transaction_detail', name: 'transactionDetailAmount');
  }

  String get transactionDetailFee {
    return Intl.message('Fee',
        desc: 'transaction_detail', name: 'transactionDetailFee');
  }

  String get transactionDetailReward {
    return Intl.message('Reward',
        desc: 'transaction_detail', name: 'transactionDetailReward');
  }

  String get transactionDetailPayload {
    return Intl.message('Payload',
        desc: 'transaction_detail', name: 'transactionDetailPayload');
  }

  String get transactionDetailCopyPaste {
    return Intl.message('Double click on text to copy to clipboard',
        desc: 'transaction_detail', name: 'transactionDetailCopyPaste');
  }

  String get transactionDetailUnconfirmed {
    return Intl.message('Unconfirmed',
        desc: 'transaction_detail', name: 'transactionDetailUnconfirmed');
  }

  ///

  /// -- SEND ITEMS
  String get sentTo {
    return Intl.message("Sent To", desc: 'sent_to', name: 'sentTo');
  }

  String get sending {
    return Intl.message("Sending", desc: 'send_sending', name: 'sending');
  }

  String get to {
    return Intl.message("To", desc: 'send_to', name: 'to');
  }

  String get sendAmountConfirm {
    return Intl.message("Send %1 iDNA",
        desc: 'send_pin_description', name: 'sendAmountConfirm');
  }

  String get sendAmountConfirmPin {
    return sendAmountConfirm;
  }

  String get sendError {
    return Intl.message("An error occurred. Try again later.",
        desc: 'send_generic_error', name: 'sendError');
  }

  String get enterAmount {
    return Intl.message("Enter Amount",
        desc: 'send_amount_hint', name: 'enterAmount');
  }

  String get enterAddress {
    return Intl.message("Enter Address",
        desc: 'enter_address', name: 'enterAddress');
  }

  String get enterTokenQuantity {
    return Intl.message("Enter Quantity",
        desc: 'send_enterTokenQuantity_hint', name: 'enterTokenQuantity');
  }

  String get sendATokenQuestion {
    return Intl.message("Send a token ?",
        desc: 'sendATokenQuestion_hint', name: 'sendATokenQuestion');
  }

  String get available {
    return Intl.message("available", desc: 'available', name: 'available');
  }

  String get optionalParameters {
    return Intl.message("Optional Parameters",
        desc: 'optionalParameters', name: 'optionalParameters');
  }

  String get invalidAddress {
    return Intl.message("Address entered was invalid",
        desc: 'send_invalid_address', name: 'invalidAddress');
  }

  String get addressMising {
    return Intl.message("Please Enter an Address",
        desc: 'send_enter_address', name: 'addressMising');
  }

  String get amountMissing {
    return Intl.message("Please Enter an Amount",
        desc: 'send_enter_amount', name: 'amountMissing');
  }

  String get tokenQuantityMissing {
    return Intl.message("Please Enter a Quantity",
        desc: 'send_enter_token_quantity', name: 'tokenQuantityMissing');
  }

  String get tokenMissing {
    return Intl.message("Please choose a Token",
        desc: 'send_enter_token', name: 'tokenMissing');
  }

  String get insufficientTokenQuantity {
    return Intl.message("Insufficient Quantity in your wallet",
        desc: 'send_insufficient_token_quantity',
        name: 'insufficientTokenQuantity');
  }

  String get minimumSend {
    return Intl.message("Minimum send amount is %1 iDNA",
        desc: 'send_minimum_error', name: 'minimumSend');
  }

  String get insufficientBalance {
    return Intl.message("Insufficient Balance",
        desc: 'send_insufficient_balance', name: 'insufficientBalance');
  }

  String get yourBalance {
    return Intl.message("Your balance", desc: '', name: 'yourBalance');
  }

  String get sendFrom {
    return Intl.message("Send From", desc: 'send_title', name: 'sendFrom');
  }

  String get fees {
    return Intl.message("Max Fees", desc: 'fees', name: 'fees');
  }

  String get smartContractAmountStake {
    return Intl.message("Smart contract stake",
        desc: '', name: 'smartContractAmountStake');
  }

  String get smartContractLabel {
    return Intl.message("Smart Contract :",
        desc: '', name: 'smartContractLabel');
  }

  String get ownerLabel {
    return Intl.message("Owner : ", desc: '', name: 'ownerLabel');
  }

  String get balanceLabel {
    return Intl.message("Balance : ", desc: '', name: 'balanceLabel');
  }

  String get stakeLabel {
    return Intl.message("Stake : ", desc: '', name: 'stakeLabel');
  }

  String get unlockTimeLabel {
    return Intl.message("Unlock time : ", desc: '', name: 'unlockTimeLabel');
  }

  String get lastStatusLabel {
    return Intl.message("Last status : ", desc: '', name: 'lastStatusLabel');
  }

  String get nbOfVotersLabel {
    return Intl.message("Number of voters : ",
        desc: '', name: 'nbOfVotersLabel');
  }

  String get approvedUnlockContract {
    return Intl.message("Approved to unlock %1 iDNA",
        desc: '', name: 'approvedUnlockContract');
  }

  String get notVoteYet {
    return Intl.message("No vote yet",
        desc: '', name: 'notVoteYet');
  }

  String get nbOfVotesDoneLabel {
    return Intl.message("Number of votes done : ",
        desc: '', name: 'nbOfVotesDoneLabel');
  }

  String get minNbOfVotesRequiredLabel {
    return Intl.message("Min nb of votes required to unlock the coins : ",
        desc: '', name: 'minNbOfVotesRequiredLabel');
  }

  String get statusLabel {
    return Intl.message("Status : ", desc: '', name: 'statusLabel');
  }

  String get listOfVotersNotDefined {
    return Intl.message(
        "The list of voters is not defined yet (actually %1 voter(s))",
        desc: '',
        name: 'listOfVotersNotDefined');
  }

  String get listOfVotersCompleted {
    return Intl.message("The list of voters is complete",
        desc: '', name: 'listOfVotersCompleted');
  }

  String get listOfVoters {
    return Intl.message("Voters",
        desc: '', name: 'listOfVoters');
  }

  String get successInfo {
    return Intl.message("Success", desc: '', name: 'successInfo');
  }

  String get smartContratStepDeploy {
    return Intl.message("Deploy", desc: '', name: 'smartContratStepDeploy');
  }

  String get smartContratStepLock {
    return Intl.message("Lock", desc: '', name: 'smartContratStepLock');
  }

  String get smartContratStepUnlock {
    return Intl.message("Unlock", desc: '', name: 'smartContratStepUnlock');
  }

  String get smartContratStepTransfer {
    return Intl.message("Transfer", desc: '', name: 'smartContratStepTransfer');
  }

  String get smartContratStepTerminate {
    return Intl.message("Terminate",
        desc: '', name: 'smartContratStepTerminate');
  }

  /// -- END SEND ITEMS

  /// -- PIN SCREEN
  String get pinCreateTitle {
    return Intl.message("Create a 6-digit pin",
        desc: 'pin_create_title', name: 'pinCreateTitle');
  }

  String get pinConfirmTitle {
    return Intl.message("Confirm your pin",
        desc: 'pin_confirm_title', name: 'pinConfirmTitle');
  }

  String get pinEnterTitle {
    return Intl.message("Enter pin",
        desc: 'pin_enter_title', name: 'pinEnterTitle');
  }

  String get pinConfirmError {
    return Intl.message("Pins do not match",
        desc: 'pin_confirm_error', name: 'pinConfirmError');
  }

  String get pinInvalid {
    return Intl.message("Invalid pin entered",
        desc: 'pin_error', name: 'pinInvalid');
  }

  /// -- END PIN SCREEN

  /// -- PROFILE INFOS

  String get profileInfosHeader {
    return Intl.message("Profile Infos", desc: '', name: 'profileInfosHeader');
  }

  String get profileInfosAddress {
    return Intl.message("Address", desc: '', name: 'profileInfosAddress');
  }

  String get profileInfosAge {
    return Intl.message("Age", desc: '', name: 'profileInfosAge');
  }

  String get profileInfosEpoch {
    return Intl.message("Epoch", desc: '', name: 'profileInfosEpoch');
  }

  String get profileInfosState {
    return Intl.message("State", desc: '', name: 'profileInfosState');
  }

  String get profileInfosScore {
    return Intl.message("Score", desc: '', name: 'profileInfosScore');
  }

  String get profileInfosRequiredFlips {
    return Intl.message("Required flips",
        desc: '', name: 'profileInfosRequiredFlips');
  }

  String get profileInfosMadeFlips {
    return Intl.message("Made flips", desc: '', name: 'profileInfosMadeFlips');
  }

  /// -- END PROFILE INFOS
  String get timeDays {
    return Intl.message("d", desc: '', name: 'timeDays');
  }

  String get timeHours {
    return Intl.message("h", desc: '', name: 'timeHours');
  }

  String get timeMin {
    return Intl.message("m", desc: '', name: 'timeMin');
  }

  String get timeSec {
    return Intl.message("s", desc: '', name: 'timeSec');
  }

  /// -- TYPE TX
  String get typeTransfer {
    return Intl.message("Transfer", desc: '', name: 'typeTransfer');
  }

  String get typeInvitationActivated {
    return Intl.message("Invitation activated",
        desc: '', name: 'typeInvitationActivated');
  }

  String get typeInvitationIssued {
    return Intl.message("Invitation issued",
        desc: '', name: 'typeInvitationIssued');
  }

  String get typeInvitationTerminated {
    return Intl.message("Invitation terminated",
        desc: '', name: 'typeInvitationTerminated');
  }

  String get typeIdentityTerminated {
    return Intl.message("Identity terminated",
        desc: '', name: 'typeIdentityTerminated');
  }

  String get typeFlipSubmitted {
    return Intl.message("Flip submitted", desc: '', name: 'typeFlipSubmitted');
  }

  String get typeDeploy {
    return Intl.message("Deploy", desc: '', name: 'typeDeploy');
  }

  String get typeMiningStatusOff {
    return Intl.message("Mining status Off",
        desc: '', name: 'typeMiningStatusOff');
  }

  String get typeMiningStatusOn {
    return Intl.message("Mining status On",
        desc: '', name: 'typeMiningStatusOn');
  }

  String get typeCallContractSendVote {
    return Intl.message("Send public vote",
        desc: '', name: 'typeCallContractSendVote');
  }

  String get typeCallContractSendVoteProof {
    return Intl.message("Send secret vote",
        desc: '', name: 'typeCallContractSendVoteProof');
  }

  String get typeCallContractStartVoting {
    return Intl.message("Start voting",
        desc: '', name: 'typeCallContractStartVoting');
  }

  String get typeCallContractFinishVoting {
    return Intl.message("Finish voting",
        desc: '', name: 'typeCallContractFinishVoting');
  }

  String get typeCallContractProlongVoting {
    return Intl.message("Prolong voting",
        desc: '', name: 'typeCallContractProlongVoting');
  }

  ///  -- END TYPE TX

  /// -- VALIDATION

  String get validationDoesntAllow {
    return Intl.message(
        "Your status doesn\'t allow you\nto participate in the validation session",
        desc: '',
        name: 'validationDoesntAllow');
  }

  String get validationMustProvideFlips {
    return Intl.message(
        "To participate in the validation session\nyou must provide your flips",
        desc: '',
        name: 'validationMustProvideFlips');
  }

  String get validationWillStartSoon {
    return Intl.message(
        "Idena validation will start soon\nPlease, stay on this page until launch.",
        desc: '',
        name: 'validationWillStartSoon');
  }

  String get validationNextDate {
    return Intl.message("Next validation",
        desc: '', name: 'validationNextDate');
  }

  String get validationWaitingEnd {
    return Intl.message("Waiting for the end of long session",
        desc: '', name: 'validationWaitingEnd');
  }

  String get validationReachingConsensus {
    return Intl.message(
        "Please wait. The network is reaching consensus about validated identities",
        desc: '',
        name: 'validationReachingConsensus');
  }

  String get validationNextAllowed {
    return Intl.message("You can participate in the next validation session",
        desc: '', name: 'validationNextAllowed');
  }

  String get validationTipInfo {
    return Intl.message(
        "If you are satisfied with the validation session with the mobile application, you can send a tip of 1, 10 or 50 iDNA. Thank you.",
        desc: '',
        name: 'validationTipInfo');
  }

  String get validationTipThxHeader {
    return Intl.message("Thank you !",
        desc: '', name: 'validationTipThxHeader');
  }

  String get validationTipConfirmationHeader {
    return Intl.message("Confirmation",
        desc: '', name: 'validationTipConfirmationHeader');
  }

  String get validationTipConfirmationQuestion {
    return Intl.message("Are you sure you want to send a tip",
        desc: '', name: 'validationTipConfirmationQuestion');
  }

  String get validationForceStart {
    return Intl.message(
        "Idena validation started.\nPlease, click here to force the launch",
        desc: '',
        name: 'validationForceStart');
  }

  String get validationHeader {
    return Intl.message("Validation Session",
        desc: '', name: 'validationHeader');
  }

  String get validationStep1Header {
    return Intl.message("Select meaningful story: left or right",
        desc: '', name: 'validationStep1Header');
  }

  String get validationStep3Header {
    return Intl.message("Check flips quality",
        desc: '', name: 'validationStep3Header');
  }

  String get submitAnswers {
    return Intl.message("Submit Answers", desc: '', name: 'submitAnswers');
  }

  String get startCheckingKeywords {
    return Intl.message("Start checking keywords",
        desc: '', name: 'startCheckingKeywords');
  }

  String get demoMode {
    return Intl.message("Demo mode", desc: '', name: 'demoMode');
  }

  String get sharedNode {
    return Intl.message("Shared Node", desc: '', name: 'sharedNode');
  }

  String get synchronized {
    return Intl.message("Synchronized", desc: '', name: 'synchronized');
  }

  String get notSynchronized {
    return Intl.message("Not Synchronized", desc: '', name: 'notSynchronized');
  }

  String get notConnected {
    return Intl.message("Not Connected", desc: '', name: 'notConnected');
  }

  String get connected {
    return Intl.message("Connected", desc: '', name: 'connected');
  }

  String get peersNotFound {
    return Intl.message("Peers are not found", desc: '', name: 'peersNotFound');
  }

  String get synchronizingBlocks {
    return Intl.message("Synchronizing blocks",
        desc: '', name: 'synchronizingBlocks');
  }

  String get goHome {
    return Intl.message("Go home", desc: '', name: 'goHome');
  }

  String get validationUnderstand {
    return Intl.message("Ok, I understand",
        desc: '', name: 'validationUnderstand');
  }

  String get validationQualifyKeywordsNoAvailable {
    return Intl.message("No keywords available",
        desc: '', name: 'validationQualifyKeywordsNoAvailable');
  }

  String get validationAnswersNotYetSubmitted {
    return Intl.message("Your answers are not yet submitted",
        desc: '', name: 'validationAnswersNotYetSubmitted');
  }

  String get validationAnswersNotAllSelectTitle {
    return Intl.message("Warning",
        desc: '', name: 'validationAnswersNotAllSelectTitle');
  }

  String get validationAnswersNotAllSelectDesc {
    return Intl.message(
        "You haven't select all flips. Are you sure to submit ?",
        desc: '',
        name: 'validationAnswersNotAllSelectDesc');
  }

  String get validationAnswersNotAllQualifyDesc {
    return Intl.message(
        "You haven't check all flips quality. Are you sure to submit ?",
        desc: '',
        name: 'validationAnswersNotAllQualifyDesc');
  }

  String get validationQualifyKeywordsQuestion {
    return Intl.message("Are both keywords relevant to the flip ?",
        desc: '', name: 'validationQualifyKeywordsQuestion');
  }

  String get validationQualifyKeywordsRelevant {
    return Intl.message("Both relevant",
        desc: '', name: 'validationQualifyKeywordsRelevant');
  }

  String get validationQualifyKeywordsIrrelevant {
    return Intl.message("Irrelevant",
        desc: '', name: 'validationQualifyKeywordsIrrelevant');
  }

  String get validationQualifyKeywords {
    return Intl.message(
        "Please qualify the keywords relevance and submit the answers.",
        desc: '',
        name: 'validationQualifyKeywords');
  }

  String get validationFlipsIrrelevantKeywordsWarning {
    return Intl.message("The flips with irrelevant keywords will be penalized",
        desc: '', name: 'validationFlipsIrrelevantKeywordsWarning');
  }

  String get validationFlipsIrrelevantLimitControl {
    return Intl.message(
        "The number of flips that can be reported\nshould be limited to 1/3",
        desc: '',
        name: 'validationFlipsIrrelevantLimitControl');
  }

  String get validationFlipsSubmitOk {
    return Intl.message(
        "Your answers for the validation session have been submitted successfully!",
        desc: '',
        name: 'validationFlipsSubmitOk');
  }

  /// -- END VALIDATION

  /// -- FLIPS CREATOR
  String get flipsCreatorStep1Header {
    return Intl.message("Think up a story",
        desc: '', name: 'flipsCreatorStep1Header');
  }

  String get flipsCreatorHeader {
    return Intl.message("Flips Creator", desc: '', name: 'flipsCreatorHeader');
  }

  String get flipsCreatorStep1Info {
    return Intl.message(
        "Think up a short story about someone/something related to the two key words below according to the template",
        desc: '',
        name: 'flipsCreatorStep1Info');
  }

  String get flipsCreatorStep1ChangeWords {
    return Intl.message("Change words",
        desc: '', name: 'flipsCreatorStep1ChangeWords');
  }

  String get flipsCreatorStep1NextStep {
    return Intl.message("Next step",
        desc: '', name: 'flipsCreatorStep1NextStep');
  }

  String get flipsCreatorStep2Header {
    return Intl.message("Select 4 images to tell your story",
        desc: '', name: 'flipsCreatorStep2Header');
  }

  String get flipsCreatorStep2Info1 {
    return Intl.message("Use keywords for the story",
        desc: '', name: 'flipsCreatorStep2Info1');
  }

  String get flipsCreatorStep2Info2 {
    return Intl.message(
        "and template \"Before – Something happens – After\".\nPlease no text on images to explain your story.",
        desc: '',
        name: 'flipsCreatorStep2Info2');
  }

  String get flipsCreatorStep2PickImages {
    return Intl.message("Pick images",
        desc: '', name: 'flipsCreatorStep2PickImages');
  }

  String get flipsCreatorStep3Header {
    return Intl.message("Shuffle images",
        desc: '', name: 'flipsCreatorStep3Header');
  }

  String get flipsCreatorStep3Info1 {
    return Intl.message(
        "Shuffle images in order to make a nonsense sequence of images",
        desc: '',
        name: 'flipsCreatorStep3Info1');
  }

  String get flipsCreatorStep4Header {
    return Intl.message("Submit flip",
        desc: '', name: 'flipsCreatorStep4Header');
  }

  String get flipsCreatorStep4Info1 {
    return Intl.message(
        "Make sure it is not possible to read the shuffled images as a meaningful story",
        desc: '',
        name: 'flipsCreatorStep4Info1');
  }

  String get flipsCreatorStep4Info2 {
    return Intl.message("Are you sure that you want to submit this flip ?",
        desc: '', name: 'flipsCreatorStep4Info2');
  }

  String get flipsCreatorStep4Warning1 {
    return Intl.message(
        "If you make BAD flip, you will lose all iDNA rewards !\nThe cost of deleting a flip is about 8 iDNA",
        desc: '',
        name: 'flipsCreatorStep4Warning1');
  }

  String get flipsCreatorStep4Submit {
    return Intl.message("Submit flip",
        desc: '', name: 'flipsCreatorStep4Submit');
  }

  /// -- END FLIPS CREATOR

  /// -- SETTINGS ITEMS

  String get pickFromList {
    return Intl.message("Pick From a List",
        desc: 'pick rep from list', name: 'pickFromList');
  }

  String get uptime {
    return Intl.message("Uptime", desc: 'Rep uptime', name: 'uptime');
  }

  String get authMethod {
    return Intl.message("Authentication Method",
        desc: 'settings_disable_fingerprint', name: 'authMethod');
  }

  String get pinMethod {
    return Intl.message("PIN", desc: 'settings_pin_method', name: 'pinMethod');
  }

  String get privacyPolicy {
    return Intl.message("Privacy Policy",
        desc: 'settings_privacy_policy', name: 'privacyPolicy');
  }

  String get biometricsMethod {
    return Intl.message("Biometrics",
        desc: 'settings_fingerprint_method', name: 'biometricsMethod');
  }

  String get currency {
    return Intl.message("Currency",
        desc: 'A settings menu item for changing currency', name: 'currency');
  }

  String get changeCurrency {
    return Intl.message("Change Currency",
        desc: 'settings_local_currency', name: 'changeCurrency');
  }

  String get language {
    return Intl.message("Language",
        desc: 'settings_change_language', name: 'language');
  }

  String get logout {
    return Intl.message("Logout", desc: 'settings_logout', name: 'logout');
  }

  String get faq {
    return Intl.message("FAQ and tutorials", desc: 'settings_faq', name: 'faq');
  }

  String get rootWarning {
    return Intl.message(
        'It appears your device is "rooted", "jailbroken", or modified in a way that compromises security. It is recommended that you reset your device to its original state before proceeding.',
        desc:
            "Shown to users if they have a rooted Android device or jailbroken iOS device",
        name: 'rootWarning');
  }

  String get iUnderstandTheRisks {
    return Intl.message("I Understand the Risks",
        desc:
            "Shown to users if they have a rooted Android device or jailbroken iOS device",
        name: 'iUnderstandTheRisks');
  }

  String get exit {
    return Intl.message("Exit",
        desc: "Exit action, like a button", name: 'exit');
  }

  String get warning {
    return Intl.message("Warning",
        desc: 'settings_logout_alert_title', name: 'warning');
  }

  String get logoutDetail {
    return Intl.message(
        "Logging out will remove your configuration and all my Idena-related data from this device.",
        desc: 'settings_logout_alert_message',
        name: 'logoutDetail');
  }

  String get logoutAction {
    return Intl.message("Delete Configuration and Logout",
        desc: 'settings_logout_alert_confirm_cta', name: 'logoutAction');
  }

  String get logoutAreYouSure {
    return Intl.message("Are you sure?",
        desc: 'settings_logout_warning_title', name: 'logoutAreYouSure');
  }

  String get logoutReassurance {
    return Intl.message("",
        desc: 'settings_logout_warning_message', name: 'logoutReassurance');
  }

  String get settingsHeader {
    return Intl.message("Settings",
        desc: 'settings_title', name: 'settingsHeader');
  }

  String get preferences {
    return Intl.message("Preferences",
        desc: 'settings_preferences_header', name: 'preferences');
  }

  String get informations {
    return Intl.message("Informations",
        desc: 'settings_informations_header', name: 'informations');
  }

  String get features {
    return Intl.message("Features",
        desc: 'settings_informations_header', name: 'features');
  }

  String get tryValidationSession {
    return Intl.message("Try a validation session",
        desc: 'settings_informations_header', name: 'tryValidationSession');
  }

  String get miningStatus {
    return Intl.message("Mining status",
        desc: 'settings_informations_header', name: 'miningStatus');
  }

  String get searchField {
    return Intl.message("Search...",
        desc: 'search_field_hint', name: 'searchField');
  }

  String get myTokens {
    return Intl.message("Tokens", desc: 'my_tokens_button', name: 'myTokens');
  }

  String get manage {
    return Intl.message("Manage",
        desc: 'settings_manage_header', name: 'manage');
  }

  String get backupSeed {
    return Intl.message("Backup Seed",
        desc: 'settings_backup_seed', name: 'backupSeed');
  }

  String get fingerprintSeedBackup {
    return Intl.message("Authenticate to backup seed.",
        desc: 'settings_fingerprint_title', name: 'fingerprintSeedBackup');
  }

  String get pinSeedBackup {
    return Intl.message("Enter PIN to Backup Seed",
        desc: 'settings_pin_title', name: 'pinSeedBackup');
  }

  String get systemDefault {
    return Intl.message("System Default",
        desc: 'settings_default_language_string', name: 'systemDefault');
  }

  /// -- END SETTINGS ITEMS

  /// -- SMART CONTRAT ITEMS
  String get scHeader {
    return Intl.message("Smart Contracts", desc: '', name: 'scHeader');
  }

  String get timeLockTitle {
    return Intl.message("Time Lock", desc: '', name: 'timeLockTitle');
  }

  String get multisigTitle {
    return Intl.message("Multisig M-of-N", desc: '', name: 'multisigTitle');
  }

  String get oracleLockTitle {
    return Intl.message("Oracle Lock", desc: '', name: 'oracleLockTitle');
  }

  String get refundableOracleLockTitle {
    return Intl.message("Refundable Oracle Lock",
        desc: '', name: 'refundableOracleLockTitle');
  }

  String get createTimeLock {
    return Intl.message("Create Time Lock Smart Contract",
        desc: '', name: 'createTimeLock');
  }

  String get createMultiSig {
    return Intl.message("Create MultiSig Contract",
        desc: '', name: 'createMultiSig');
  }

  String get owner {
    return Intl.message("Owner", desc: '', name: 'owner');
  }

  String get winnerVote {
    return Intl.message("The address with the most votes", desc: '', name: 'winnerVote');
  }

  String get smartContractAddress {
    return Intl.message("Smart Contract Address",
        desc: '', name: 'smartContractAddress');
  }

  String get enterDateTimeLock {
    return Intl.message("Enter the unlock time",
        desc: '', name: 'enterDateTimeLock');
  }

  String get enterMaxVotesMultiSig {
    return Intl.message("Enter the number of voters",
        desc: '', name: 'enterMaxVotesMultiSig');
  }

  String get enterMinVotesMultiSig {
    return Intl.message("Enter the min number of votes",
        desc: '', name: 'enterMinVotesMultiSig');
  }

  String get lockCoinConfirmatonButton {
    return Intl.message("Confirm Lock coins",
        desc: '', name: 'lockCoinConfirmatonButton');
  }

  String get lockCoinEstimationButton {
    return Intl.message("Estimate Lock coins",
        desc: '', name: 'lockCoinEstimationButton');
  }

  String get multiSigEstimationButton {
    return Intl.message("Estimate Multi Signatures",
        desc: '', name: 'multiSigEstimationButton');
  }

  String get unlockTimeTitle {
    return Intl.message("Unlock time", desc: '', name: 'unlockTimeTitle');
  }

  String get dateUnlockTimeMissing {
    return Intl.message("Please Enter the time of unlock",
        desc: '', name: 'dateUnlockTimeMissing');
  }

  String get maxVotesTitle {
    return Intl.message("Number of voters", desc: '', name: 'maxVotesTitle');
  }

  String get minVotesTitle {
    return Intl.message("Min number of votes required to unlock the coins",
        desc: '', name: 'minVotesTitle');
  }

  String get maxVotesMissing {
    return Intl.message("Please Enter the number of voters",
        desc: '', name: 'maxVotesMissing');
  }

  String get minVotesMissing {
    return Intl.message(
        "Please Enter the min number of votes required to unlock the coins",
        desc: '',
        name: 'minVotesMissing');
  }

  String get maxVSminVotesError {
    return Intl.message(
        "The number of voters should be higher than the min number of votes required to unlock the coins",
        desc: '',
        name: 'maxVSminVotesError');
  }

  String get maxVotes32Error {
    return Intl.message("The number of voters shouldn't be higher than 32",
        desc: '', name: 'maxVotes32Error');
  }

  String get minVotesNumericError {
    return Intl.message(
        "The min number of votes required to unlock the coins should be numeric",
        desc: '',
        name: 'minVotesNumericError');
  }

  String get maxVotesNumericError {
    return Intl.message("The number of voters should be numeric",
        desc: '', name: 'maxVotesNumericError');
  }

  String get gasCost {
    return Intl.message("Gas cost", desc: '', name: 'gasCost');
  }

  String get txFee {
    return Intl.message("Tx fees", desc: '', name: 'txFee');
  }

  String get contractDeployError {
    return Intl.message("An error occurred. Try again later.",
        desc: '', name: 'contractDeployError');
  }

  String get timeLockTo {
    return Intl.message("Lock To", desc: '', name: 'timeLockTo');
  }

  String get scLockAmountConfirm {
    return Intl.message("Lock", desc: '', name: 'scLockAmountConfirm');
  }

  String get scLockAmountConfirmPin {
    return scLockAmountConfirm;
  }

  String get scTransferButton {
    return Intl.message("Transfer", desc: '', name: 'scTransferButton');
  }

  String get scPushButton {
    return Intl.message("Push", desc: '', name: 'scPushButton');
  }

  String get scAddVoterButton {
    return Intl.message("Add voter", desc: '', name: 'scAddVoterButton');
  }

  String get scVoteButton {
    return Intl.message("Vote", desc: '', name: 'scVoteButton');
  }

  String get scTerminateButton {
    return Intl.message("Terminate", desc: '', name: 'scTerminateButton');
  }

  String get scTransferConfirmationTitle {
    return Intl.message("Transfer confirmation",
        desc: '', name: 'scTransferConfirmationTitle');
  }

  String get scPushConfirmationTitle {
    return Intl.message("Push confirmation",
        desc: '', name: 'scPushConfirmationTitle');
  }

  String get timeLockTransferConfirmationText {
    return Intl.message(
        "Are you sure you want to send the locked coins to the destination address ?",
        desc: '',
        name: 'timeLockTransferConfirmationText');
  }

  String get scTerminateConfirmationTitle {
    return Intl.message("Terminate confirmation",
        desc: '', name: 'scTerminateConfirmationTitle');
  }

  String get scVoteConfirmationTitle {
    return Intl.message("Vote confirmation",
        desc: '', name: 'scVoteConfirmationTitle');
  }

  String get scVoteConfirmationText {
    return Intl.message(
        "Are you sure you want to vote for transfers to unlock the coins ?",
        desc: '',
        name: 'scVoteConfirmationText');
  }

  String get scPushConfirmationText {
    return Intl.message(
        "Are you sure you want transferring the specified amount of coin ?",
        desc: '',
        name: 'scPushConfirmationText');
  }

  String get scAddVoterConfirmationTitle {
    return Intl.message("Add voter confirmation",
        desc: '', name: 'scAddVoterConfirmationTitle');
  }

  String get scAddVoterConfirmationText {
    return Intl.message(
        "Are you sure you want to add the voter's address that can vote for transfers to unlock the coins ?",
        desc: '',
        name: 'scAddVoterConfirmationText');
  }

  String get scTerminateConfirmationText {
    return Intl.message(
        "Are you sure you want to terminate the contract and send 50% of the stacked coins to the destination address ?",
        desc: '',
        name: 'scTerminateConfirmationText');
  }

  /// -- SMART CONTRACT ITEMS END

  /// -- MINING

  String get activateMiningHeader {
    return Intl.message("Activate mining status",
        desc: 'mining_infos', name: 'activateMiningHeader');
  }

  String get deactivateMiningHeader {
    return Intl.message("Deactivate mining status",
        desc: 'mining_infos', name: 'deactivateMiningHeader');
  }

  String get activateMiningInfos {
    return Intl.message(
        "Submit the form to start mining. Your node has to be online unless you deactivate your status. Otherwise penalties might be charged after being offline more than 1 hour.\nYou can deactivate your online status at any time.\n\nPlease, wait few seconds before the activation...",
        desc: 'mining_infos',
        name: 'activateMiningInfos');
  }

  String get deactivateMiningInfos {
    return Intl.message(
        "Submit the form to deactivate your mining status.\nYou can activate it again afterwards.\n\nPlease, wait few seconds before the desactivation...",
        desc: 'mining_infos',
        name: 'deactivateMiningInfos');
  }

  /// -- END MINING

  // Scan

  String get scanInstructions {
    return Intl.message("Scan a Idena \naddress QR code",
        desc: 'scan_send_instruction_label', name: 'scanInstructions');
  }

  /// -- LOCK SCREEN

  String get unlockPin {
    return Intl.message("Enter PIN to Unlock my Idena",
        desc: 'unlock_idena_pin', name: 'unlockPin');
  }

  String get unlockBiometrics {
    return Intl.message("Authenticate to Unlock my Idena",
        desc: 'unlock_idena_bio', name: 'unlockBiometrics');
  }

  String get lockAppSetting {
    return Intl.message("Authenticate on Launch",
        desc: 'authenticate_on_launch', name: 'lockAppSetting');
  }

  String get locked {
    return Intl.message("Locked", desc: 'lockedtxt', name: 'locked');
  }

  String get unlock {
    return Intl.message("Unlock", desc: 'unlocktxt', name: 'unlock');
  }

  String get tooManyFailedAttempts {
    return Intl.message("Too many failed unlock attempts.",
        desc: 'fail_toomany_attempts', name: 'tooManyFailedAttempts');
  }

  /// -- END LOCK SCREEN

  /// -- SECURITY SETTINGS SUBMENU

  String get securityHeader {
    return Intl.message("Security",
        desc: 'security_header', name: 'securityHeader');
  }

  String get autoLockHeader {
    return Intl.message("Automatically Lock",
        desc: 'auto_lock_header', name: 'autoLockHeader');
  }

  String get xMinutes {
    return Intl.message("After %1 minutes",
        desc: 'after_minutes', name: 'xMinutes');
  }

  String get xMinute {
    return Intl.message("After %1 minute",
        desc: 'after_minute', name: 'xMinute');
  }

  String get instantly {
    return Intl.message("Instantly", desc: 'insantly', name: 'instantly');
  }

  String get setAppPassword {
    return Intl.message("Set App Password",
        desc: 'Allows user to encrypt app with a password',
        name: 'setAppPassword');
  }

  String get setPassword {
    return Intl.message("Set Password",
        desc: 'A button that sets the app password', name: 'setPassword');
  }

  String get disableAppPassword {
    return Intl.message("Disable App Password",
        desc: 'Allows user to deencrypt app with a password',
        name: 'disableAppPassword');
  }

  String get encryptionFailedError {
    return Intl.message("Failed to set a wallet password",
        desc: 'If encrypting a wallet raised an error',
        name: 'encryptionFailedError');
  }

  String get setPasswordSuccess {
    return Intl.message("Password has been set successfully",
        desc: 'Setting a Wallet Password was successful',
        name: 'setPasswordSuccess');
  }

  String get disablePasswordSuccess {
    return Intl.message("Password has been disabled",
        desc: 'Disabling a Wallet Password was successful',
        name: 'disablePasswordSuccess');
  }

  /// -- END SECURITY SETTINGS SUBMENU

  /// -- EXAMPLE HOME SCREEN CARDS

  String get exampleCardIntro {
    return Intl.message(
        "Welcome to my Idena. Once you receive transactions, they will show up like this:",
        desc: 'example_card_intro',
        name: 'exampleCardIntro');
  }

  String get exampleCardLittle {
    return Intl.message("A little",
        desc: 'example_card_little', name: 'exampleCardLittle');
  }

  String get exampleCardLot {
    return Intl.message("A lot of",
        desc: 'example_card_lot', name: 'exampleCardLot');
  }

  String get exampleCardTo {
    return Intl.message("to someone",
        desc: 'example_card_to', name: 'exampleCardTo');
  }

  String get exampleCardFrom {
    return Intl.message("from someone",
        desc: 'example_card_from', name: 'exampleCardFrom');
  }

  /// -- END EXAMPLE HOME SCREEN CARDS

  /// -- START MULTI-ACCOUNT

  String get defaultAccountName {
    return Intl.message("Main Account",
        desc: "Default account name", name: 'defaultAccountName');
  }

  String get defaultNewAccountName {
    return Intl.message("Account %1",
        desc: "Default new account name - e.g. Account 1",
        name: 'defaultNewAccountName');
  }

  String get newAccountIntro {
    return Intl.message(
        "This is your new account. Once you receive iDNA, transactions will show up like this:",
        desc: 'Alternate account intro card',
        name: 'newAccountIntro');
  }

  String get account {
    return Intl.message("Account", desc: "Account text", name: 'account');
  }

  String get accounts {
    return Intl.message("Accounts", desc: "Accounts header", name: 'accounts');
  }

  String get addAccount {
    return Intl.message("Add Account",
        desc: "Default new account name - e.g. Account 1", name: 'addAccount');
  }

  String get hideAccountHeader {
    return Intl.message("Hide Account?",
        desc: "Confirmation dialog header", name: 'hideAccountHeader');
  }

  String get removeAccountText {
    return Intl.message(
        "Are you sure you want to hide this account? You can re-add it later by tapping the \"%1\" button.",
        desc: "Remove account dialog body",
        name: 'removeAccountText');
  }

  /// -- END MULTI-ACCOUNT

  String get tapToReveal {
    return Intl.message("Tap to reveal",
        desc: "Tap to reveal hidden content", name: 'tapToReveal');
  }

  String get tapToHide {
    return Intl.message("Tap to hide",
        desc: "Tap to hide content", name: 'tapToHide');
  }

  String get copied {
    return Intl.message("Copied",
        desc: "Copied (to clipboard)", name: 'copied');
  }

  String get copy {
    return Intl.message("Copy", desc: "Copy (to clipboard)", name: 'copy');
  }

  String get seedDescription {
    return Intl.message(
        "A seed bears the same information as a secret phrase, but in a machine-readable way. As long as you have one of them backed up, you'll have access to your funds.",
        desc: "Describing what a seed is",
        name: 'seedDescription');
  }

  String get importSecretPhrase {
    return Intl.message("Import Secret Phrase",
        desc: "Header for restoring using mnemonic",
        name: 'importSecretPhrase');
  }

  String get importSecretPhraseHint {
    return Intl.message(
        "Please enter your 24-word secret phrase below. Each word should be separated by a space.",
        desc: 'helper message for importing mnemnic',
        name: 'importSecretPhraseHint');
  }

  String get secretPhraseCopy {
    return Intl.message("Copy Secret Phrase",
        desc: 'Copy secret phrase to clipboard', name: 'secretPhraseCopy');
  }

  String get secretPhraseCopied {
    return Intl.message("Secret Phrase Copied",
        desc: 'Copied secret phrase to clipboard', name: 'secretPhraseCopied');
  }

  String get qrMnemonicError {
    return Intl.message("QR does not contain a valid secret phrase",
        desc: 'When QR does not contain a valid mnemonic phrase',
        name: 'qrMnemonicError');
  }

  String get mnemonicInvalidWord {
    return Intl.message("%1 is not a valid word",
        desc: 'A word that is not part of bip39', name: 'mnemonicInvalidWord');
  }

  String get mnemonicSizeError {
    return Intl.message("Secret phrase may only contain 24 words",
        desc: 'err', name: 'mnemonicSizeError');
  }

  String get secretPhrase {
    return Intl.message("Secret Phrase",
        desc: 'Secret (mnemonic) phrase', name: 'secretPhrase');
  }

  String get backupConfirmButton {
    return Intl.message("I've Backed It Up",
        desc: 'Has backed up seed confirmation button',
        name: 'backupConfirmButton');
  }

  String get gotItButton {
    return Intl.message("Got It!",
        desc: 'Got It! Acknowledgement button', name: 'gotItButton');
  }

  String get import {
    return Intl.message("Import", desc: "Generic import", name: 'import');
  }

  String get importSeedInstead {
    return Intl.message("Import Seed Instead",
        desc: "importSeedInstead", name: 'importSeedInstead');
  }

  String get switchToSeed {
    return Intl.message("Switch to Seed",
        desc: "switchToSeed", name: 'switchToSeed');
  }

  String get backupSecretPhrase {
    return Intl.message("Backup Secret Phrase",
        desc: 'backup seed', name: 'backupSecretPhrase');
  }

  /// -- SEED PROCESS

  /// -- END SEED PROCESS

  /// HINTS
  String get createPasswordHint {
    return Intl.message("Create a password",
        desc: 'A text field hint that tells the user to create a password',
        name: 'createPasswordHint');
  }

  String get confirmPasswordHint {
    return Intl.message("Confirm the password",
        desc: 'A text field hint that tells the user to confirm the password',
        name: 'confirmPasswordHint');
  }

  String get enterPasswordHint {
    return Intl.message("Enter your password",
        desc: 'A text field hint that tells the users to enter their password',
        name: 'enterPasswordHint');
  }

  String get passwordsDontMatch {
    return Intl.message("Passwords do not match",
        desc: 'An error indicating a password has been confirmed incorrectly',
        name: 'passwordsDontMatch');
  }

  String get passwordBlank {
    return Intl.message("Password cannot be empty",
        desc: 'An error indicating a password has been entered incorrectly',
        name: 'passwordBlank');
  }

  String get invalidPassword {
    return Intl.message("Invalid Password",
        desc: 'An error indicating a password has been entered incorrectly',
        name: 'invalidPassword');
  }

  /// HINTS END

  /// HEADERS
  String get createAPasswordHeader {
    return Intl.message("Create a password.",
        desc: 'A paragraph that tells the users to create a password.',
        name: 'createAPasswordHeader');
  }

  String get createPasswordSheetHeader {
    return Intl.message("Create",
        desc: 'Prompt user to create a new password',
        name: 'createPasswordSheetHeader');
  }

  String get disablePasswordSheetHeader {
    return Intl.message("Disable",
        desc: 'Prompt user to disable their password',
        name: 'disablePasswordSheetHeader');
  }

  String get aboutHeader {
    return Intl.message("About", desc: 'settings_about', name: 'aboutHeader');
  }

  String get thanksForHelp {
    return Intl.message("Thanks for help",
        desc: 'thanks_label', name: 'thanksForHelp');
  }

  String get thanksAuthor {
    return Intl.message("Created by",
        desc: 'thanks_author_label', name: 'thanksAuthor');
  }

  String get validationBasicsHeader {
    return Intl.message("Validation Basics",
        desc: '', name: 'validationBasicsHeader');
  }

  String get validationBasicsGoodFlipHeader {
    return Intl.message("What is a Good Flip ?",
        desc: '', name: 'validationBasicsGoodFlipHeader');
  }

  String get validationBasicsBadFlipHeader {
    return Intl.message("What is a Bad Flip ?",
        desc: '', name: 'validationBasicsBadFlipHeader');
  }

  String get validationBasicsGoodFlipRewardHeader {
    return Intl.message("A good flip earns you rewards in iDNA",
        desc: '', name: 'validationBasicsGoodFlipRewardHeader');
  }

  String get validationBasicsBadFlipRewardHeader {
    return Intl.message("A bad flip penalizes you in iDNA",
        desc: '', name: 'validationBasicsBadFlipRewardHeader');
  }

  String get validationBasicsGoodFlipItem1 {
    return Intl.message(
        "A good flip tells a story, assembled chronologically, to represent an event or a process from beginning to end.",
        desc: '',
        name: 'validationBasicsGoodFlipItem1');
  }

  String get validationBasicsGoodFlipItem2 {
    return Intl.message(
        "A good flip is EASY to solve for humans, but hard for robots.",
        desc: '',
        name: 'validationBasicsGoodFlipItem2');
  }

  String get validationBasicsGoodFlipItem3 {
    return Intl.message(
        "A good flip uses clear, simple images, and lets the story be obvious, with no ambiguity.",
        desc: '',
        name: 'validationBasicsGoodFlipItem3');
  }

  String get validationBasicsGoodFlipItem4 {
    return Intl.message("A good flip uses no text.",
        desc: '', name: 'validationBasicsGoodFlipItem4');
  }

  String get validationBasicsGoodFlipItem5 {
    return Intl.message(
        "A good flip uses simple concepts that ANYONE IN THE WORLD will easily understand, regardless of their native language or culture.",
        desc: '',
        name: 'validationBasicsGoodFlipItem5');
  }

  String get validationBasicsGoodFlipItem6 {
    return Intl.message(
        "A good flip should be relevant to both of the seed words.",
        desc: '',
        name: 'validationBasicsGoodFlipItem6');
  }

  String get validationBasicsGoodFlipItem7 {
    return Intl.message(
        "A good flip makes use of the tools available including DRAWING and COLLAGE to help battle against AI and add creativity.",
        desc: '',
        name: 'validationBasicsGoodFlipItem7');
  }

  String get validationBasicsGoodFlipItem8 {
    return Intl.message(
        "A good flip uses the shuffle to create a 100% non logical alternative.",
        desc: '',
        name: 'validationBasicsGoodFlipItem8');
  }

  String get validationBasicsBadFlipItem1 {
    return Intl.message(
        "A bad flip has NO logical story, even if it uses both keywords.",
        desc: '',
        name: 'validationBasicsBadFlipItem1');
  }

  String get validationBasicsBadFlipItem2 {
    return Intl.message("A bad flip contains numbers or letters on images.",
        desc: '', name: 'validationBasicsBadFlipItem2');
  }

  String get validationBasicsBadFlipItem3 {
    return Intl.message("A bad flip is hard to understand.",
        desc: '', name: 'validationBasicsBadFlipItem3');
  }

  String get validationBasicsBadFlipItem4 {
    return Intl.message(
        "A bad flip contains hateful, inappropriate or NSFW content.",
        desc: '',
        name: 'validationBasicsBadFlipItem4');
  }

  String get validationBasicsBadFlipItem5 {
    return Intl.message("A bad flip does NOT USE BOTH keywords in the story.",
        desc: '', name: 'validationBasicsBadFlipItem5');
  }

  String get validationBasicsBadFlipItem6 {
    return Intl.message(
        "A bad flip uses objects in images in sequence (1-2-3-4).",
        desc: '',
        name: 'validationBasicsBadFlipItem6');
  }

  String get validationBasicsBadFlipItem7 {
    return Intl.message(
        "If even one of your submitted flips are reported during validation, you loose 100% of your rewards including invitation rewards for that validation",
        desc: '',
        name: 'validationBasicsBadFlipItem7');
  }

  /// HEADERS END

  /// INVITATIONS
  String get invitationHeader {
    return Intl.message("Invitation", desc: '', name: 'invitationHeader');
  }

  String get invitationActivateHeader {
    return Intl.message(
        "You received an invitation.\nClick the button to activate it.",
        desc: '',
        name: 'invitationActivateHeader');
  }

  String get invitationActivateTitle {
    return Intl.message("Activate", desc: '', name: 'invitationActivateTitle');
  }

  String get invitationActivateButton {
    return Intl.message("Activate", desc: '', name: 'invitationActivateButton');
  }

  String get sendInvite {
    return Intl.message('Send Invite', desc: '', name: 'sendInvite');
  }

  String get sendInviteConfirmationHeader {
    return Intl.message('Send Invite confirmation',
        desc: '', name: 'sendInviteConfirmationHeader');
  }

  String get sendInviteConfirmationInfos {
    return Intl.message(
        'Are you sure you want to send an invitation to this contact ?',
        desc: '',
        name: 'sendInviteConfirmationInfos');
  }

  String get sendInviteSuccess {
    return Intl.message('The invitation was sent successfully',
        desc: '', name: 'sendInviteSuccess');
  }

  String get inviteHeader {
    return Intl.message('Invite', desc: '', name: 'inviteHeader');
  }

  String get enterInviteKey {
    return Intl.message("Enter the code invitation",
        desc: '', name: 'enterInviteKey');
  }

  String get keyInviteMissing {
    return Intl.message("Please Enter the code invitation",
        desc: '', name: 'keyInviteMissing');
  }

  String get activateInviteSuccess {
    return Intl.message('The invitation was activated successfully',
        desc: '', name: 'activateInviteSuccess');
  }

  String get activationInviteConfirmationHeader {
    return Intl.message('Activation Invite confirmation',
        desc: '', name: 'activationInviteConfirmationHeader');
  }

  String get activationInviteConfirmationInfos {
    return Intl.message('Are you sure you want to activate an invitation ?',
        desc: '', name: 'activationInviteConfirmationInfos');
  }

  /// INVITATIONS END

  /// BUTTONS
  String get noSkipButton {
    return Intl.message("No, Skip",
        desc: 'A button that declines and skips the mentioned process.',
        name: 'noSkipButton');
  }

  String get yesButton {
    return Intl.message("Yes",
        desc: 'A button that accepts the mentioned process.',
        name: 'yesButton');
  }

  String get nextButton {
    return Intl.message("Next",
        desc: 'A button that goes to the next screen.', name: 'nextButton');
  }

  String get goBackButton {
    return Intl.message("Go Back",
        desc: 'A button that goes to the previous screen.',
        name: 'goBackButton');
  }

  String get supportButton {
    return Intl.message("Support",
        desc: 'A button to open up the live support window',
        name: 'supportButton');
  }

  String get liveSupportButton {
    return Intl.message("Support",
        desc: 'A button to open up the live support window',
        name: 'liveSupportButton');
  }

  /// BUTTONS END

  /// Live chat
  String get connectingHeader {
    return Intl.message("Connecting",
        desc:
            'A header to let the user now that my Idena is currently connecting to (or loading) live chat.',
        name: 'connectingHeader');
  }

  String getAccountExplorerUrl(String account) {
    return 'https://scan.idena.io/address/$account';
  }

  String getFAQ() {
    return 'https://idena.site/faq-tutorials';
  }

  String get privacyUrl {
    return 'https://github.com/redDwarf03/my-idena/blob/master/Privacy%20Policy.md';
  }

  String get donationsUrl {
    return '0xf429e36D68BE10428D730784391589572Ee0f72B';
  }

  String get donationsName {
    return '@Donations';
  }

  /// -- END NON-TRANSLATABLE ITEMS
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  final LanguageSetting languageSetting;

  const AppLocalizationsDelegate(this.languageSetting);

  @override
  bool isSupported(Locale locale) {
    return languageSetting != null;
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    if (languageSetting.language == AvailableLanguage.DEFAULT) {
      return AppLocalization.load(locale);
    }
    return AppLocalization.load(Locale(languageSetting.getLocaleString()));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return true;
  }
}
