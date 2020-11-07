import 'dart:async';
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';
import 'package:my_idena/pages/blocs/bloc_provider.dart';
import 'package:my_idena/enums/epoch_period.dart' as EpochPeriod;

class ValidationSessionInfoBloc implements BlocBase {
  String _epochPeriod = EpochPeriod.None;
  bool _simulationMode = false;
  int index = 0;
  ValidationSessionInfo validationSessionInfo = new ValidationSessionInfo();

  // in
  StreamController<ValidationSessionInfoContext>
      _validationSessionInfoContextController = StreamController();
  Sink<ValidationSessionInfoContext> get inValidationSessionInfoContext =>
      _validationSessionInfoContextController.sink;

  StreamController<ValidationSessionInfoFlips>
      _validationSessionInfoFlipsController = StreamController();
  Sink<ValidationSessionInfoFlips> get inValidationSessionInfoFlips =>
      _validationSessionInfoFlipsController.sink;

  StreamController<ValidationSessionInfoFlips> _selectFlipController =
      StreamController.broadcast();
  Sink<ValidationSessionInfoFlips> get inSelectFlip =>
      _selectFlipController.sink;

  StreamController<int> _indexController = StreamController.broadcast();
  Sink<int> get inFlipIndex => _indexController.sink;

  // out
  StreamController<ValidationSessionInfo> _loadValidationSessionInfoController =
      new StreamController<ValidationSessionInfo>();
  Sink<ValidationSessionInfo> get _inValidationSessionInfo =>
      _loadValidationSessionInfoController.sink;
  Stream<ValidationSessionInfo> get outValidationSessionInfo =>
      _loadValidationSessionInfoController.stream;

  StreamController<bool> _isAllFlipsSelectedController =
      new StreamController.broadcast();
  Sink<bool> get _inIsAllFlipsSelected => _isAllFlipsSelectedController.sink;
  Stream<bool> get outIsAllFlipsSelected =>
      _isAllFlipsSelectedController.stream;

  StreamController<ValidationSessionInfoFlips>
      _getValidationSessionInfoController = new StreamController();
  Sink<ValidationSessionInfoFlips> get _inValidationSessionInfoFlips =>
      _getValidationSessionInfoController.sink;
  Stream<ValidationSessionInfoFlips> get outValidationSessionInfoFlips =>
      _getValidationSessionInfoController.stream;

  //
  StreamController<String> _epochPeriodController =
      StreamController.broadcast();
  Sink<String> get _inEpochPeriod => _epochPeriodController.sink;
  Stream<String> get outEpochPeriod => _epochPeriodController.stream;

  StreamController<bool> _simulationModeController =
      StreamController.broadcast();
  Sink<bool> get _inSimulationMode => _simulationModeController.sink;
  Stream<bool> get outSimulationMode => _simulationModeController.stream;

  ValidationSessionInfoBloc() {
    _validationSessionInfoContextController.stream
        .listen(_handleValidationSessionInfoContext);

    _validationSessionInfoFlipsController.stream
        .listen(_handleValidationSessionFlipDetail);

    _selectFlipController.stream.listen(_handleSelectFlip);

    _indexController.stream.listen(_handleIndexes);
  }

  void dispose() {
    _loadValidationSessionInfoController.close();
    _epochPeriodController.close();
    _simulationModeController.close();
    _isAllFlipsSelectedController.close();
    _validationSessionInfoContextController.close();
    _validationSessionInfoFlipsController.close();
    _getValidationSessionInfoController.close();
    _selectFlipController.close();
    _indexController.close();
  }

  void _handleLoadValidationSessionInfo() {
    print("appel _handleLoadValidationSessionInfo ");
    getValidationSessionFlipsList(_epochPeriod, null, _simulationMode)
        .then((_validationSessionInfo) {
      validationSessionInfo = _validationSessionInfo;
      _inValidationSessionInfo.add(_validationSessionInfo);
      print("appel _handleLoadValidationSessionInfo ok");
    });

    _notify();
  }

  void _handleValidationSessionFlipDetail(
      ValidationSessionInfoFlips validationSessionInfoFlip) {
    if (validationSessionInfoFlip != null &&
        validationSessionInfoFlip.listImagesLeft != null &&
        validationSessionInfoFlip.listImagesLeft.length == 4 &&
        validationSessionInfoFlip.listImagesRight != null &&
        validationSessionInfoFlip.listImagesRight.length == 4) {
      print("flip listeimages déjà rempli " + index.toString());
    } else {
      print("flip listeimages pas rempli " + index.toString());
      getValidationSessionFlipDetail(validationSessionInfoFlip, _simulationMode)
          .then((value) {
        _inValidationSessionInfoFlips.add(value);
        validationSessionInfo.listSessionValidationFlips[index] = value;
        print("flip listeimages pas rempli ok " + index.toString());

      });
    }
  }

  void _handleSelectFlip(
      ValidationSessionInfoFlips validationSessionInfoFlips) {
    _inValidationSessionInfoFlips.add(validationSessionInfoFlips);
  }

  void _handleValidationSessionInfoContext(
      ValidationSessionInfoContext validationSessionInfoContext) {
    // First, let's record the new filter information
    _simulationMode = validationSessionInfoContext.simulationMode;
    _epochPeriod = validationSessionInfoContext.epochPeriod;

    // Let's notify who needs to know
    _inSimulationMode.add(_simulationMode);
    _inEpochPeriod.add(_epochPeriod);

    _handleLoadValidationSessionInfo();
  }

  void _handleIndexes(int numIndex) {
    index = numIndex;
  }

  void _notify() {
    // Send to whomever is interested...
  }
}
