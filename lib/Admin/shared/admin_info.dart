class Admin{
  Admin({
    this.id,
    required this.admin_mail,
    required this.admin_pass
});
  final String? id;
  final String admin_mail;
  final String admin_pass;

  factory Admin.fromJson(Map<String,dynamic>json)=>Admin(
    id: json['admin_id'],
      admin_mail: json['admin_mail'],
      admin_pass: json['admin_pass']);

  Map<String,dynamic>toJson()=>{
    'admin_id':id,
    'admin_mail':admin_mail,
    'admin_pass':admin_pass
  };
}