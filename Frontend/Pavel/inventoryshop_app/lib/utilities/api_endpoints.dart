class ApiEndPoint{
  static const String baseUrl = 'http://paapi.somee.com/api/';
  static _UsuarioEndPoints usuarioEndPoints = _UsuarioEndPoints();
}

class _UsuarioEndPoints{
  final String login = 'usuario/login/';
  final String registrar = 'usuario/registrar/';
  //final String listar = 'usuario/list/usuarios';
  //final String delete = 'usuario/Delete/Usuarios/';
  //final String insert = 'usuario/Delete/Usuarios/';
}