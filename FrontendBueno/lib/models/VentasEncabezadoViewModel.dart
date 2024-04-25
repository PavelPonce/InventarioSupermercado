class VentasEncabezado {
  late int venen_Id;
  late int sucur_Id;
  late String venen_DireccionEnvio;
  late DateTime venen_FechaPedido;
  late int venen_UsuarioCreacion;
  late DateTime venen_FechaCreacion;
  late int? venen_UsuarioModificacion;
  late DateTime? venen_FechaModificacion;
  late bool? venen_Estado;

  late int vende_Id;
  late int produ_Id;
  late int vende_Cantidad;
  late int vende_UsuarioCreacion;
  late DateTime vende_FechaCreacion;
  late int? vende_UsuarioModificacion;
  late DateTime? vende_FechaModificacion;
  late bool? vende_Estado;

  late String produ_Descripcion;
  late int produ_Existencia;
  late int unida_Id;
  late double produ_PrecioCompra;
  late double produ_PrecioVenta;
  late int impue_Id;
  late int categ_Id;
  late int prove_Id;
  late int produ_UsuarioCreacion;
  late DateTime produ_FechaCreacion;
  late int? produ_UsuarioModificacion;
  late DateTime? produ_FechaModificacion;
  late bool? produ_Estado;
  late String produ_ImagenUrl;

  late String unida_Descripcion;
  late String prove_Marca;
  late double impue_Descripcion;

  late String usuarioCreacion;
  late String usuarioModificacion;
  late String categ_Descripcion;

  late String sucur_Descripcion;
  late String cliente;

  // Cliente
  late int clien_Id;
  late String clien_PrimerNombre;
  late String clien_SegundoNombre;
  late String clien_PrimerApellido;
  late String clien_SegundoApellido;
  late String clien_Sexo;
  late int estad_Id;
  late String clien_Telefono;
  late String clien_Correo;
  late String munic_Id;
  late String clien_Direccion;
  late int clien_UsuarioCreacion;
  late int? clien_UsuarioModificacion;
  late DateTime? clien_FechaModificacion;
  late DateTime? clien_FechaCreacion;
  late String munic_Descripcion;
  late String estad_Descripcion;

  VentasEncabezado.fromJson(Map<String, dynamic> json) {
    this.venen_Id = json['venen_Id'];
    this.sucur_Id = json['sucur_Id'];
    this.venen_DireccionEnvio = json['venen_DireccionEnvio'];
    this.venen_FechaPedido = DateTime.parse(json['venen_FechaPedido']);
    this.venen_UsuarioCreacion = json['venen_UsuarioCreacion'];
    this.venen_FechaCreacion = DateTime.parse(json['venen_FechaCreacion']);
    this.venen_UsuarioModificacion = json['venen_UsuarioModificacion'];
    this.venen_FechaModificacion =
        json['venen_FechaModificacion'] != null ? DateTime.parse(json['venen_FechaModificacion']) : null;
    this.venen_Estado = json['venen_Estado'];

    this.vende_Id = json['vende_Id'];
    this.produ_Id = json['produ_Id'];
    this.vende_Cantidad = json['vende_Cantidad'];
    this.vende_UsuarioCreacion = json['vende_UsuarioCreacion'];
    this.vende_FechaCreacion = DateTime.parse(json['vende_FechaCreacion']);
    this.vende_UsuarioModificacion = json['vende_UsuarioModificacion'];
    this.vende_FechaModificacion =
        json['vende_FechaModificacion'] != null ? DateTime.parse(json['vende_FechaModificacion']) : null;
    this.vende_Estado = json['vende_Estado'];

    this.produ_Descripcion = json['produ_Descripcion'];
    this.produ_Existencia = json['produ_Existencia'];
    this.unida_Id = json['unida_Id'];
    this.produ_PrecioCompra = json['produ_PrecioCompra'];
    this.produ_PrecioVenta = json['produ_PrecioVenta'];
    this.impue_Id = json['impue_Id'];
    this.categ_Id = json['categ_Id'];
    this.prove_Id = json['prove_Id'];
    this.produ_UsuarioCreacion = json['produ_UsuarioCreacion'];
    this.produ_FechaCreacion = DateTime.parse(json['produ_FechaCreacion']);
    this.produ_UsuarioModificacion = json['produ_UsuarioModificacion'];
    this.produ_FechaModificacion =
        json['produ_FechaModificacion'] != null ? DateTime.parse(json['produ_FechaModificacion']) : null;
    this.produ_Estado = json['produ_Estado'];
    this.produ_ImagenUrl = json['produ_ImagenUrl'];

    this.unida_Descripcion = json['unida_Descripcion'];
    this.prove_Marca = json['prove_Marca'];
    this.impue_Descripcion = json['impue_Descripcion'];

    this.usuarioCreacion = json['usuarioCreacion'];
    this.usuarioModificacion = json['usuarioModificacion'];
    this.categ_Descripcion = json['categ_Descripcion'];

    this.sucur_Descripcion = json['sucur_Descripcion'];
    this.cliente = json['cliente'];

    this.clien_Id = json['clien_Id'];
    this.clien_PrimerNombre = json['clien_PrimerNombre'];
    this.clien_SegundoNombre = json['clien_SegundoNombre'];
    this.clien_PrimerApellido = json['clien_PrimerApellido'];
    this.clien_SegundoApellido = json['clien_SegundoApellido'];
    this.clien_Sexo = json['clien_Sexo'];
    this.estad_Id = json['estad_Id'];
    this.clien_Telefono = json['clien_Telefono'];
    this.clien_Correo = json['clien_Correo'];
    this.munic_Id = json['munic_Id'];
    this.clien_Direccion = json['clien_Direccion'];
    this.clien_UsuarioCreacion = json['clien_UsuarioCreacion'];
    this.clien_UsuarioModificacion = json['clien_UsuarioModificacion'];
    this.clien_FechaModificacion =
        json['clien_FechaModificacion'] != null ? DateTime.parse(json['clien_FechaModificacion']) : null;
    this.clien_FechaCreacion = json['clien_FechaCreacion'] != null ? DateTime.parse(json['clien_FechaCreacion']) : null;
    this.munic_Descripcion = json['munic_Descripcion'];
    this.estad_Descripcion = json['estad_Descripcion'];
  }
}
