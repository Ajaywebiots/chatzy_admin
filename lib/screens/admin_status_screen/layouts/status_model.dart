
class Status {
  List<PhotoUrl>? photoUrl;
  String? createdAt;
  bool? isSeenByOwn;

  Status(
      {
        this.photoUrl,
        this.createdAt,
        this.isSeenByOwn});

  Status.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    isSeenByOwn = json['isSeenByOwn'];
    if (json['photoUrl'] != null) {
      photoUrl = <PhotoUrl>[];
      json['photoUrl'].forEach((v) {
        photoUrl!.add(PhotoUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['isSeenByOwn'] = isSeenByOwn;
    if (photoUrl != null) {
      data['photoUrl'] = photoUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhotoUrl {
  String? image;
  String? timestamp;
  String? statusType;
  bool? isExpired;
  List? seenBy;

  PhotoUrl({this.image, this.timestamp, this.isExpired, this.statusType,this.seenBy});

  PhotoUrl.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    timestamp = json['timestamp'];
    isExpired = json['isExpired'];
    statusType = json['statusType'];
    seenBy = json['seenBy'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['timestamp'] = timestamp;
    data['isExpired'] = isExpired;
    data['statusType'] = statusType;
    if (seenBy!.isNotEmpty) {
      data['seenBy'] = seenBy;
    }
    return data;
  }
}