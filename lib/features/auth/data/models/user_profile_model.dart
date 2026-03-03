import 'package:bawabatelhajj/features/auth/domain/entities/user_profile.dart';

class UserProfileModel {
  final String userId;
  final String email;
  final String phone;
  final int barcode;
  final int pilgrimId;
  final String fullName;
  final String nationalityNumber;
  final bool isMale;
  final String imgPath;
  final String passPath;
  final String officeName;
  final String officePhone;
  final UserGroupModel group;
  final UserMasterGroupModel masterGroup;
  final UserFlightModel? departureFlight;
  final UserFlightModel? returnFlight;

  const UserProfileModel({
    required this.userId,
    required this.email,
    required this.phone,
    required this.barcode,
    required this.pilgrimId,
    required this.fullName,
    required this.nationalityNumber,
    required this.isMale,
    required this.imgPath,
    required this.passPath,
    required this.officeName,
    required this.officePhone,
    required this.group,
    required this.masterGroup,
    required this.departureFlight,
    required this.returnFlight,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: _toStringValue(json['userId']),
      email: _toStringValue(json['email']),
      phone: _toStringValue(json['phone']),
      barcode: _toInt(json['barcode']),
      pilgrimId: _toInt(json['pilgrimId']),
      fullName: _toStringValue(json['fullName']),
      nationalityNumber: _toStringValue(json['nationalityNumber']),
      isMale: _toBool(json['isMale']),
      imgPath: _toStringValue(json['imgPath']),
      passPath: _toStringValue(json['passPath']),
      officeName: _toStringValue(json['officeName']),
      officePhone: _toStringValue(json['officePhone']),
      group: UserGroupModel.fromJson(_asMap(json['group'])),
      masterGroup: UserMasterGroupModel.fromJson(_asMap(json['masterGroup'])),
      departureFlight: _toFlight(json['departureFlight']),
      returnFlight: _toFlight(json['returnFlight']),
    );
  }

  UserProfile toEntity() {
    return UserProfile(
      userId: userId,
      email: email,
      phone: phone,
      barcode: barcode,
      pilgrimId: pilgrimId,
      fullName: fullName,
      nationalityNumber: nationalityNumber,
      isMale: isMale,
      imgPath: imgPath,
      passPath: passPath,
      officeName: officeName,
      officePhone: officePhone,
      group: group.toEntity(),
      masterGroup: masterGroup.toEntity(),
      departureFlight: departureFlight?.toEntity(),
      returnFlight: returnFlight?.toEntity(),
    );
  }

  static UserFlightModel? _toFlight(dynamic value) {
    if (value == null) return null;
    return UserFlightModel.fromJson(_asMap(value));
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  static List<Map<String, dynamic>> _asMapList(dynamic value) {
    if (value is! List) return <Map<String, dynamic>>[];
    return value.map(_asMap).toList();
  }

  static String _toStringValue(dynamic value) {
    if (value == null) return '';
    return value.toString().trim();
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value.trim()) ?? 0;
    return 0;
  }

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      return normalized == 'true' || normalized == '1';
    }
    return false;
  }

  static DateTime? _toDate(dynamic value) {
    final text = _toStringValue(value);
    if (text.isEmpty) return null;
    return DateTime.tryParse(text);
  }
}

class UserGroupModel {
  final String groupName;
  final String maccaHotel;
  final String maccaHotelLocation;
  final String madinaHotel;
  final String madinaHotelLocation;
  final String mutawwef;
  final String arrafatCampNo;
  final String arrafatCompLocation;
  final String minaCampNo;
  final String minaCampLocation;
  final List<UserApplicantModel> applicants;

  const UserGroupModel({
    required this.groupName,
    required this.maccaHotel,
    required this.maccaHotelLocation,
    required this.madinaHotel,
    required this.madinaHotelLocation,
    required this.mutawwef,
    required this.arrafatCampNo,
    required this.arrafatCompLocation,
    required this.minaCampNo,
    required this.minaCampLocation,
    required this.applicants,
  });

  factory UserGroupModel.fromJson(Map<String, dynamic> json) {
    return UserGroupModel(
      groupName: UserProfileModel._toStringValue(json['groupName']),
      maccaHotel: UserProfileModel._toStringValue(json['maccaHotel']),
      maccaHotelLocation: UserProfileModel._toStringValue(
        json['maccaHotelLocation'],
      ),
      madinaHotel: UserProfileModel._toStringValue(json['madinaHotel']),
      madinaHotelLocation: UserProfileModel._toStringValue(
        json['madinaHotelLocation'],
      ),
      mutawwef: UserProfileModel._toStringValue(json['mutawwef']),
      arrafatCampNo: UserProfileModel._toStringValue(json['arrafatCampNo']),
      arrafatCompLocation: UserProfileModel._toStringValue(
        json['arrafatCompLocation'],
      ),
      minaCampNo: UserProfileModel._toStringValue(json['minaCampNo']),
      minaCampLocation: UserProfileModel._toStringValue(
        json['minaCampLocation'],
      ),
      applicants: UserProfileModel._asMapList(
        json['applicants'],
      ).map(UserApplicantModel.fromJson).toList(),
    );
  }

  UserGroup toEntity() {
    return UserGroup(
      groupName: groupName,
      maccaHotel: maccaHotel,
      maccaHotelLocation: maccaHotelLocation,
      madinaHotel: madinaHotel,
      madinaHotelLocation: madinaHotelLocation,
      mutawwef: mutawwef,
      arrafatCampNo: arrafatCampNo,
      arrafatCompLocation: arrafatCompLocation,
      minaCampNo: minaCampNo,
      minaCampLocation: minaCampLocation,
      applicants: applicants.map((item) => item.toEntity()).toList(),
    );
  }
}

class UserMasterGroupModel {
  final String masterGroupName;
  final List<UserApplicantModel> applicants;

  const UserMasterGroupModel({
    required this.masterGroupName,
    required this.applicants,
  });

  factory UserMasterGroupModel.fromJson(Map<String, dynamic> json) {
    return UserMasterGroupModel(
      masterGroupName: UserProfileModel._toStringValue(json['masterGroupName']),
      applicants: UserProfileModel._asMapList(
        json['applicants'],
      ).map(UserApplicantModel.fromJson).toList(),
    );
  }

  UserMasterGroup toEntity() {
    return UserMasterGroup(
      masterGroupName: masterGroupName,
      applicants: applicants.map((item) => item.toEntity()).toList(),
    );
  }
}

class UserApplicantModel {
  final String fullName;
  final String applicantType;
  final String telNum;
  final String whatsapp;
  final String saudiNum;

  const UserApplicantModel({
    required this.fullName,
    required this.applicantType,
    required this.telNum,
    required this.whatsapp,
    required this.saudiNum,
  });

  factory UserApplicantModel.fromJson(Map<String, dynamic> json) {
    return UserApplicantModel(
      fullName: UserProfileModel._toStringValue(json['fullName']),
      applicantType: UserProfileModel._toStringValue(json['applicantType']),
      telNum: UserProfileModel._toStringValue(json['telNum']),
      whatsapp: UserProfileModel._toStringValue(json['whatsapp']),
      saudiNum: UserProfileModel._toStringValue(json['saudiNum']),
    );
  }

  UserApplicant toEntity() {
    return UserApplicant(
      fullName: fullName,
      applicantType: applicantType,
      telNum: telNum,
      whatsapp: whatsapp,
      saudiNum: saudiNum,
    );
  }
}

class UserFlightModel {
  final String flightName;
  final DateTime? departureDate;
  final String departureTime;
  final String departureAirport;
  final DateTime? arrivalDate;
  final String arrivalTime;
  final String arrivalAirport;
  final String airlineCompany;

  const UserFlightModel({
    required this.flightName,
    required this.departureDate,
    required this.departureTime,
    required this.departureAirport,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.arrivalAirport,
    required this.airlineCompany,
  });

  factory UserFlightModel.fromJson(Map<String, dynamic> json) {
    return UserFlightModel(
      flightName: UserProfileModel._toStringValue(json['flightName']),
      departureDate: UserProfileModel._toDate(json['departureDate']),
      departureTime: UserProfileModel._toStringValue(json['departureTime']),
      departureAirport: UserProfileModel._toStringValue(
        json['departureAirport'],
      ),
      arrivalDate: UserProfileModel._toDate(json['arrivalDate']),
      arrivalTime: UserProfileModel._toStringValue(json['arrivalTime']),
      arrivalAirport: UserProfileModel._toStringValue(json['arrivalAirport']),
      airlineCompany: UserProfileModel._toStringValue(json['airlineCompany']),
    );
  }

  UserFlight toEntity() {
    return UserFlight(
      flightName: flightName,
      departureDate: departureDate,
      departureTime: departureTime,
      departureAirport: departureAirport,
      arrivalDate: arrivalDate,
      arrivalTime: arrivalTime,
      arrivalAirport: arrivalAirport,
      airlineCompany: airlineCompany,
    );
  }
}
