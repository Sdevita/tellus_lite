import 'package:flutter/material.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/utils/resources_utils.dart';
import 'package:telluslite/common/widgets/alert/base_alert_widget.dart';
import 'package:telluslite/navigation/Routes.dart';

class EmptyDataScreen extends StatefulWidget {
  @override
  _EmptyDataScreenState createState() => _EmptyDataScreenState();
}

class _EmptyDataScreenState extends State<EmptyDataScreen> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return BaseWidget(
      body: BaseAlertWidget(
        title: "No content available",
        message: "No content available",
        image: ResourcesUtils.getSvg("noData"),
        isButtonVisible: true,
        buttonText: "Retry",
        onButtonPressed: (){
            Routes.sailor.pop();
        },
      ),
    );
  }
}
