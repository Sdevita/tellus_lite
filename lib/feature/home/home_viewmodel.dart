import 'package:flutter/material.dart';
import 'package:telluslite/common/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  getPostsData(ThemeData themeData) {
    List<dynamic> responseList = FOOD_DATA;
    List<Widget> listItems = [];
    responseList.forEach(
      (post) {
        listItems.add(
          Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: themeData.brightness == Brightness.light ? Colors.white : themeData.buttonColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post["name"],
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post["brand"],
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${post["price"]}",
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return listItems;
  }
}

const FOOD_DATA = [
  {"name": "Tsunami", "brand": "Indonesia", "price": 2.99, "image": "burger.png"},
  {
    "name": "Earthquake",
    "brand": "Brazil",
    "price": 4.99,
    "image": "cheese_dip.png"
  },
  {"name": "Earthquake", "brand": "Italy", "price": 1.49, "image": "cola.png"},
  {"name": "Tsunami", "brand": "Chile", "price": 2.99, "image": "fries.png"},
  {
    "name": "Earthquake",
    "brand": "Italy",
    "price": 9.49,
    "image": "ice_cream.png"
  },
  {
    "name": "Earthquake",
    "brand": "Chile",
    "price": 4.49,
    "image": "noodles.png"
  },
  {"name": "Earthquake", "brand": "Greece", "price": 17.99, "image": "pizza.png"},
  {
    "name": "Earthquake",
    "brand": "USA",
    "price": 2.99,
    "image": "sandwich.png"
  },
  {"name": "Earthquake", "brand": "USA", "price": 6.99, "image": "wrap.png"}
];
