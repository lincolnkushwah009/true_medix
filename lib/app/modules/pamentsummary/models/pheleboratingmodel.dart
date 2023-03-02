class PheleboRatingModel {
  String? phleboName;
  String? phleboContact;
  Ratings? ratings;

  PheleboRatingModel({this.phleboName, this.phleboContact, this.ratings});

  PheleboRatingModel.fromJson(Map<String, dynamic> json) {
    phleboName = json['phlebo_name'];
    phleboContact = json['phlebo_contact'];
    ratings =
        json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phlebo_name'] = phleboName;
    data['phlebo_contact'] = phleboContact;
    if (ratings != null) {
      data['ratings'] = ratings!.toJson();
    }
    return data;
  }
}

class Ratings {
  int? total;
  int? roundRating;
  int? avgRating;
  int? totalOrdersServed;

  Ratings(
      {this.total, this.roundRating, this.avgRating, this.totalOrdersServed});

  Ratings.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    roundRating = json['round_rating'];
    avgRating = json['avg_rating'];
    totalOrdersServed = json['total_orders_served'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['round_rating'] = roundRating;
    data['avg_rating'] = avgRating;
    data['total_orders_served'] = totalOrdersServed;
    return data;
  }
}
