using AHM.Total.Travel.DataAccess.Repositories;
using InventarioSupermercado.Entities.Entities;
using Microsoft.Data.SqlClient;
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
    public class ClientesRepository
    {
        public RequestStatus Insert(tbClientes item)
        {
            string sql = "[Gral].[Cliente_Insertar]";

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@PrimerNombre", item.Clien_PrimerNombre);
                parameter.Add("@SegundoNombre", item.Clien_SegundoNombre);
                parameter.Add("@PrimerApellido", item.Clien_PrimerApellido);
                parameter.Add("@SegundoApellido", item.Clien_SegundoApellido);
                parameter.Add("@Sexo", item.Clien_Sexo);
                parameter.Add("@EstadId", item.Estad_Id);
                parameter.Add("@Telefono", item.Clien_Telefono);
                parameter.Add("@Correo", item.Clien_Correo);
                parameter.Add("@MunicId", item.Munic_Id);
                parameter.Add("@Direccion", item.Clien_Direccion);
                parameter.Add("@UsuarioCreacion", 1);
                parameter.Add("@FechaCreacion", DateTime.Now);
                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);

                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
        }

        public tbClientes Numeration()
        {
            string sql = ScriptDataBase.Clientes_Numeration;

            List<tbClientes> listad = new List<tbClientes>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                listad = db.Query<tbClientes>(sql, commandType: CommandType.StoredProcedure).ToList();

                var result = new tbClientes();

                if(listad.Count > 0)
                {
                    result = listad.First();
                }

                return result;
            }
        }
        public IEnumerable<ClienteViewModel> ListEstadosCiviles()
        {
            string sql = ScriptDataBase.Clientes_EstadoCivilDDL;

            List<tbClientes> result = new List<tbClientes>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbClientes>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new ClienteViewModel
                {
                    Estad_Id = u.Estad_Id,
                    Estad_Descripcion = u.Estad_Descripcion
                });
            }
        }



        public IEnumerable<ClienteViewModel> ListMunicipios()
        {
            string sql = ScriptDataBase.Clientes_MunicipioDDL;

            List<tbClientes> result = new List<tbClientes>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbClientes>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new ClienteViewModel
                {
                    Munic_Id = u.Munic_Id,
                    Munic_Descripcion = u.Munic_Descripcion
                });
            }
        }



    }
}
