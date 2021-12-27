// To parse this JSON data, do
//
//     final Pools = PoolsFromJson(jsonString);

import 'dart:convert';

Pools PoolsFromJson(String str){
  print("INSIDE THE POOLS FROM JSON");
  return Pools.fromJson(json.decode(str));
}

String PoolsToJson(Pools data) => json.encode(data.toJson());

class Pools {
    Pools({
        required this.statusCode,
        required this.data,
        required this.statusText,
    });

    int statusCode;
    List<Datum> data;
    String statusText;

    factory Pools.fromJson(Map<String, dynamic> json) => Pools(
        statusCode: json["status_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        statusText: json["status_text"],
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status_text": statusText,
    };
}

class Datum {
    Datum({
        required this.poolStatus,
        required this.endDate,
        required this.startDate,
        required this.numOfGames,
        required this.sportType,
        required this.matches,
        required this.poolId,
        required this.updatedDate,
    });

    String poolStatus;
    int endDate;
    int startDate;
    int numOfGames;
    String sportType;
    List<Match> matches;
    String poolId;
    int updatedDate;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        poolStatus: json["pool_status"],
        endDate: json["end_date"],
        startDate: json["start_date"],
        numOfGames: json["num_of_games"],
        sportType: json["sport_type"],
        matches: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
        poolId: json["pool_id"],
        updatedDate: json["updated_date"],
    );

    Map<String, dynamic> toJson() => {
        "pool_status": poolStatus,
        "end_date": endDate,
        "start_date": startDate,
        "num_of_games": numOfGames,
        "sport_type": sportType,
        "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
        "pool_id": poolId,
        "updated_date": updatedDate,
    };
}

class Match {
    Match({
        required this.date,
        required this.away,
        required this.homeScore,
        required this.awayScore,
        required this.name,
        required this.awayAbbreviation,
        required this.id,
        required this.homeAbbreviation,
        required this.status,
        required this.home,
    });

    String date;
    String away;
    String homeScore;
    String awayScore;
    String name;
    String awayAbbreviation;
    String id;
    String homeAbbreviation;
    Status? status;
    String home;

    factory Match.fromJson(Map<String, dynamic> json) => Match(
        date: json["date"],
        away: json["away"],
        homeScore: json["home_score"],
        awayScore: json["away_score"],
        name: json["name"],
        awayAbbreviation: json["away_abbreviation"],
        id: json["id"],
        homeAbbreviation: json["home_abbreviation"],
        status: statusValues.map[json["status"]],
        home: json["home"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "away": away,
        "home_score": homeScore,
        "away_score": awayScore,
        "name": name,
        "away_abbreviation": awayAbbreviation,
        "id": id,
        "home_abbreviation": homeAbbreviation,
        "status": statusValues.reverse[status],
        "home": home,
    };
}

enum Status { STATUS_FINAL, STATUS_POSTPONED }

final statusValues = EnumValues({
    "STATUS_FINAL": Status.STATUS_FINAL,
    "STATUS_POSTPONED": Status.STATUS_POSTPONED
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap = Map();

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
