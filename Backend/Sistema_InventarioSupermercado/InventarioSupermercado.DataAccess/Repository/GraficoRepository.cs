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
    public class GraficoRepository
    {
        public IEnumerable<tbGraficos> CantidadVentaPorGenero()
        {
            string sql = ScriptDataBase.Graph_CantidadVentaPorGenero;

            List<tbGraficos> result = new List<tbGraficos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbGraficos>(sql, commandType: CommandType.StoredProcedure).ToList();

                return result;
            }
        }
        public IEnumerable<tbGraficos> TotalVentasPorCategoria()
        {
            string sql = ScriptDataBase.Graph_TotalVentasPorCategoria;

            List<tbGraficos> result = new List<tbGraficos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbGraficos>(sql, commandType: CommandType.StoredProcedure).ToList();

                return result;
            }
        }
        public IEnumerable<tbGraficos> CantidadRegistrosPorClientesPorGenero()
        {
            string sql = ScriptDataBase.Graph_CantidadRegistrosPorClientesPorGenero;

            List<tbGraficos> result = new List<tbGraficos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbGraficos>(sql, commandType: CommandType.StoredProcedure).ToList();

                return result;
            }
        }

        public IEnumerable<tbGraficos> TotalGanancia()
        {
            string sql = ScriptDataBase.Graph_TotalGanancia;

            List<tbGraficos> result = new List<tbGraficos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbGraficos>(sql, commandType: CommandType.StoredProcedure).ToList();

                return result;
            }
        }
    }
}
