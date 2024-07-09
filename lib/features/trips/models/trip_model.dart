class TripModel {
  String? createdDate;
  String? imageUrl;
  List<String>? joinedUsers;
  String? tripEnd;
  String? tripEndTime;
  String? tripStart;
  String? tripStartTime;
  String? tripName;
  String? userId;

  TripModel(
      this.createdDate,
      this.imageUrl,
      this.joinedUsers,
      this.tripEnd,
      this.tripEndTime,
      this.tripStart,
      this.tripStartTime,
      this.tripName,
      this.userId);

  TripModel.fromJson(Map data) {
    createdDate = data['created_date'];
    imageUrl = data['image_url'];
    joinedUsers = data['joined_users'];
    tripEnd = data['trip_end'];
    tripEndTime = data['trip_end_time'];
    tripStart = data['trip_start'];
    tripStartTime = data['trip_start_time'];
    tripName = data['trip_name'];
    userId = data['user_id'];
  }

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_date'] = createdDate;
    data['image_url'] = imageUrl;
    data['joined_users'] = joinedUsers;
    data['trip_end'] = tripEnd;
    data['trip_end_time'] = tripEndTime;
    data['trip_start'] = tripStart;
    data['trip_start_time'] = tripStartTime;
    data['trip_name'] = tripName;
    data['user_id'] = userId;
    return data;
  }
}
