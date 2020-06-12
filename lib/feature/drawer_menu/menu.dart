import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';

/// Menu widget allows to show a list of
/// [MenuItem] elements that let the user
/// navigate through the app
class Menu extends StatelessWidget {
  final double spaceFromAppBar;
  final List<Widget> items;


  const Menu(
      {Key key,
        this.spaceFromAppBar,
        this.items,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ECText(
                            "Tellus",
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: spaceFromAppBar),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) => items[index],
                    itemCount: items.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 32);
                    },
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Container(
                      height: 2,
                      width: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ))),
    );
  }
}
