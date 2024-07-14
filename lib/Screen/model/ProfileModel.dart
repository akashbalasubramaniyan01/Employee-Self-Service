class ProfileData {
  String employeeName;
  String dateOfBirth;
  String dateOfJoin;
  String departmentName;
  String pfUanNumber;
  String bankAccountNumber;
  String bankName;
  String ifscCode;
  String panNumber;
  String localAddress;
  String permanentAddress;
  String mobile;
  String email;
  String aadharNumber;

  ProfileData({
    required this.employeeName,
    required this.dateOfBirth,
    required this.dateOfJoin,
    required this.departmentName,
    required this.pfUanNumber,
    required this.bankAccountNumber,
    required this.bankName,
    required this.ifscCode,
    required this.panNumber,
    required this.localAddress,
    required this.permanentAddress,
    required this.mobile,
    required this.email,
    required this.aadharNumber,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      employeeName: json['employee_name']??"",
      dateOfBirth: json['date_of_birth']??"",
      dateOfJoin: json['date_of_joind']??"",
      departmentName: json['deptmentname']??"",
      pfUanNumber: json['pf_uan_number']??"",
      bankAccountNumber: json['bank_ac_number']??"",
      bankName: json['bank_name']??"",
      ifscCode: json['ifsc_code']??"",
      panNumber: json['pan_number'] ?? '', // Handle null case if needed
      localAddress: json['local_adress'] ?? '', // Handle null case if needed
      permanentAddress: json['prement_adress'] ?? '', // Handle null case if needed
      mobile: json['mobile'],
      email: json['email'] ?? '', // Handle null case if needed
      aadharNumber: json['aadhar_no']??"",
    );
  }
}
