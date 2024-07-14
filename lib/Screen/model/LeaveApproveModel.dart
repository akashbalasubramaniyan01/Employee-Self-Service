class LeaveData {
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

  LeaveData({
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

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      recordId: json['record_id'] ?? 0,
      documentDate: json['document_date'] ?? '',
      empnum: json['empnum'] ?? 0,
      empname: json['empname'] ?? '',
      dateOfRequest: json['date_of_request'] ?? '',
      noOfDays: (json['no_of_days'] is String) ? double.tryParse(json['no_of_days']) ?? 0.0 : json['no_of_days'] ?? 0.0,
      leaveFrom: json['leave_from'] ?? '',
      leaveTo: json['leave_to'] ?? '',
      reasons: json['reasons'] ?? '',
      headRecom: json['head_recom'] ?? '',
      leaveType: json['leave_type'] ?? '',
      leaveTime: json['leave_time'] ?? '',
      empcode: json['empcode'] ?? '',
    );
  }
}

class LeaveResponse {
  final int count;
  final List<LeaveData> data;

  LeaveResponse({
    required this.count,
    required this.data,
  });

  factory LeaveResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<LeaveData> dataList = list.map((i) => LeaveData.fromJson(i)).toList();

    return LeaveResponse(
      count: json['count'] ?? 0,
      data: dataList,
    );
  }
}
