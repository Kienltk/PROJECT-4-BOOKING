
class BaseRequestDTO<T> {
  BaseRequestDTO({this.signature, this.payload, this.requestor, this.isFilter});

  String? signature;
  T? payload;
  RequestorDTO? requestor;
  bool? isFilter;

  factory BaseRequestDTO.fromJson(Map<String, dynamic> json) => BaseRequestDTO(
    signature: json['signature'] as String?,
    payload: json['payload'] == null ? null : json['payload'] as T,
    requestor: json['requestor'] == null
        ? null
        : RequestorDTO.fromJson(json['requestor'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['signature'] = signature;
    map['payload'] = payload;

    // 'requestor': requestor?.toJson(),
    return map;
  }
}

class RequestorDTO {
  RequestorDTO({this.id, this.name, this.device});

  int? id;
  String? name;
  String? device;

  factory RequestorDTO.fromJson(Map<String, dynamic> json) => RequestorDTO(
    id: json['id'] as int?,
    name: json['name'] as String?,
    device: json['device'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'device': device};
}
