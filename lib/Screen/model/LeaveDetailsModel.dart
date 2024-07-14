class Ticket {
  final int recordId;
  final String documentDate;
  final int empnum;
  final String empname;
  final String dateOfRequest;
  final double noOfDays;
  final String leaveFrom;
  final String leaveTo;
  final String reasons;
  final String headRecom;
  final String leaveType;
  final String leaveTime;
  final String empcode;

  Ticket({
    required this.recordId,
    required this.documentDate,
    required this.empnum,
    required this.empname,
    required this.dateOfRequest,
    required this.noOfDays,
    required this.leaveFrom,
    required this.leaveTo,
    required this.reasons,
    required this.headRecom,
    required this.leaveType,
    required this.leaveTime,
    required this.empcode,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      recordId: json['record_id'] is String
          ? int.parse(json['record_id'])
          : json['record_id'],
      documentDate: json['document_date'] ?? "",
      empnum: json['empnum'] is String
          ? int.parse(json['empnum'])
          : json['empnum'],
      empname: json['empname'] ?? "",
      dateOfRequest: json['date_of_request'] ?? "",
      noOfDays: json['no_of_days'] is String
          ? double.parse(json['no_of_days'])
          : json['no_of_days'].toDouble(),
      leaveFrom: json['leave_from'] ?? "",
      leaveTo: json['leave_to'] ?? "",
      reasons: json['reasons'] ?? "",
      headRecom: json['head_recom'] ?? "",
      leaveType: json['leave_type'] ?? "",
      leaveTime: json['leave_time'] ?? "",
      empcode: json['empcode'] ?? "",
    );
  }
}
