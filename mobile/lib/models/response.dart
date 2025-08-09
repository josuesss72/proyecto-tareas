class Response {
  final int code;
  final String message;
  final bool ok;

  Response({required this.code, required this.message, required this.ok});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      code: json['code'],
      message: json['message'],
      ok: json['ok'],
    );
  }
}

class StatusResponse {
  final Response status;

  StatusResponse({required this.status});

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    return StatusResponse(status: Response.fromJson(json['status']));
  }
}
