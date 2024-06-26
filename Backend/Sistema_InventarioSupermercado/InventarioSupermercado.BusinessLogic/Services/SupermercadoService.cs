﻿using AHM.Total.Travel.BusinessLogic;
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
        private readonly VentasEncabezadoRepository _ventasEncabezado;
        private readonly VentasDetalleRepository _ventasDetalleRepository;





        public SupermercadoService(ProductosRepository productosRepository,
            VentasEncabezadoRepository ventasEncabezado, VentasDetalleRepository ventasDetalleRepository)
        {
            _productosRepository = productosRepository;
            _ventasEncabezado = ventasEncabezado;
            _ventasDetalleRepository = ventasDetalleRepository;

        }

        #region productos

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










        #region Encabezado
        public IEnumerable<VentasEncabezadoViewModel> ListEncabezado()
        {
            try
            {
                var usuarios = _ventasEncabezado.List();
                return usuarios;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"errorrr: {ex.Message}");

                throw;
            }
        }


        public IEnumerable<VentasEncabezadoViewModel> ListSucursal()
        {
            try
            {
                var usuarios = _ventasEncabezado.ListSucursales();
                return usuarios;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"errorrr: {ex.Message}");

                throw;
            }
        }




        public tbVentasEncabezado InsertEncabezado(tbVentasEncabezado item)
        {
            try
            {
                var result = _ventasEncabezado.Insert(item);
                if (result.CodeStatus > 0)
                {
                    return item; 
                }
                else
                {
                    return null; 
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }






        public ServiceResult UpdateEncabezado(tbVentasEncabezado item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _ventasEncabezado.Update(item);
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


        public ServiceResult DeleteEncabezado(int Venen_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _ventasEncabezado.Delete(Venen_Id);
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



        public ServiceResult ListadoCarritoPrincipal(int Clien_Id)
        {
            var result = new ServiceResult();
            try
            {
                var encabezado = _ventasEncabezado.ListarCarritoPrincipal(Clien_Id);
                return result.Ok(encabezado);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }


        public ServiceResult CargarEncabezado(int Venen_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _ventasEncabezado.find(Venen_Id);

                return result.Ok(lost);

            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }


        #endregion





        #region detalle

        public ServiceResult CargarDetalle(int Venen_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _ventasDetalleRepository.find(Venen_Id);

                return result.Ok(lost);

            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertDetalle(tbVentasDetalle item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _ventasDetalleRepository.Insert(item);
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



        public ServiceResult UpdateDetalle(tbVentasDetalle item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _ventasDetalleRepository.Update(item);
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


        public ServiceResult DeleteDetalle(int Venen_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _ventasDetalleRepository.Delete(Venen_Id);
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



        public tbVentasEncabezado ObtenerEncabezadoExistente(int Clien_Id)
        {
            try
            {
                var encabezadoExistente = _ventasEncabezado.ListarCarritoPrincipal(Clien_Id).FirstOrDefault();

                return encabezadoExistente;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el encabezado existente", ex);
            }
        }


        #endregion
    }
}


