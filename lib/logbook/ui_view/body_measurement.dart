import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tgp_app/global.dart' as globals;
import 'package:tgp_app/logbook/logbook_theme.dart';

class BodyMeasurementView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  BodyMeasurementView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _BodyMeasurementViewState createState() => _BodyMeasurementViewState();
}

class _BodyMeasurementViewState extends State<BodyMeasurementView> {
  _selectDate(BuildContext context) async {}
  double _currentTemp = globals.AirTemp;
  double _currentTempwat = globals.WaterTemperature;
  int _duration = globals.Duration;
  double _depth = globals.Depth;

  void initState() {
    globals.date = DateTime.now();
    super.initState();
  }

  void _showDialogdepth() {
    showDialog<double>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.decimal(
            minValue: -50,
            maxValue: 50,
            title: new Text("Tiefe des Tauchgangs"),
            initialDoubleValue: _depth,
          );
        }).then((double value) {
      if (value != null) {
        setState(() => _depth = value);
        globals.Depth = value;
      }
    });
  }

  void _showDialogTemp() {
    showDialog<double>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.decimal(
            minValue: -50,
            maxValue: 50,
            title: new Text("Temperatur über Wasser"),
            initialDoubleValue: _currentTemp,
          );
        }).then((double value) {
      if (value != null) {
        setState(() => _currentTemp = value);
        globals.AirTemp = value;
      }
    });
  }

  void _showDialogTempwat() {
    showDialog<double>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.decimal(
            minValue: -50,
            maxValue: 50,
            title: new Text("Temperatur unter Wasser"),
            initialDoubleValue: _currentTempwat,
          );
        }).then((double value) {
      if (value != null) {
        setState(() => _currentTempwat = value);
        globals.WaterTemperature = value;
      }
    });
  }

  void _showDialogduration() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 0,
            maxValue: 500,
            title: new Text("Dauer des Tauchgangs"),
            initialIntegerValue: _duration,
          );
        }).then((num value) {
      if (value != null) {
        setState(() => _duration = value);
        globals.Duration = value;
      }
    });
  }

  String _date = "Auswahl";

  String _temp = "Auswahl";
  String _time = "Not set";
  String _text = "Not set";
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FintnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FintnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, bottom: 8, top: 16),
                            child: Text(
                              'Tiefe',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: FintnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: FintnessAppTheme.darkText),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      _showDialogdepth();
                                    },
                                    child: Text(
                                      '$_depth',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FintnessAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 32,
                                        color: FintnessAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 1, bottom: 8),
                                    child: Text(
                                      'm',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FintnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: FintnessAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        color: FintnessAppTheme.grey
                                            .withOpacity(0.5),
                                        size: 16,
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            DatePicker.showDateTimePicker(
                                                context,
                                                showTitleActions: true,
                                                onConfirm: (date) {
                                              String formattedDate = DateFormat(
                                                      'dd.MM.yyyy | kk:mm')
                                                  .format(date);
                                              globals.date = date;
                                              print(globals.date);
                                              _date = '${formattedDate} Uhr';
                                              setState(() {});
                                            },
                                                currentTime: globals.date,
                                                locale: LocaleType.de);
                                          },
                                          child: Text(
                                            '$_date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FintnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FintnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: FintnessAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      _showDialogTemp();
                                    },
                                    child: Text(
                                      '$_currentTemp °C',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FintnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: FintnessAppTheme.darkText,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Text(
                                    'Luft Temperatur',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FintnessAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: FintnessAppTheme.grey
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          _showDialogTempwat();
                                        },
                                        child: Text(
                                          '$_currentTempwat °C',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FintnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: FintnessAppTheme.darkText,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        'Wasser Temperatur',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FintnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: FintnessAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          _showDialogduration();
                                        },
                                        child: Text(
                                          '$_duration min',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FintnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: FintnessAppTheme.darkText,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        'Dauer',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FintnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: FintnessAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
