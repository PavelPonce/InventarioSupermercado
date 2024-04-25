using AHM.Total.Travel.DataAccess.Repositories;
using Dapper;
using InventarioSupermercado.Common.Models;
using InventarioSupermercado.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.DataAccess.Repository
{

    public class VentasEncabezadoRepository : IRepository<tbVentasEncabezado>
    {
        public RequestStatus Delete(int Venen_Id)
        {
            string sql = ScriptDataBase.VentasEncabezado_Delete;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Venen_Id", Venen_Id);
                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }

            throw new NotImplementedException();
        }

        public RequestStatus Delete(int? id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbVentasEncabezado> find(int Venen_Id)
        {
            string sql = ScriptDataBase.VentasEncabezado_Buscar;

            List<tbVentasEncabezado> result = new List<tbVentasEncabezado>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Venen_Id };
                result = db.Query<tbVentasEncabezado>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }


        public RequestStatus Insert(tbVentasEncabezado item)
        {
            string sql = ScriptDataBase.VentasEncabezado_Insertar;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Sucur_Id", item.Sucur_Id);
                parameter.Add("@Venen_FechaPedido", DateTime.Now);
                parameter.Add("@Venen_UsuarioCreacion", 1);
                parameter.Add("@Venen_FechaCreacion", DateTime.Now);
                parameter.Add("@Clien_Id", item.Clien_Id);


                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);

                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
        }




        public IEnumerable<VentasEncabezadoViewModel> List()
        {
            string sql = "[Venta].[VentasDetalle_ListadoCarrito]";

            List<tbVentasEncabezado> result = new List<tbVentasEncabezado>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbVentasEncabezado>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new VentasEncabezadoViewModel
                {
                    Venen_Id = u.Venen_Id,
                    Sucur_Id = u.Sucur_Id,
                    Clien_Id = u.Clien_Id,
                    Venen_FechaPedido = u.Venen_FechaPedido,
                    Sucur_Descripcion = u.Sucur_Descripcion,
                    Vende_Id = u.Vende_Id,
                    Produ_Id = u.Produ_Id,
                    Vende_Cantidad = u.Vende_Cantidad,
                    Produ_Descripcion = u.Produ_Descripcion,
                    Produ_Existencia = u.Produ_Existencia,
                    Unida_Id = u.Unida_Id,
                    Produ_PrecioCompra = u.Produ_PrecioCompra,
                    Produ_PrecioVenta = u.Produ_PrecioVenta,
                    Impue_Id = u.Impue_Id,
                    Impue_Descripcion = u.Impue_Descripcion,
                    Categ_Id = u.Categ_Id,
                    Categ_Descripcion = u.Categ_Descripcion,
                    Prove_Id = u.Prove_Id,
                    cliente = u.cliente
                    ,
                    Venen_DireccionEnvio = u.Venen_DireccionEnvio
                    ,
                    Vende_Estado = u.Vende_Estado
                    ,
                    Unida_Descripcion = u.Unida_Descripcion
                  ,
                    Venen_Estado = u.Venen_Estado
                });
            }
        }


        public IEnumerable<VentasEncabezadoViewModel> ListSucursales()
        {
            string sql = ScriptDataBase.Sucursales_Drop;

            List<tbVentasEncabezado> result = new List<tbVentasEncabezado>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbVentasEncabezado>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new VentasEncabezadoViewModel
                {
                    Sucur_Id = u.Sucur_Id,
                    Sucur_Descripcion = u.Sucur_Descripcion
                });
            }
        }


        public RequestStatus Update(tbVentasEncabezado item)
        {
            try
            {
                string sql = ScriptDataBase.VentasEncabezado_Actualizar;

                using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
                {
                    var parameter = new DynamicParameters();
                    parameter.Add("@Venen_Id", item.Venen_Id);
                    parameter.Add("@Sucur_Id", item.Sucur_Id);
                    parameter.Add("@Venen_FechaPedido", item.Venen_FechaPedido);
                    parameter.Add("@Venen_UsuarioModificacion", 1);
                    parameter.Add("@Venen_FechaModificacion", DateTime.Now);
                    parameter.Add("@Clien_Id", item.Clien_Id);



                    var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                    return new RequestStatus { CodeStatus = result, MessageStatus = "" };
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores
                return new RequestStatus { CodeStatus = -1, MessageStatus = ex.Message };
            }
        }






        public IEnumerable<tbVentasEncabezado> ListarCarritoPrincipal(int Clien_Id)
        {
            string sql = "[Venta].[VentasDetalle_ListadoCarritoPrincipal]";
            List<tbVentasEncabezado> result = new List<tbVentasEncabezado>();


            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Clien_Id };
                return db.Query<tbVentasEncabezado>(sql, parameters, commandType: CommandType.StoredProcedure);
            }
        }






        public tbVentasEncabezado Find(int? id)
        {
            throw new NotImplementedException();
        }

        IEnumerable<tbVentasEncabezado> IRepository<tbVentasEncabezado>.List()
        {
            throw new NotImplementedException();
        }






        public tbVentasEncabezado ObtenerEncabezadoExistente(int clien_Id)
        {
            string storedProcedure = "[Venta].[ObtenerEncabezadoExistente]";
            tbVentasEncabezado encabezadoExistente;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Clien_Id = clien_Id };
                encabezadoExistente = db.QueryFirstOrDefault<tbVentasEncabezado>(storedProcedure, parameters, commandType: CommandType.StoredProcedure);
            }

            return encabezadoExistente;
        }


       
    }
}
