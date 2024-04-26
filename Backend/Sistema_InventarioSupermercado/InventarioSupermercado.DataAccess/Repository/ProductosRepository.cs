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
    public class ProductosRepository : IRepository<tbProductos>
    {
        public RequestStatus Delete(int Produ_Id)
        {
            string sql = ScriptDataBase.Productos_Delete;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Produ_Id", Produ_Id);
                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }

            throw new NotImplementedException();
        }

        public RequestStatus Delete(int? id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbProductos> Details(int? Produ_Id)
        {
            string sql = ScriptDataBase.Productos_Buscar;

            List<tbProductos> result = new List<tbProductos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Produ_Id };
                result = db.Query<tbProductos>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbProductos> find(int Produ_Id)
        {
            string sql = ScriptDataBase.Productos_Buscar;

            List<tbProductos> result = new List<tbProductos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new { Produ_Id };
                result = db.Query<tbProductos>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public tbProductos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbProductos item)
        {
            string sql = ScriptDataBase.Productos_Insertar;

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Produ_Descripcion", item.Produ_Descripcion);
                parameter.Add("@Produ_Existencia", item.Produ_Existencia);
                parameter.Add("@Unida_Id", item.Unida_Id);
                parameter.Add("@Produ_PrecioCompra", item.Produ_PrecioCompra);
                parameter.Add("@Produ_PrecioVenta", item.Produ_PrecioVenta);
                parameter.Add("@Impue_Id", item.Impue_Id);
                parameter.Add("@Categ_Id", item.Categ_Id);
                parameter.Add("@Prove_Id", item.Prove_Id);
                parameter.Add("@Sucur_Id", item.Sucur_Id);
                parameter.Add("@Produ_UsuarioCreacion", 1);
                parameter.Add("@Produ_FechaCreacion", DateTime.Now);
                parameter.Add("@Produ_ImagenUrl", item.Produ_ImagenUrl);


                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
        }




        public IEnumerable<ProductosViewModel> List(int categId)
        {
            string sql = "[Supr].[SP_Productos_Lista]";

            List<tbProductos> result = new List<tbProductos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Categ_Id", categId);

                result = db.Query<tbProductos>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();

                return result.Select(u => new ProductosViewModel
                {
                    Produ_Id = u.Produ_Id,
                    Produ_Descripcion = u.Produ_Descripcion,
                    Produ_Existencia = u.Produ_Existencia,
                    Unida_Id = u.Unida_Id,
                    Produ_PrecioCompra = u.Produ_PrecioCompra,
                    Produ_PrecioVenta = u.Produ_PrecioVenta,
                    Impue_Id = u.Impue_Id,
                    Categ_Id = u.Categ_Id,
                    Prove_Id = u.Prove_Id,
                    Sucur_Id = u.Sucur_Id,
                    Produ_UsuarioCreacion = u.Produ_UsuarioCreacion,
                    Produ_FechaCreacion = u.Produ_FechaCreacion,
                    Produ_UsuarioModificacion = u.Produ_UsuarioModificacion,
                    Produ_FechaModificacion = u.Produ_FechaModificacion,
                    Produ_Estado = u.Produ_Estado,
                    Produ_ImagenUrl = u.Produ_ImagenUrl,
                    Unida_Descripcion = u.Unida_Descripcion,
                    Prove_Marca = u.Prove_Marca,
                    Impue_Descripcion = u.Impue_Descripcion
                });
            }
        }







        public IEnumerable<ProductosViewModel> ListadoProductosCarrito(int prodid, int vendetId)
        {
            string sql = "[Venta].[Productos_CargarDetalles]";

            List<tbProductos> result = new List<tbProductos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Produ_Id", prodid);
                parameters.Add("@Vende_Id", vendetId);


                result = db.Query<tbProductos>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();

                return result.Select(u => new ProductosViewModel
                {
                    Vende_Id = u.Vende_Id,
                    Vende_Cantidad = u.Vende_Cantidad,
                    Produ_Id = u.Produ_Id,
                    Produ_Descripcion = u.Produ_Descripcion,
                    Produ_Existencia = u.Produ_Existencia,
                    Unida_Id = u.Unida_Id,
                    Produ_PrecioCompra = u.Produ_PrecioCompra,
                    Produ_PrecioVenta = u.Produ_PrecioVenta,
                    Impue_Id = u.Impue_Id,
                    Categ_Id = u.Categ_Id,
                    Prove_Id = u.Prove_Id,
                    Sucur_Id = u.Sucur_Id,
                    Produ_UsuarioCreacion = u.Produ_UsuarioCreacion,
                    Produ_FechaCreacion = u.Produ_FechaCreacion,
                    Produ_UsuarioModificacion = u.Produ_UsuarioModificacion,
                    Produ_FechaModificacion = u.Produ_FechaModificacion,
                    Produ_Estado = u.Produ_Estado,
                    Produ_ImagenUrl = u.Produ_ImagenUrl,
                    Unida_Descripcion = u.Unida_Descripcion,
                    Prove_Marca = u.Prove_Marca,
                    Impue_Descripcion = u.Impue_Descripcion
                });
            }
        }





        public IEnumerable<tbImpuestos> ListImpuestos()
        {
            string sql = ScriptDataBase.Impuestos_ddl;

            List<tbImpuestos> result = new List<tbImpuestos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbImpuestos>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new tbImpuestos
                {
                    Impue_Id = u.Impue_Id,
                    Impue_Descripcion = u.Impue_Descripcion

                });
            }
        }


        public IEnumerable<CategoriasViewModel> Listcategorias()
        {
            string sql = ScriptDataBase.Categorias_ddl;

            List<tbCategorias> result = new List<tbCategorias>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbCategorias>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new CategoriasViewModel
                {
                    Categ_Id = u.Categ_Id,
                    Categ_Descripcion = u.Categ_Descripcion

                });
            }
        }


        public IEnumerable<tbProveedores> ListProveedor()
        {
            string sql = ScriptDataBase.Proveedores_ddl;

            List<tbProveedores> result = new List<tbProveedores>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbProveedores>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new tbProveedores
                {
                    Prove_Id = u.Prove_Id,
                    Prove_Marca = u.Prove_Marca

                });
            }
        }



        public IEnumerable<tbUnidades> ListUnidades()
        {
            string sql = ScriptDataBase.Proveedores_ddl;

            List<tbUnidades> result = new List<tbUnidades>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbUnidades>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new tbUnidades
                {
                    Unida_Id = u.Unida_Id,
                    Unida_Descripcion = u.Unida_Descripcion

                });
            }
        }



        public IEnumerable<ProductosViewModel> ListSucursales()
        {
            string sql = ScriptDataBase.Sucursales_ddl;

            List<tbProductos> result = new List<tbProductos>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbProductos>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new ProductosViewModel
                {
                    Sucur_Id = u.Sucur_Id,
                    Sucur_Descripcion = u.Sucur_Descripcion

                });
            }
        }







        public IEnumerable<CategoriasViewModel> ListCategorias()
        {
            string sql = ScriptDataBase.Categorias_Listar;

            List<tbCategorias> result = new List<tbCategorias>();

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                result = db.Query<tbCategorias>(sql, commandType: CommandType.Text).ToList();

                return result.Select(u => new CategoriasViewModel
                {
                    Categ_Id = u.Categ_Id,
                    Categ_Descripcion = u.Categ_Descripcion,
                    Cate_ImagenUrl = u.Cate_ImagenUrl,
                });
            }
        }



        public static void Main()
        {
            string connectionString = "TuCadenaDeConexion";
            string imageUrl = "URL_de_la_imagen";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("Gral.SP_GuardarImagenCategoria", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@ImagenUrl", imageUrl);

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
        }
        public RequestStatus Update(tbProductos item)
        {
            string sql = "[Supr].[SP_Productos_Modificar]";

            using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Produ_Id", item.Produ_Id);
                parameter.Add("@Produ_Descripcion", item.Produ_Descripcion);
                parameter.Add("@Produ_Existencia", item.Produ_Existencia);
                parameter.Add("@Unida_Id", item.Unida_Id);
                parameter.Add("@Produ_PrecioCompra", item.Produ_PrecioCompra);
                parameter.Add("@Produ_PrecioVenta", item.Produ_PrecioVenta);
                parameter.Add("@Impue_Id", item.Impue_Id);
                parameter.Add("@Categ_Id", item.Categ_Id);
                parameter.Add("@Prove_Id", item.Prove_Id);
                parameter.Add("@Sucur_Id", item.Sucur_Id);
                parameter.Add("@Produ_ImagenUrl", item.Produ_ImagenUrl);

                parameter.Add("@Produ_UsuarioModificacion", 1);
                parameter.Add("@Produ_FechaModificacion", DateTime.Now);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                return new RequestStatus { CodeStatus = result, MessageStatus = "" };
            }
        }




        //principal categoriassssss
        //public IEnumerable<CategoriasViewModel> Listado()
        //{
        //    string sql = ScriptDataBase.Usuarios_Listar;

        //    List<tbCategorias> result = new List<tbCategorias>();

        //    using (var db = new SqlConnection(InventarioSupermercadoContext.ConnectionString))
        //    {
        //        result = db.Query<tbCategorias>(sql, commandType: CommandType.Text).ToList();

        //        return result.Select(u => new CategoriasViewModel
        //        {
        //            Categ_Id = u.Categ_Id,
        //            Categ_Descripcion = u.Categ_Descripcion,
        //            Cate_ImagenUrl = u.Cate_ImagenUrl


        //        });
        //    }
        //}



        tbProductos IRepository<tbProductos>.Find(int? id)
        {
            throw new NotImplementedException();
        }

        IEnumerable<tbProductos> IRepository<tbProductos>.List()
        {
            throw new NotImplementedException();
        }
    }

}
