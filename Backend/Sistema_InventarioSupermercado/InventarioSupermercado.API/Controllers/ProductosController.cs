using AutoMapper;
using InventarioSupermercado.BusinessLogic.Services;
using InventarioSupermercado.Common.Models;
using InventarioSupermercado.Entities.Entities;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InventarioSupermercado.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductosController : Controller
    {
        private readonly SupermercadoService _supermercadoService;

        private readonly IMapper _mapper;

        public ProductosController(SupermercadoService supermercadoService, IMapper mapper)
        {
            _supermercadoService = supermercadoService;
            _mapper = mapper;
        }

        [HttpGet("List/Productos")]
        public IActionResult ListProductos(int categId)
        {
            try
            {
                var productos = _supermercadoService.ListProductos(categId);
                return Ok(productos);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error al obtener la lista de productos.");
            }
        }

        

        [HttpGet("List/CategoriasDdl")]
        public IActionResult ListCategoriasDdl()
        {
            try
            {
                var usuarios = _supermercadoService.ListCategorias();
                return Ok(usuarios);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error al obtener la lista de categorias.");
            }
        }


        [HttpGet("List/Impuestosddl")]
        public IActionResult ListImpuestosDdl()
        {
            try
            {
                var usuarios = _supermercadoService.ListImpuestos();
                return Ok(usuarios);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error al obtener la lista de impuestos.");
            }
        }


        [HttpGet("List/ProveedoresDdl")]
        public IActionResult ListProveedoresDdl()
        {
            try
            {
                var usuarios = _supermercadoService.ListProveedores();
                return Ok(usuarios);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error al obtener la lista de roles.");
            }
        }


        [HttpGet("List/SucursalesDdl")]
        public IActionResult ListSucursalesDdl()
        {
            try
            {
                var usuarios = _supermercadoService.ListSucursales();
                return Ok(usuarios);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error al obtener la lista de sucursales.");
            }
        }





        [HttpPost("Insert/Productos")]
        public IActionResult InsertUsuarios(ProductosViewModel item)
        {
            try
            {
                var model = _mapper.Map<tbProductos>(item);

                var result = _supermercadoService.InsertProductos(model);

                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


      




        [HttpPut("Update/Productos")]
        public IActionResult UpdateCompraDetalle(ProductosViewModel item)
        {
            var model = _mapper.Map<tbProductos>(item);
            var modelo = new tbProductos()
            {
                Produ_Id = item.Produ_Id,
                Produ_Descripcion = item.Produ_Descripcion,
                Produ_Existencia = item.Produ_Existencia,
                Unida_Id = item.Unida_Id,
                Produ_PrecioCompra = item.Produ_PrecioCompra,
                Produ_PrecioVenta = item.Produ_PrecioVenta,
                Impue_Id = item.Impue_Id,
                Categ_Id = item.Categ_Id,
                Prove_Id = item.Prove_Id,
                Sucur_Id = item.Sucur_Id,
                Produ_ImagenUrl = item.Produ_ImagenUrl,
                Produ_UsuarioModificacion = item.Produ_UsuarioModificacion,
                Produ_FechaModificacion = item.Produ_FechaModificacion

            };
            var result = _supermercadoService.UpdateProductos(modelo);

            return Ok("Usuario actualizado exitosamente");

        }

        //listado principal

        [HttpGet("List/Categoriasss")]
        public IActionResult ListCategoriaPrincipal()
        {
            try
            {
                var usuarios = _supermercadoService.ListadoCategoriaPrincipal();
                return Ok(usuarios);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error al obtener la lista de categorias.");
            }
        }


        [HttpDelete("Delete/Productos")]
        public IActionResult DeleteCompraDetalle(int Produ_Id)
        {
            var list = _supermercadoService.Delete(Produ_Id);
            return Ok(list);
        }

        [HttpGet("Cargar/Productos")]
        public IActionResult CargarProducto(int Produ_Id)
        {
            var list = _supermercadoService.CargarProductos(Produ_Id);

            return Ok(list);
        }

        [HttpGet("Detalles/Productos")]
        public IActionResult DetallesUsuarios(int Produ_Id)
        {
            var list = _supermercadoService.DetallesProductos(Produ_Id);

            return Ok(list);
        }
    }

    internal class Productos
    {
    }
}
