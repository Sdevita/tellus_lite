import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/utils/resources_utils.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';
import 'package:telluslite/common/widgets/appbar/app_bar.dart';
import 'package:telluslite/feature/drawer_menu/drawer_widget.dart';
import 'package:telluslite/feature/home/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel viewModel;
  ThemeData theme;
  ScrollController controller = ScrollController();
  PageController pageController = PageController(viewportFraction: 0.7);
  bool closeTopContainer = false;
  double topContainer = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("World"),
    1: Text("Near you")
  };
  int segmentedControlGroupValue = 0;

  List<Widget> itemsData = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        itemsData = viewModel.getPostsData(theme);
      });
    });
    controller.addListener(() {
      double value = controller.offset / 100;
      print(value);

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);
    theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: DrawerMenu(child: _buildBody(context)),
    );
  }

  _buildBody(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.25;
    return BaseWidget(
      loader: viewModel.loader,
      body: Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            TellusAppBar(
              leftIcon: Padding(
                  padding: EdgeInsets.all(10),
                  child: ResourcesUtils.getSvg('menu',
                      height: 48, width: 48, color: theme.primaryColor)),
              onLeftButtonTapped: () {
                viewModel.onMenuClicked(context);
              },
              title: ECText(
                "Welcome",
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
                align: TextAlign.center,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: closeTopContainer ? 0 : 1,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size.width,
                  alignment: Alignment.topCenter,
                  height: closeTopContainer ? 0 : categoryHeight,
                  child: _buildInfoScreen()),
            ),
            CupertinoSlidingSegmentedControl(
                groupValue: segmentedControlGroupValue,
                thumbColor: Colors.deepOrange,
                children: myTabs,
                onValueChanged: (i) {
                  setState(() {
                    segmentedControlGroupValue = i;
                  });
                }),
            Expanded(
                child: ListView.builder(
                    controller: controller,
                    itemCount: itemsData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      double scale = 1.0;
                      if (topContainer > 0.1) {
                        scale = index + 0.6 - topContainer;
                        if (scale < 0) {
                          scale = 0;
                        } else if (scale > 1) {
                          scale = 1;
                        }
                      }
                      return Opacity(
                        opacity: scale,
                        child: Transform(
                          transform: Matrix4.identity()..scale(scale, scale),
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              heightFactor: 0.7,
                              alignment: Alignment.topCenter,
                              child: itemsData[index]),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoScreen() {
    return PageView.builder(
        controller: pageController,
        itemCount: 2,
        itemBuilder: (BuildContext context, int itemIndex) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ECText(
                      "80",
                      fontSize: 35,
                    ),
                    ECText(" earthquakes")
                  ],
                ),
                ECText("In the last day")
              ],
            ),
          );
        });
  }
}
