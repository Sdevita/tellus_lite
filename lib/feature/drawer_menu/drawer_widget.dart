import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/utils/resources_utils.dart';
import 'package:telluslite/navigation/Routes.dart';

import 'drawer_viewmodel.dart';
import 'menu.dart';
import 'models/menu_item.dart';

class DrawerMenu extends StatefulWidget {
  final Widget child;
  final Function(bool) onDrawerClosed;
  final VoidCallback onDrawerOpened;

  const DrawerMenu(
      {Key key, this.child, this.onDrawerClosed, this.onDrawerOpened})
      : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  DrawerViewModel viewModel;
  double width, height;
  AnimationController _animController;
  Animation<double> _scaleAnimation;
  ThemeData theme;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.8).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    viewModel = Provider.of<DrawerViewModel>(context);
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.blue[800],
                Colors.blue[900],
                Colors.purple[800]
              ])),
        ),
        SingleChildScrollView(child: getMenu(context)),
        getAppScreen(context),
      ],
    );
  }

  /// Build Menu screen elements
  Widget getMenu(BuildContext context) {
    return Menu(
      spaceFromAppBar: 48,
      items: getMenuItems(context),
    );
    return Container();
  }

  /// Build menu elements using [MenuItem] widget
  List<Widget> getMenuItems(context) {
    List<Widget> menuItems = List();
    menuItems = [_buildMapMenu(context), _buildSettingsMenu(context)];
    return menuItems;
  }

  MenuItem _buildMapMenu(context) {
    return MenuItem(
      icon: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: ResourcesUtils.getSvg("marker",
            width: 24, height: 24, color: Colors.white), //SVG has no padding
      ),
      textColor: Colors.white,
      text: "Home",
      onPressed: () {
        viewModel.navigateToSection(context, Routes.home);
      },
    );
  }

  MenuItem _buildSettingsMenu(context) {
    return MenuItem(
      icon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Icon(
            Icons.settings,
            color: Colors.white,
          )),
      textColor: Colors.white,
      text: "Settings",
      onPressed: () {
        viewModel.navigateToSection(context, Routes.settingsRoute);
      },
    );
  }

  Widget getAppScreen(context) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        top: viewModel.isDrawerClosed ? 0 : 0.10 * height,
        bottom: viewModel.isDrawerClosed ? 0 : 0.10 * height,
        left: viewModel.isDrawerClosed ? 0 : 0.70 * width,
        right: viewModel.isDrawerClosed ? 0 : -0.7 * width,
        curve: Curves.elasticOut,
        onEnd: () {
          if (viewModel.isDrawerClosed && widget.onDrawerClosed != null) {
            widget.onDrawerClosed(viewModel.withNavigation);
          } else if (!viewModel.isDrawerClosed &&
              widget.onDrawerOpened != null) {
            widget.onDrawerOpened();
          }
        },
        child: ScaleTransition(
            scale: _scaleAnimation,
            child: GestureDetector(
                child: InkWell(
                    child: IgnorePointer(
                  ignoring: !viewModel.isDrawerClosed,
                  child: ClipRRect(
                    child: widget.child,
                    borderRadius: BorderRadius.all(
                        Radius.circular(viewModel.isDrawerClosed ? 0 : 50)),
                  ),
                )),
                onHorizontalDragEnd: !viewModel.isDrawerClosed
                    ? (details) {
                        viewModel.dismissDrawer();
                      }
                    : (details) {},
                onTap: !viewModel.isDrawerClosed
                    ? () {
                        viewModel.dismissDrawer();
                      }
                    : () {} //DO NOTHING
                )));
  }
}