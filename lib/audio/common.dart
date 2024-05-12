import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mafatih/library/Globals.dart' as globals;

class SeekBar extends StatefulWidget {
  final Duration? duration;
  final Duration? position;
  final Duration? bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    Key? key,
     this.duration,
     this.position,
     this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);



  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
   late SliderThemeData _sliderThemeData;


  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(
          //   width: 20,),
              Text(

    replaceFarsiNumber(RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
        .firstMatch("$_remaining")
        ?.group(1) ??
    '$_remaining')
                  ,
                  // style: Theme.of(context).textTheme.caption,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'عربی ساده',
                  fontSize: 24,
                  color:  Theme.of(context).brightness == Brightness.light
    ? Colors.black
        : Colors.white,
              )),
          SliderTheme(
            data: _sliderThemeData.copyWith(
              inactiveTrackColor: Colors.transparent,
              trackHeight: 4.0,
            ),
            child: RotatedBox(
              quarterTurns: 2,

              child: Slider(
                // activeColor: Color(0xf6c40c0c),
                activeColor:                              Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.green,
                inactiveColor: Colors.white,
                min: 0.0,
                max: widget.duration!.inMilliseconds.toDouble(),
                value: min(_dragValue ?? widget.position!.inMilliseconds.toDouble(),
                    widget.duration!.inMilliseconds.toDouble()),
                onChanged: (value) {
                  setState(() {
                    _dragValue = value;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(Duration(milliseconds: value.round()));
                  }
                },
                onChangeEnd: (value) {
                  if (widget.onChangeEnd != null) {
                    widget.onChangeEnd!(Duration(milliseconds: value.round()));
                  }
                  _dragValue = null;
                },
              ),
            ),
          ),

        ],
      );
  }



  Duration get _remaining => widget.duration! - widget.position!;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
      PaintingContext context,
      Offset center, {
         Animation<double>? activationAnimation,
         Animation<double>? enableAnimation,
         bool? isDiscrete,
         TextPainter? labelPainter,
         RenderBox? parentBox,
         SliderThemeData? sliderTheme,
         TextDirection? textDirection,
         double? value,
         double? textScaleFactor,
         Size? sizeWithOverflow,
      }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
   required BuildContext context,
   String? title,
   int? divisions,
   double? min,
   double? max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
   double? value,
   Stream<double>? stream,
   ValueChanged<double>? onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title!, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              RotatedBox(
                quarterTurns: 2,
                child: Slider(
                  divisions: divisions,
                  min: min!,
                  max: max!,
                  value: snapshot.data ?? value!,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

T ambiguate<T>(T value) => value;