class ClienteViewModel {
  int? clienId;
  String? clienPrimerNombre;
  String? clienSegundoNombre;
  String? clienPrimerApellido;
  String? clienSegundoApellido;
  String? clienSexo;
  int? estadId;
  String? clienTelefono;
  String? clienCorreo;
  String? municId;
  String? municDescripcion;
  String? estadDescripcion;
  String? clienDireccion;
  int? clienUsuarioCreacion;
  int? clienUsuarioModificacion;
  DateTime? clienFechaModificacion;
  DateTime? clienFechaCreacion;

  ClienteViewModel({
    this.clienId,
    this.clienPrimerNombre,
    this.clienSegundoNombre,
    this.clienPrimerApellido,
    this.clienSegundoApellido,
    this.clienSexo,
    this.estadId,
    this.clienTelefono,
    this.clienCorreo,
    this.municId,
    this.municDescripcion,
    this.estadDescripcion,
    this.clienDireccion,
    this.clienUsuarioCreacion,
    this.clienUsuarioModificacion,
    this.clienFechaModificacion,
    this.clienFechaCreacion,
  });

  factory ClienteViewModel.fromJson(Map<String, dynamic> json) {
    return ClienteViewModel(
      clienId: json['clien_Id'],
      clienPrimerNombre: json['clien_PrimerNombre'],
      clienSegundoNombre: json['clien_SegundoNombre'],
      clienPrimerApellido: json['clien_PrimerApellido'],
      clienSegundoApellido: json['clien_SegundoApellido'],
      clienSexo: json['clien_Sexo'],
      estadId: json['estad_Id'],
      clienTelefono: json['clien_Telefono'],
      clienCorreo: json['clien_Correo'],
      municId: json['munic_Id'],
      municDescripcion: json['munic_Descripcion'],
      estadDescripcion: json['estad_Descripcion'],
      clienDireccion: json['clien_Direccion'],
      clienUsuarioCreacion: json['clien_UsuarioCreacion'],
      clienUsuarioModificacion: json['clien_UsuarioModificacion'],
      clienFechaModificacion: json['clien_FechaModificacion'] != null
          ? DateTime.parse(json['clien_FechaModificacion'])
          : null,
      clienFechaCreacion: json['clien_FechaCreacion'] != null
          ? DateTime.parse(json['clien_FechaCreacion'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clien_Id': clienId,
      'clien_PrimerNombre': clienPrimerNombre,
      'clien_SegundoNombre': clienSegundoNombre,
      'clien_PrimerApellido': clienPrimerApellido,
      'clien_SegundoApellido': clienSegundoApellido,
      'clien_Sexo': clienSexo,
      'estad_Id': estadId,
      'clien_Telefono': clienTelefono,
      'clien_Correo': clienCorreo,
      'munic_Id': municId,
      'munic_Descripcion': municDescripcion,
      'estad_Descripcion': estadDescripcion,
      'clien_Direccion': clienDireccion,
      'clien_UsuarioCreacion': clienUsuarioCreacion,
      'clien_UsuarioModificacion': clienUsuarioModificacion,
      'clien_FechaModificacion':
          clienFechaModificacion?.toIso8601String(),
      'clien_FechaCreacion': clienFechaCreacion?.toIso8601String(),
    };
  }
}
