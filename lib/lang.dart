class Lang {
  static Map en = {
    "year":"years",
    "month":"months",
    "week":"weeks",
    "day":"days",
    "ago":"ago",
    "until":"until"
  };
  static get(String key){
    return en[key];
  }
}