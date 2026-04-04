class UserModel {
  final int? id;
  final int? guestId;
  final String? name;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? mobile;
  final String? deviceId;
  final String? deviceType;
  final String? deviceToken;
  final String? lang;
  final String? token;
  final String? profilePic;
  final String? updatedAt;
  final String? createdAt;
  UserModel({
    this.id,
    this.guestId,
    this.name,
    this.lastName,
    this.email,
    this.countryCode,
    this.mobile,
    this.deviceId,
    this.deviceType,
    this.deviceToken,
    this.lang,
    this.token,
    this.profilePic,
    this.updatedAt,
    this.createdAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: _toInt(json['id']),
    guestId: _toInt(json['guest_id']),
    name: json['name']?.toString(),
    lastName: json['last_name']?.toString(),
    email: json['email']?.toString(),
    countryCode: json['country_code']?.toString(),
    mobile: json['mobile']?.toString(),
    deviceId: json['device_id']?.toString(),
    deviceType: json['device_type']?.toString(),
    deviceToken: json['device_token']?.toString(),
    lang: json['lang']?.toString(),
    token: json['token']?.toString(),
    profilePic: json['profile_pic']?.toString(),
    updatedAt: json['updated_at']?.toString(),
    createdAt: json['created_at']?.toString(),
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'guest_id': guestId,
    'name': name,
    'last_name': lastName,
    'email': email,
    'country_code': countryCode,
    'mobile': mobile,
    'device_id': deviceId,
    'device_type': deviceType,
    'device_token': deviceToken,
    'lang': lang,
    'token': token,
    'profile_pic': profilePic,
    'updated_at': updatedAt,
    'created_at': createdAt,
  };
  UserModel copyWith({
    int? id,
    int? guestId,
    String? name,
    String? lastName,
    String? email,
    String? countryCode,
    String? mobile,
    String? deviceId,
    String? deviceType,
    String? deviceToken,
    String? lang,
    String? token,
    String? profilePic,
    String? updatedAt,
    String? createdAt,
  }) => UserModel(
    id: id ?? this.id,
    guestId: guestId ?? this.guestId,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    countryCode: countryCode ?? this.countryCode,
    mobile: mobile ?? this.mobile,
    deviceId: deviceId ?? this.deviceId,
    deviceType: deviceType ?? this.deviceType,
    deviceToken: deviceToken ?? this.deviceToken,
    lang: lang ?? this.lang,
    token: token ?? this.token,
    profilePic: profilePic ?? this.profilePic,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
