class ApiEndPoint {
  static const String baseUrl = 'http://paapi.somee.com/api/';
  static _UsuarioEndPoints usuarioEndPoints = _UsuarioEndPoints();
  static _GraficoEndPoints graficoEndPoints = _GraficoEndPoints();
}

class _UsuarioEndPoints {
  final String login = 'usuario/login/';
  final String registrar = 'usuario/registrar/';
  //final String listar = 'usuario/list/usuarios';
  //final String delete = 'usuario/Delete/Usuarios/';
  //final String insert = 'usuario/Delete/Usuarios/';
}

class _GraficoEndPoints {
  final String grafico1 = 'grafico/grafico1/';
  final String grafico2 = 'grafico/grafico2/';
  final String grafico3 = 'grafico/grafico3/';
  final String grafico4 = 'grafico/grafico4/';
}
