using AHM.Total.Travel.DataAccess.Repositories;
using Dapper;
using InventarioSupermercado.Entities;
using InventarioSupermercado.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.DataAccess.Repository
{
    public class DepartamentosRepository : IRepository<tbDepartamentos>
    {
        public RequestStatus Delete(int? id)
        {
            throw new NotImplementedException();
        }

        public tbDepartamentos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbDepartamentos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbDepartamentos> List()
        {
            const string sql = "select Depar_Id,Depar_Descripcion from [Gral].[tbDepartamentos]";
            List<tbDepartamentos> result = new List<tbDepartamentos>();
            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbDepartamentos>(sql, commandType: System.Data.CommandType.Text).ToList();
                return result;
            }
        }

        public RequestStatus Update(tbDepartamentos item)
        {
            throw new NotImplementedException();
        }
    }
}
