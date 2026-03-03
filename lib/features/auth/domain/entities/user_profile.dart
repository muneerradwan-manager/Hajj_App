import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
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
  final UserGroup group;
  final UserMasterGroup masterGroup;
  final UserFlight? departureFlight;
  final UserFlight? returnFlight;

  const UserProfile({
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

  @override
  List<Object?> get props => [
    userId,
    email,
    phone,
    barcode,
    pilgrimId,
    fullName,
    nationalityNumber,
    isMale,
    imgPath,
    passPath,
    officeName,
    officePhone,
    group,
    masterGroup,
    departureFlight,
    returnFlight,
  ];
}

class UserGroup extends Equatable {
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
  final List<UserApplicant> applicants;

  const UserGroup({
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

  @override
  List<Object?> get props => [
    groupName,
    maccaHotel,
    maccaHotelLocation,
    madinaHotel,
    madinaHotelLocation,
    mutawwef,
    arrafatCampNo,
    arrafatCompLocation,
    minaCampNo,
    minaCampLocation,
    applicants,
  ];
}

class UserMasterGroup extends Equatable {
  final String masterGroupName;
  final List<UserApplicant> applicants;

  const UserMasterGroup({
    required this.masterGroupName,
    required this.applicants,
  });

  @override
  List<Object?> get props => [masterGroupName, applicants];
}

class UserApplicant extends Equatable {
  final String fullName;
  final String applicantType;
  final String telNum;
  final String whatsapp;
  final String saudiNum;

  const UserApplicant({
    required this.fullName,
    required this.applicantType,
    required this.telNum,
    required this.whatsapp,
    required this.saudiNum,
  });

  @override
  List<Object?> get props => [
    fullName,
    applicantType,
    telNum,
    whatsapp,
    saudiNum,
  ];
}

class UserFlight extends Equatable {
  final String flightName;
  final DateTime? departureDate;
  final String departureTime;
  final String departureAirport;
  final DateTime? arrivalDate;
  final String arrivalTime;
  final String arrivalAirport;
  final String airlineCompany;

  const UserFlight({
    required this.flightName,
    required this.departureDate,
    required this.departureTime,
    required this.departureAirport,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.arrivalAirport,
    required this.airlineCompany,
  });

  @override
  List<Object?> get props => [
    flightName,
    departureDate,
    departureTime,
    departureAirport,
    arrivalDate,
    arrivalTime,
    arrivalAirport,
    airlineCompany,
  ];
}
