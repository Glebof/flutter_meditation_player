import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeditationAppScreen extends StatefulWidget {
  @override
  _MeditationAppScreenState createState() => _MeditationAppScreenState();
}

class _MeditationAppScreenState extends State<MeditationAppScreen> {
  final List<Item> items = [
    Item(
      name: "Forest",
      audioPath: "meditation_audios/forest.mp3",
      imagePath: "meditation_images/forest.jpeg",
    ),
    Item(
      name: "Night",
      audioPath: "meditation_audios/night.mp3",
      imagePath: "meditation_images/night.jpeg",
    ),
    Item(
      name: "Ocean",
      audioPath: "meditation_audios/ocean.mp3",
      imagePath: "meditation_images/ocean.jpeg",
    ),
    Item(
      name: "Waterfall",
      audioPath: "meditation_audios/waterfall.mp3",
      imagePath: "meditation_images/waterfall.jpeg",
    ),
    Item(
      name: "Wind",
      audioPath: "meditation_audios/wind.mp3",
      imagePath: "meditation_images/wind.jpeg",
    ),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  int? playingIndex;

  // Widget showIcon(int currentIndex) {
  //   if(playingIndex == currentIndex){
  //     return FaIcon(FontAwesomeIcons.stop);
  //   } else {
  //     return FaIcon(FontAwesomeIcons.play);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(items[index].imagePath),
                  ),
                ),
                child: ListTile(
                  title: Text(items[index].name),
                  leading: IconButton(
                    icon: playingIndex == index
                        ? FaIcon(FontAwesomeIcons.stop)
                        : FaIcon(FontAwesomeIcons.play),
                    onPressed: () async { // делаем его асинхронным
                      if (playingIndex == index) {
                        setState(() {
                          playingIndex = null;
                        });
                        audioPlayer.stop();
                      } else {
                        try {
                          await audioPlayer // будем ждать пока этот метод исполнится
                              .setAsset(items[index].audioPath)
                              .catchError((onError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red.withOpacity(0.5),
                                content: Text("Oops, an error has occurred..."),
                              ),
                            );
                          });

                          audioPlayer.play();
                          setState(() {
                            playingIndex = index;
                          });
                        } catch (error) {}
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
