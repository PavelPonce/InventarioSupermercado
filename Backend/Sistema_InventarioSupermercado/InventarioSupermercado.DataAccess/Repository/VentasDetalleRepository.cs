using AHM.Total.Travel.DataAccess.Repositories;
using Dapper;
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
    public class VentasDetalleRepository : IRepository<tbVentasDetalle>
    {
        public RequestStatus Delete(int Vende_Id)
        {
            string sql = ScriptDataBase.VentasDetalle_Delete;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Vende_Id", Vende_Id);
                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }

            throw new NotImplementedException();
        }

        public RequestStatus Delete(int? id)
        {
            throw new NotImplementedException();
        }

        public tbVentasDetalle Find(int? id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbVentasDetalle> find(int Vende_Id)
        {
            string sql = ScriptDataBase.VentasDetalle_Buscar;

            List<tbVentasDetalle> result = new List<tbVentasDetalle>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Vende_Id };
                result = db.Query<tbVentasDetalle>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public RequestStatus Insert(tbVentasDetalle item)
        {
            string sql = "[Venta].[SP_VentasDetalle_Insertar]";

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Venen_Id", item.Venen_Id);
                parameter.Add("@Produ_Id", item.Produ_Id);
                parameter.Add("@Vende_Cantidad", item.Vende_Cantidad);
                parameter.Add("@Vende_UsuarioCreacion", 1);
                parameter.Add("@Vende_FechaCreacion", DateTime.Now);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);

                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
        }

    

        public IEnumerable<tbVentasDetalle> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbUsuarios item)
        {
            try
            {
                string sql = "Acce.SP_Usuarios_Modificar";

                using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
                {
                    var parameter = new DynamicParameters();
                    parameter.Add("@Vende_Id", item.Usuar_Id);
                    parameter.Add("@Venen_Id", item.Usuar_Usuario);
                    parameter.Add("@Produ_Id", item.Perso_Id);
                    parameter.Add("@Vende_Cantidad", item.Roles_Id);
                    parameter.Add("@Vende_UsuarioModificacion", 1);
                    parameter.Add("@Vende_FechaModificacion", DateTime.Now);

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

        public RequestStatus Update(tbVentasDetalle item)
        {
            throw new NotImplementedException();
        }

        tbVentasDetalle IRepository<tbVentasDetalle>.Find(int? id)
        {
            throw new NotImplementedException();
        }

        IEnumerable<tbVentasDetalle> IRepository<tbVentasDetalle>.List()
        {
            throw new NotImplementedException();
        }
    }
}
