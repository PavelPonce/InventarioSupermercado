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
    public class ComprasDetalleRepository : IRepository<tbComprasDetalle>
    {
        public RequestStatus Delete(int Comde_Id)
        {
            string sql = ScriptDataBase.CompraDetalle_Delete;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Comde_Id", Comde_Id);
                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }

            throw new NotImplementedException();
        }

        public RequestStatus Delete(int? id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbComprasDetalle> Details(int? Comde_Id)
        {
            string sql = ScriptDataBase.CompraDetalle_Buscar;

            List<tbComprasDetalle> result = new List<tbComprasDetalle>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Comde_Id };
                result = db.Query<tbComprasDetalle>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbComprasDetalle> find(int Comde_Id)
        {
            string sql = ScriptDataBase.CompraDetalle_Buscar;

            List<tbComprasDetalle> result = new List<tbComprasDetalle>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Comde_Id };
                result = db.Query<tbComprasDetalle>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public tbComprasDetalle Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbComprasDetalle item)
        {
            string sql = ScriptDataBase.CompraDetalle_Insertar;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Comen_Id", item.Comen_Id);
                parameter.Add("@Produ_Id", item.Produ_Id);
                parameter.Add("@Comde_Cantidad", item.Comde_Cantidad);
                parameter.Add("@Comde_UsuarioCreacion", 1);
                parameter.Add("@Comde_FechaCreacion", DateTime.Now);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
        }

        public IEnumerable<tbComprasDetalle> List()
        {
            string sql = ScriptDataBase.CompraDetalle_Listar;

            List<tbComprasDetalle> result = new List<tbComprasDetalle>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbComprasDetalle>(sql, commandType: CommandType.Text).ToList();

                return result;
            }
        }

        public RequestStatus Update(tbComprasDetalle item)
        {
            string sql = ScriptDataBase.CompraDetalle_Actualizar;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Comde_Id", item.Comde_Id);
                parameter.Add("@Comen_Id", item.Comen_Id);
                parameter.Add("@Produ_Id", item.Produ_Id);
                parameter.Add("@Comde_Cantidad", item.Comde_Cantidad);

                parameter.Add("@Comde_UsuarioModificacion",  1);
                parameter.Add("@Comde_FechaModificacion", DateTime.Now);
                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
            //throw new notImplementedException();

        }
        }
    }

