using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.DataAccess.Repository
{
   public class ScriptDataBase
    {
        #region depto
        //public static string deptoinsertar = "[Gnrl].[SP_Departamentos_Insertar]";
        #endregion

        #region ComprasDetalle
        public static string CompraDetalle_Insertar = "[Comp].[SP_ComprasDetalle_Insertar]";
        public static string CompraDetalle_Listar = "[Comp].[SP_ComprasDetalle_Lista]";
        public static string CompraDetalle_Buscar = "[Comp].[SP_ComprasDetalle_Buscar]";
        public static string CompraDetalle_Actualizar = "[Comp].[SP_ComprasDetalle_Modificar]";
        public static string CompraDetalle_Delete = "[Comp].[SP_ComprasDetalle_Eliminar]";
        #endregion


        #region CompraEncabezado
        public static string CompraEncabezado_Insertar = "[Comp].[SP_ComprasEncabezado_Insertar]";
        public static string CompraEncabezado_Listar = "[Comp].[SP_ComprasEncabezado_Lista]";
        public static string CompraEncabezado_Buscar = "[Comp].[SP_ComprasEncabezado_Buscar]";
        public static string CompraEncabezado_Actualizar = "[Comp].[SP_ComprasEncabezado_Modificar]";
        public static string CompraEncabezado_Delete = "[Comp].[SP_ComprasEncabezado_Eliminar]";
        #endregion


        #region Productos
        public static string Productos_Insertar = "[Supr].[SP_Productos_Insertar]";
        public static string Productos_Listar = "[Supr].[SP_Productos_Lista]";
        public static string Productos_Buscar = "[Supr].[SP_Productos_Buscar]";
        public static string Productos_Actualizar = "[Supr].[SP_Productos_Modificar]";
        public static string Productos_Delete = "[Supr].[SP_Productos_Eliminar]";

        //DDL
        public static string Impuestos_ddl = "Gral.SP_Impuestos_DDL";
        public static string Categorias_ddl = "Gral.SP_Categorias_DDL";
        public static string Proveedores_ddl = "Gral.SP_Provedores_DDL";
        public static string Sucursales_ddl = "Gral.SP_Sucursales_DDL";
        public static string Unidades_DDL = "Gral.SP_Unidades_DDL";




        #endregion


        #region VentasDetalle
        public static string VentasDetalle_Insertar = "[Venta].[SP_VentasDetalle_Insertar]";
        public static string VentasDetalle_Listar = "[Venta].[SP_VentasDetalle_List]";
        public static string VentasDetalle_Buscar = "[Venta].[SP_VentasDetalle_Buscar]";
        public static string VentasDetalle_Actualizar = "[Venta].[SP_VentasDetalle_Modificar]";
        public static string VentasDetalle_Delete = "[Venta].[SP_VentasDetalle_Eliminar]";
        #endregion

        #region VentasEncabezado
        public static string VentasEncabezado_Insertar = "[Venta].[SP_VentasEncabezado_Insertar]";
        public static string VentasEncabezado_Listar = "[Venta].[SP_VentasEncabezado_Lista]";
        public static string VentasEncabezado_Buscar = "[Venta].[SP_VentasEncabezado_Buscar]";
        public static string VentasEncabezado_Actualizar = "[Venta].[SP_VentasEncabezado_Modificar]";
        public static string VentasEncabezado_Delete = "[Venta].[SP_VentasEncabezado_Eliminar]";
        #endregion

        #region Graficos
        public static string Graph_CantidadVentaPorGenero = "Grph.SP_CantidadDeVentasPorGeneroAlMes";
        public static string Graph_TotalVentasPorCategoria = "Grph.SP_TotalDeVentasPorCategoriaPorMes";
        public static string Graph_CantidadRegistrosPorClientesPorGenero = "Grph.SP_CantidadDeRegistrosDeClientesPorGeneroPorMes";
        public static string Graph_TotalGanancia = "Grph.SP_TotalGananciaPorMes";
        #endregion

        #region usuarios
        public static string Usuarios_Login = "Acce.SP_Usuarios_Login";
        public static string Usuarios_Insertar = "Acce.SP_Usuarios_Insertar";
        public static string Usuarios_Listar = "Acce.SP_Usuarios_Lista";
        public static string Usuarios_Buscar = "[Acce].[SP_Usuarios_Buscar]";
        public static string Usuarios_Actualizar = "[Acce].[SP_Usuarios_Modificar]";
        public static string Usuarios_ActualizarContra = "[Acce].[SP_Usuarios_ReestablecerContrasenia]";
        public static string Usuarios_Delete = "[Acce].[SP_Usuarios_Eliminar]";
        public static string Usuarios_RolDDL = "Acce.SP_Roles_DropDownList";
        public static string Usuarios_EmpleadoDDL = "Gral.SP_Empleados_DropDownList";
        #endregion


        #region Clientes
        public static string Clientes_MunicipioDDL = "[Gral].[SP_Municipios_DropDownList]";
        public static string Clientes_EstadoCivilDDL = "[Gral].[SP_EstadosCiviles_DropDownList]";
        #endregion



        #region Categorias
        public static string Categorias_Listar = "Gral.SP_Categorias_Lista";
        #endregion


        #region sucursales
        public static string Sucursales_Drop = "Supr.SP_Sucursales_DDL";
        #endregion

    }

}
