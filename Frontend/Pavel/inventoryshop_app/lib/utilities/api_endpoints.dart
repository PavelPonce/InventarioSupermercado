class ApiEndPoint{
  static const String baseUrl = 'http://paapi.somee.com/api/';
  static _UsuarioEndPoints usuarioEndPoints = _UsuarioEndPoints();
}

class _UsuarioEndPoints{
  final String login = 'usuario/login/';
  final String registrar = 'usuario/registrar/';
  final String listar = 'usuario/listar/';
  final String insertar = 'usuario/insertar/';
}