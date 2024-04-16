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
    public class ComprasEncabezadoRepository : IRepository<tbComprasEncabezado>
    {
        public RequestStatus Delete(int Comen_Id)
        {
            string sql = ScriptDataBase.CompraEncabezado_Delete;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Comen_Id", Comen_Id);
                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }

            throw new NotImplementedException();
        }

        public RequestStatus Delete(int? id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbComprasEncabezado> Details(int? Comen_Id)
        {
            string sql = ScriptDataBase.CompraEncabezado_Buscar;

            List<tbComprasEncabezado> result = new List<tbComprasEncabezado>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Comen_Id };
                result = db.Query<tbComprasEncabezado>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbComprasEncabezado> find(int Comen_Id)
        {
            string sql = ScriptDataBase.CompraEncabezado_Buscar;

            List<tbComprasEncabezado> result = new List<tbComprasEncabezado>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Comen_Id };
                result = db.Query<tbComprasEncabezado>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public tbComprasEncabezado Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbComprasEncabezado item)
        {
            string sql = ScriptDataBase.CompraEncabezado_Insertar;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Prove_Id", item.Prove_Id);
                parameter.Add("@Sucur_Id", item.Sucur_Id);
                parameter.Add("@Emple_Id", item.Emple_Id);
                parameter.Add("@Comen_FechaIngreso", 1);
                parameter.Add("@Comen_UsuarioCreacion", 1);
                parameter.Add("@Comen_FechaCreacion", DateTime.Now);


                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
        }

    

        public IEnumerable<tbComprasEncabezado> List()
        {
            string sql = ScriptDataBase.CompraEncabezado_Listar;

            List<tbComprasEncabezado> result = new List<tbComprasEncabezado>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbComprasEncabezado>(sql, commandType: CommandType.Text).ToList();

                return result;
            }
        }

        public RequestStatus Update(tbComprasEncabezado item)
        {
            string sql = ScriptDataBase.CompraEncabezado_Actualizar;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Comen_Id", item.Comen_Id);
                parameter.Add("@Prove_Id", item.Prove_Id);
                parameter.Add("@Sucur_Id", item.Sucur_Id);
                parameter.Add("@Emple_Id", item.Emple_Id);

                parameter.Add("@Emple_Id", item.Emple_Id);
                parameter.Add("@Comen_UsuarioModificacion", 1);
                parameter.Add("@Comen_FechaModificacion", DateTime.Now);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }

        }

    

        tbComprasEncabezado IRepository<tbComprasEncabezado>.Find(int? id)
        {
            throw new NotImplementedException();
        }

        IEnumerable<tbComprasEncabezado> IRepository<tbComprasEncabezado>.List()
        {
            throw new NotImplementedException();
        }
    }
}
