using AHM.Total.Travel.BusinessLogic;
using InventarioSupermercado.Common.Models;
using InventarioSupermercado.DataAccess.Repository;
using InventarioSupermercado.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.BusinessLogic.Services
{
   public class SupermercadoService
    {
        private readonly ProductosRepository _productosRepository;



        public SupermercadoService(ProductosRepository productosRepository)
        {
            _productosRepository = productosRepository;

        }

        #region Usuarios
        public IEnumerable<ProductosViewModel> ListProductos(int categId)
        {
            try
            {
                var productos = _productosRepository.List(categId);
                return productos;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                throw;
            }
        }



        //public IEnumerable<UsuariosViewModel> ListRol()
        //{
        //    try
        //    {
        //        var usuarios = _usuariosRepository.ListRol();
        //        return usuarios;
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine($"errorrr: {ex.Message}");

        //        throw;
        //    }
        //}






        public ServiceResult InsertProductos(tbProductos item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _productosRepository.Insert(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }




        public ServiceResult UpdateProductos(tbProductos item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _productosRepository.Update(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }


        public ServiceResult Delete(int Produ_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _productosRepository.Delete(Produ_Id);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult CargarProductos(int Produ_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _productosRepository.find(Produ_Id);

                return result.Ok(lost);

            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult DetallesProductos(int Produ_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _productosRepository.Details(Produ_Id);

                return result.Ok(lost);

            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public IEnumerable<ProductosViewModel> ListImpuestos()
        {
            try
            {
                var usuarios = _productosRepository.ListImpuestos();
                return usuarios;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"errorrr: {ex.Message}");

                throw;
            }
        }


        public IEnumerable<ProductosViewModel> ListCategorias()
        {
            try
            {
                var usuarios = _productosRepository.Listcategorias();
                return usuarios;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"errorrr: {ex.Message}");

                throw;
            }
        }


        public IEnumerable<CategoriasViewModel> ListadoCategoriaPrincipal()
        {
            try
            {
                var categorias = _productosRepository.ListCategorias();
                return categorias;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                throw;
            }
        }




        public IEnumerable<ProductosViewModel> ListSucursales()
        {
            try
            {
                var usuarios = _productosRepository.ListSucursales();
                return usuarios;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"errorrr: {ex.Message}");

                throw;
            }
        }


        public IEnumerable<ProductosViewModel> ListProveedores()
        {
            try
            {
                var usuarios = _productosRepository.ListProveedor();
                return usuarios;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"errorrr: {ex.Message}");

                throw;
            }
        }




        #endregion
    }
}
