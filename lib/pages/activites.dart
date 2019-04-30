import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khel_ke_baat_karen/pages/draggable_game.dart';
import 'package:khel_ke_baat_karen/utils/db_helper.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/activities/activities.dart';
import '../scoped-models/main.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import '../widgets/ui_elements/logout_list_tile.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import './add_question.dart';
import './quiz_home.dart';
import '../models/activity_sqflite.dart';
import '../pages/reward_page.dart';

class ActivitiesPage extends StatefulWidget {
  final MainModel model;
  ActivitiesPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ActivitiesPageState();
  }
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  int currentPage = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ActivitySQFLITE> activityList;
  int count = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  initState() {
    widget.model.fetchActivities();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Manage Activites'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Add Questions'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AddQuestion();
                    },
                  ),
                );
              }),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Set Reward'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Reward();
                  },
                ),
              );
            },
          ),
          Divider(),
          LogoutListTile()
        ],
      ),
    );
  }

  Widget _buildActivitiesList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Activities for Now!'));
        if (model.displayActivities.length > 0 && !model.isLoading) {
          content = Activities();
        } else if (model.isLoading) {
          content = Center(
              child: SpinKitCubeGrid(
            color: Theme.of(context).accentColor,
            size: 80.0,
          ));
        }
        return RefreshIndicator(
            onRefresh: model.fetchActivities, child: content);
      },
    );
  }

  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;
  void _onTap() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //<-- on the next frame...
      setState(() => rect = rect.inflate(1.3 *
          MediaQuery.of(context).size.longestSide)); //<-- set rect to be big
      Future.delayed(animationDuration + delay,
          _goToNextPage); //<-- after delay, go to next page
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: MyAppTTS()))
        .then((_) => setState(() => rect = null));
  }

  @override
  Widget build(BuildContext context) {
    if (activityList == null) {
      activityList = List<ActivitySQFLITE>();
    }
    return Stack(
      children: <Widget>[
        Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text(
              'Khel Ke Baat Karen',
            ),
            actions: <Widget>[
              ScopedModelDescendant<MainModel>(
                builder:
                    (BuildContext context, Widget widget, MainModel model) {
                  return IconButton(
                    icon: Icon(model.displayFavoritesOnly
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      model.toggleDisplayMode();
                    },
                  );
                },
              )
            ],
          ),
          body: _buildActivitiesList(),
          bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(
                  iconData: Icons.calendar_today,
                  title: "Today",
                  onclick: () {
                    final FancyBottomNavigationState fState =
                        bottomNavigationKey.currentState;
                    fState.setPage(2);
                  }),
              TabData(
                  iconData: Icons.gamepad,
                  title: "Questions Game",
                  onclick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TutorialHome()))),
              TabData(
                  iconData: Icons.games,
                  title: "Drag game",
                  onclick: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DragGame())))
            ],
            initialSelection: 1,
            key: bottomNavigationKey,
            onTabChangedListener: (position) {
              setState(() {
                currentPage = position;
              });
            },
          ),
          floatingActionButton: RectGetter(
            key: rectGetterKey,
            child: FloatingActionButton(
                child: Icon(Icons.question_answer), onPressed: _onTap),
          ),
        ),
        _ripple()
      ],
    );
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      //<--replace Positioned with AnimatedPositioned
      duration: animationDuration, //<--specify the animation duration
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lime,
        ),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

class New extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deciding what to put here"),
      ),
      body: Container(),
    );
  }
}

class MyAppTTS extends StatefulWidget {
  @override
  _MyAppTTSState createState() => _MyAppTTSState();
}

enum TtsState { playing, stopped }

class _MyAppTTSState extends State<MyAppTTS> {
  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }

  Future _speak() async {
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (String type in languages) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getVoiceDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (String type in voices) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage('en-IN');
    });
  }

  void changedVoiceDropDownItem(String selectedType) {
    setState(() {
      voice = selectedType;
      flutterTts.setVoice(voice);
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Baat Karen'),
              backgroundColor: Theme.of(context).accentColor,
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  inputSection(),
                  btnSection(),
                  languages != null ? languageDropDownSection() : Text(""),
                  voices != null ? voiceDropDownSection() : Text("")
                ]))));
  }

  Widget inputSection() => Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 25.0, left: 95.0, right: 95.0),
        child: TextField(
          decoration: InputDecoration(
              helperStyle: TextStyle(
                fontSize: 28,
              ),
              helperText: "Write here what you want to say!"),
          onChanged: (String value) {
            _onChange(value);
          },
        ),
      );

  Widget btnSection() => Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _buildButtonColumn(Colors.green, Colors.greenAccent,
            Icons.play_circle_outline, 'PLAY', _speak),
        _buildButtonColumn(
            Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop)
      ]));

  Widget languageDropDownSection() => Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguageDropDownMenuItems(),
          onChanged: changedLanguageDropDownItem,
        )
      ]));

  Widget voiceDropDownSection() => Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: voice,
          items: getVoiceDropDownMenuItems(),
          onChanged: changedVoiceDropDownItem,
        )
      ]));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              iconSize: 80.0,
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }
}
