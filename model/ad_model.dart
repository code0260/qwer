class AdModel {
  String? adsId;
  String? adsTitle;
  String? adsBody;
  String? adsDatatime;
  String? adsColor;
  String? adsColorCircle;

  AdModel(
      {this.adsId,
      this.adsTitle,
      this.adsBody,
      this.adsDatatime,
      this.adsColor,
      this.adsColorCircle});

  AdModel.fromJson(Map<String, dynamic> json) {
    adsId = json['ads_id'];
    adsTitle = json['ads_title'];
    adsBody = json['ads_body'];
    adsDatatime = json['ads_datatime'];
    adsColor = json['ads_color'];
    adsColorCircle = json['ads_color_circle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ads_id'] = adsId;
    data['ads_title'] = adsTitle;
    data['ads_body'] = adsBody;
    data['ads_datatime'] = adsDatatime;
    data['ads_color'] = adsColor;
    data['ads_color_circle'] = adsColorCircle;
    return data;
  }
}
