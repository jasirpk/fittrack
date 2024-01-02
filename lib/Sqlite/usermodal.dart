class Users {
  final int? usrId;
  final String? usrName;
  final String usrMail;
  final String usrPassword;
  final String? Imagepath;

  Users({
    this.usrId,
    required this.usrName,
    required this.usrMail,
    required this.usrPassword,
    required this.Imagepath,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json["usrId"],
        usrName: json["usrName"],
        usrMail: json["usrMail"],
        usrPassword: json["usrPassword"],
        Imagepath: json["Imagepath"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "usrName": usrName,
        "usrMail": usrMail,
        "usrPassword": usrPassword,
        "Imagepath": Imagepath,
      };
}
