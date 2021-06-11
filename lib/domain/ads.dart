class Ads {
  String title;
  String description;

  Ads(this.title, this.description);

  Ads.fromJson(String title, String description) {
    // id = id;
    title = title;
    description = description;
  }
}
