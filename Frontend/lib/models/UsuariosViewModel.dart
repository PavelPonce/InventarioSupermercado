class UsuariosViewModel {
  int? usuarId;
  String? usuarUsuario;
  String? usuarContrasena;
  int? empleId;
  int? rolesId;
  bool? usuarAdmin;
  DateTime? usuarUltimaSesion;
  int? usuarUsuarioCreacion;
  DateTime? usuarFechaCreacion;
  int? usuarUsuarioModificacion;
  DateTime? usuarFechaModificacion;
  bool? usuarEstado;
  String? usuarioCreacion;
  String? usuarioModificacion;
  String? empleado;
  String? rolesDescripcion;
  String? persoNombreCompleto;
  int? persoId;
  bool? usuarTipo;

  UsuariosViewModel({
    this.usuarId,
    this.usuarUsuario,
    this.usuarContrasena,
    this.empleId,
    this.rolesId,
    this.usuarAdmin,
    this.usuarUltimaSesion,
    this.usuarUsuarioCreacion,
    this.usuarFechaCreacion,
    this.usuarUsuarioModificacion,
    this.usuarFechaModificacion,
    this.usuarEstado,
    this.usuarioCreacion,
    this.usuarioModificacion,
    this.empleado,
    this.rolesDescripcion,
    this.persoNombreCompleto,
    this.persoId,
    this.usuarTipo,
  });

  factory UsuariosViewModel.fromJson(Map<String, dynamic> json) {
    return UsuariosViewModel(
      usuarId: json['usuar_Id'],
      usuarUsuario: json['usuar_Usuario'],
      usuarContrasena: json['usuar_Contrasena'],
      empleId: json['emple_Id'],
      rolesId: json['roles_Id'],
      usuarAdmin: json['usuar_Admin'],
      usuarUltimaSesion: json['usuar_UltimaSesion'] != null
          ? DateTime.parse(json['usuar_UltimaSesion'])
          : null,
      usuarUsuarioCreacion: json['usuar_UsuarioCreacion'],
      usuarFechaCreacion: json['usuar_FechaCreacion'] != null
          ? DateTime.parse(json['usuar_FechaCreacion'])
          : null,
      usuarUsuarioModificacion: json['usuar_UsuarioModificacion'],
      usuarFechaModificacion: json['usuar_FechaModificacion'] != null
          ? DateTime.parse(json['usuar_FechaModificacion'])
          : null,
      usuarEstado: json['usuar_Estado'],
      usuarioCreacion: json['usuarioCreacion'],
      usuarioModificacion: json['usuarioModificacion'],
      empleado: json['empleado'],
      rolesDescripcion: json['roles_Descripcion'],
      persoNombreCompleto: json['perso_NombreCompleto'],
      persoId: json['perso_Id'],
      usuarTipo: json['usuar_Tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuar_Id': usuarId,
      'usuar_Usuario': usuarUsuario,
      'usuar_Contrasena': usuarContrasena,
      'emple_Id': empleId,
      'roles_Id': rolesId,
      'usuar_Admin': usuarAdmin,
      'usuar_UltimaSesion': usuarUltimaSesion?.toIso8601String(),
      'usuar_UsuarioCreacion': usuarUsuarioCreacion,
      'usuar_FechaCreacion': usuarFechaCreacion?.toIso8601String(),
      'usuar_UsuarioModificacion': usuarUsuarioModificacion,
      'usuar_FechaModificacion': usuarFechaModificacion?.toIso8601String(),
      'usuar_Estado': usuarEstado,
      'usuarioCreacion': usuarioCreacion,
      'usuarioModificacion': usuarioModificacion,
      'empleado': empleado,
      'roles_Descripcion': rolesDescripcion,
      'perso_NombreCompleto': persoNombreCompleto,
      'perso_Id': persoId,
      'usuar_Tipo': usuarTipo,
    };
  }
}
