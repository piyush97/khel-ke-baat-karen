import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/activities/activities.dart';
import '../scoped-models/main.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import '../widgets/ui_elements/logout_list_tile.dart';

class ActivitiesPage extends StatefulWidget {
  final MainModel model;
  ActivitiesPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ActivitiesPageState();
  }
}

class _ActivitiesPageState extends State<ActivitiesPage> {
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
        .push(FadeRouteBuilder(page: NewPage()))
        .then((_) => setState(() => rect = null));
  }

  @override
  Widget build(BuildContext context) {
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
          bottomNavigationBar: FancyBottomNavigation(tabs: [
            TabData(iconData: Icons.today, title: "Today"),
            TabData(iconData: Icons.access_time, title: "Tomorrow"),
            TabData(iconData: Icons.games, title: "Games")
          ], onTabChangedListener: (_) => {}),
          floatingActionButton: RectGetter(
            key: rectGetterKey,
            child:
                FloatingActionButton(child: Text('Points'), onPressed: _onTap),
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

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Points Chart')),
      body: Center(
        child: Card(
          child: Center(
            child: Text(
              "300!!!",
              style: TextStyle(fontSize: 200),
            ),
          ),
        ),
      ),
    );
  }
}
