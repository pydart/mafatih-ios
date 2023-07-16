import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SoundPlayer extends StatefulWidget
{
  String address;

  SoundPlayer({
     this.address
  });

  @override
  State<StatefulWidget> createState() => SoundPlayerState( address: address );
}

class SoundPlayerState extends State<SoundPlayer>
{

  //Global vriables
  int maxduration = 120;
  String address;
  AudioPlayer player = AudioPlayer();
  Icon play_ic_btn=Icon(Icons.play_arrow,color: Colors.black,);
  bool isplay=false;
  Duration currentpos=Duration.zero;
  SoundPlayerState({
     this.address
  });


  //initilize function start
  @override
  void initState() 
  {
    super.initState();

    player.getDuration().then((value) {
      setState(() {
        maxduration=value;
      });
    });

    player.onDurationChanged.listen((newDuration) { 
      setState(() {
        currentpos=newDuration;
      });
    });

    player.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        currentpos=newPosition;
      });
    });

  }
  //initilize function end



  //main function start
  @override
  Widget build(BuildContext context) 
  {
      return Directionality(
        textDirection: TextDirection.ltr, 
        child: Row(
        children: [
          
          SizedBox(
            child: TextButton(
              onPressed: () async {

                if(!isplay)
                {
                  player.resume();
                  isplay=true;
                  setState(() {
                    play_ic_btn=Icon(Icons.pause,color: Colors.black,);
                  });
                }
                else
                {
                  player.pause();
                  isplay=false;
                  setState(() {
                    play_ic_btn=Icon(Icons.play_arrow,color: Colors.black,);
                  });
                }


              }, 
              child: Center(child: play_ic_btn,)
            ),
          )
          ,
          Container(
            width: MediaQuery.of(context).size.width - 100,
            child: Slider(
                value: currentpos.inSeconds.toDouble(),
                min: 0,
                max: 140,
                onChanged: (double value) async {

                  debugPrint(value.toString());

                  setState(() {
                    currentpos = Duration(seconds: value.toInt());
                    player.seek(currentpos);
                  });
                  
                },
              )
          ),

        ],
      )
      );
  }
  //main function end


  @override
  void dispose() {
    player.stop();
    player.pause();
    super.dispose();
  }


}