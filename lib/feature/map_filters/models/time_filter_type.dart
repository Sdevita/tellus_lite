enum TimeFilterType {
  oneWeek,
  oneMonth,
  threeMonth,
  sixMonth,
  oneYear
}

extension TimeFilterTypeExtension on TimeFilterType{
  int getDay(){
    switch(this){
      case TimeFilterType.oneWeek:
        return 7;
        break;
      case TimeFilterType.oneMonth:
        return 30;
        break;
      case TimeFilterType.threeMonth:
        return 90;
        break;
      case TimeFilterType.sixMonth:
        return 180;
        break;
      case TimeFilterType.oneYear:
        return 365;
        break;
    }
  }

  String getLabel(){
    //todo add translation
    switch(this){
      case TimeFilterType.oneWeek:
        return "One Week";
        break;
      case TimeFilterType.oneMonth:
        return "One Month";
        break;
      case TimeFilterType.threeMonth:
        return "Three Month";
        break;
      case TimeFilterType.sixMonth:
        return "Six Month";
        break;
      case TimeFilterType.oneYear:
        return "One Year";
        break;
    }
  }
}