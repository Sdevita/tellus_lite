class UserConfiguration {
  bool hasDarkMode;
  int maxRadiusKm;
  int minMagnitude;
  int maxEta;
  int minDepth;

  UserConfiguration(
      {this.hasDarkMode,
      this.maxRadiusKm,
      this.minMagnitude,
      this.maxEta,
      this.minDepth});

  UserConfiguration.fromJson(Map<String, dynamic> json) {
    hasDarkMode = json['isDarkMode'];
    maxRadiusKm = json['maxRadiusKm'];
    minMagnitude = json['minMagnitude'];
    maxEta = json['maxEta'];
    minDepth = json['minDepth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDarkMode'] = this.hasDarkMode;
    data['maxRadiusKm'] = this.maxRadiusKm;
    data['minMagnitude'] = this.minMagnitude;
    data['maxEta'] = this.maxEta;
    data['minDepth'] = this.minDepth;
    return data;
  }
}
