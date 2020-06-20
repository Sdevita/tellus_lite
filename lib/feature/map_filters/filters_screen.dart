import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';
import 'package:telluslite/common/widgets/appbar/app_navigation_bar.dart';
import 'package:telluslite/common/widgets/slider/tellus_slider.dart';
import 'package:telluslite/feature/map_filters/filters_viewmodel.dart';
import 'package:telluslite/feature/map_filters/models/time_filter_type.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  FiltersViewModel viewModel;
  ThemeData theme;
  MediaQueryData _mediaQuery;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    viewModel = Provider.of(context);
    _mediaQuery = MediaQuery.of(context);


    return BaseWidget(loader: viewModel.loader , blurredLoader: true , body: _buildBody(context));
  }

  _buildBody(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAppBar(context),
            _buildDistanceWidget(context),
            _buildMagnitudeWidget(context),
            _buildTimeFilterList(),
          ],
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppNavigationBar(
      leftWidget: Icon(
        Icons.cancel,
        color: Colors.redAccent,
        size: 30,
      ),
      onLeftWidgetTapped: () {
        viewModel.onCancelTapped(context);
      },
      centerWidget: ECText(
        "Filters",
        align: TextAlign.center,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      rightWidget: ECText(
        "Apply",
        color: theme.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      onRightWidgetTapped: () {
        viewModel.onApplyTapped();
      },
    );
  }

  _buildDistanceWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ECText(
                "Distance".toUpperCase(),
                fontSize: 14,
                align: TextAlign.start,
                fontWeight: FontWeight.w200,
                color: theme.primaryColor,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ECText(
            "Display all earthquakes within selected radius",
            fontSize: 14,
            align: TextAlign.start,
            fontWeight: FontWeight.w200,
            color: theme.primaryColor.withOpacity(.5),
          ),
        ),
        TellusSlider(
          defaultValue: viewModel.distance,
          maxValue: 1000,
          minValue: 100,
          isInt: true,
          onChange: (value) {
            viewModel.onDistanceChanged(value.toInt());
          },
        ),
      ],
    );
  }

  _buildMagnitudeWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ECText(
                "Magnitude".toUpperCase(),
                fontSize: 14,
                align: TextAlign.start,
                fontWeight: FontWeight.w200,
                color: theme.primaryColor,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ECText(
            "Display all earthquakes above the selected minimum magnitude",
            fontSize: 14,
            align: TextAlign.start,
            fontWeight: FontWeight.w200,
            color: theme.primaryColor.withOpacity(.5),
          ),
        ),
        TellusSlider(
          defaultValue: viewModel.minMagnitude,
          maxValue: 8,
          minValue: 1,
          isInt: true,
          leftLabel: ">",
          unit: "° Richter",
          step: 1,
          onChange: (value) {
            viewModel.onMagnitudeChanged(value.toInt());
          },
        ),
      ],
    );
  }

  _buildTimeFilterList(){
    var items = TimeFilterType.values;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ECText(
            "TIME".toUpperCase(),
            fontSize: 14,
            align: TextAlign.start,
            fontWeight: FontWeight.w200,
            color: theme.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ECText(
              "Display all earthquakes that have occurred in the selected time interval",
              fontSize: 14,
              align: TextAlign.start,
              fontWeight: FontWeight.w200,
              color: theme.primaryColor.withOpacity(.5),
            ),
          ),
          LimitedBox(
            maxHeight: 100,
            child: ListView.builder(
              shrinkWrap: true,
              controller: viewModel.scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
                itemBuilder: (context, index){
                bool isSelected = items[index] == viewModel.selectedTimeFilterType;
              return InkWell(
                splashColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 135,
                    child: Chip(
                      backgroundColor: theme.unselectedWidgetColor,
                      avatar: CircleAvatar(
                        backgroundColor: isSelected? theme.primaryColor : theme.backgroundColor,
                        child: isSelected? Icon(Icons.done, color: theme.backgroundColor,) : IgnorePointer() ,
                      ),
                      label: ECText(
                        items[index].getLabel(),
                        color: isSelected ? theme.accentColor : Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  viewModel.onTimeItemTap(items[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
