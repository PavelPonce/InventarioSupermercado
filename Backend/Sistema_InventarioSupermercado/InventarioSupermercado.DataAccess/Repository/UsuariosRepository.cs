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
    public class UsuariosRepository
    {


        public RequestStatus Delete(int Usuar_Id)
        {
            string sql = ScriptDataBase.Usuarios_Delete;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Usuar_Id", Usuar_Id);
                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }

            throw new NotImplementedException();
        }

        public RequestStatus Delete(tbUsuarios item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbUsuarios> Details(int? Usuar_Id)
        {
            string sql = ScriptDataBase.Usuarios_Buscar;

            List<tbUsuarios> result = new List<tbUsuarios>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Usuar_Id };
                result = db.Query<tbUsuarios>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbUsuarios> find(int Usuar_Id)
        {
            string sql = ScriptDataBase.Usuarios_Buscar;

            List<tbUsuarios> result = new List<tbUsuarios>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Usuar_Id };
                result = db.Query<tbUsuarios>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public tbUsuarios find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbUsuarios item)
        {
            string sql = "[Acce].[SP_Usuarios_Insertar]";

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Usuar_Usuario", item.Usuar_Usuario);
                parameter.Add("@Usuar_Contrasena", item.Usuar_Contrasena);
                parameter.Add("@Perso_Id", item.Perso_Id); 
                parameter.Add("@Roles_Id", item.Roles_Id);
                parameter.Add("@Usuar_Admin", item.Usuar_Admin);
                parameter.Add("@Usuar_Tipo", item.Usuar_Tipo); 
                parameter.Add("@Usuar_UsuarioCreacion", 1);
                parameter.Add("@Usuar_FechaCreacion", DateTime.Now);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);

                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
        }


        public IEnumerable<UsuariosViewModel> List()
        {
            string sql = ScriptDataBase.Usuarios_Listar;

            List<tbUsuarios> result = new List<tbUsuarios>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbUsuarios>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new UsuariosViewModel
                {
                    Usuar_Id = u.Usuar_Id,
                    Usuar_Usuario = u.Usuar_Usuario,
                    empleado = u.empleado,    
                    Roles_Descripcion = u.Roles_Descripcion,
                    Perso_NombreCompleto = u.Perso_NombreCompleto

                });
            }
        }




        public IEnumerable<UsuariosViewModel> ListRol()
        {
            string sql = ScriptDataBase.Usuarios_RolDDL;

            List<tbRoles> result = new List<tbRoles>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbRoles>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new UsuariosViewModel
                {
                    Roles_Id = u.Roles_Id,
                    Roles_Descripcion = u.Roles_Descripcion

                });
            }
        }



        public IEnumerable<UsuariosViewModel> LisEmpleado()
        {
            string sql = ScriptDataBase.Usuarios_EmpleadoDDL;

            List<tbUsuarios> result = new List<tbUsuarios>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbUsuarios>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new UsuariosViewModel
                {
                    Emple_Id = u.Emple_Id,
                    empleado = u.empleado

                });
            }
        }
        //public IEnumerable<tbUsuarios> Login(string Usuario, string Contra)
        //{
        //    string sql = ScriptDataBase.Usuario_Login;

        //    List<tbUsuarios> result = new List<tbUsuarios>();

        //    using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
        //    {
        //        var parameters = new { @Usuario = Usuario, @Contra = Contra };
        //        result = db.Query<tbUsuarios>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
        //        return result;
        //    }
        //}

        public RequestStatus Update(tbUsuarios item)
        {
            try
            {
                string sql = "Acce.SP_Usuarios_Modificar"; 

                using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
                {
                    var parameter = new DynamicParameters();
                    parameter.Add("@Usuar_Id", item.Usuar_Id);
                    parameter.Add("@Usuar_Usuario", item.Usuar_Usuario);
                    parameter.Add("@Perso_Id", item.Perso_Id);
                    parameter.Add("@Roles_Id", item.Roles_Id);
                    parameter.Add("@Usuar_Admin", item.Usuar_Admin);
                    parameter.Add("@Usuar_Tipo", item.Usuar_Tipo); 
                    parameter.Add("@Usuar_UsuarioModificacion", 1);
                    parameter.Add("@Usuar_FechaModificacion", DateTime.Now);

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





    }
}
