class CommunicationModel {
  String command;
  String value;
  String peerId;
  String message;
  String username;

  CommunicationModel({
    required this.command,
    required this.value,
    required this.peerId,
    required this.message,
    required this.username,
  });

  factory CommunicationModel.fromJson(Map<String, dynamic> json) =>
      CommunicationModel(
        command: json["command"],
        value: json["value"],
        peerId: json["peerId"],
        message: json["message"],
        username: json["username"], 
      );

  @override
  String toString() {
    return '{"command": "$command", "value": "$value", "peerId": "$peerId", "message": "$message"', "username": "$username";
  }
}
