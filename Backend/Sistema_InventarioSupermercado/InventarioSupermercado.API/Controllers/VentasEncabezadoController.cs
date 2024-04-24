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
    public class VentasEncabezadoController : Controller
    {
        private readonly SupermercadoService _supermercadoService;

        private readonly IMapper _mapper;

        public VentasEncabezadoController(SupermercadoService supermercadoService, IMapper mapper)
        {
            _supermercadoService = supermercadoService;
            _mapper = mapper;
        }

        [HttpGet("List/Encabezado")]
        public IActionResult ListEncabezado()
        {
            try
            {
                var usuarios = _supermercadoService.ListEncabezado();
                return Ok(usuarios);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error al obtener la lista de usuarios.");
            }
        }

        [HttpGet("List/Sucursales")]
        public IActionResult ListSucursales()
        {
            try
            {
                var usuarios = _supermercadoService.ListSucursal();
                return Ok(usuarios);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error al obtener la lista de roles.");
            }
        }




      





        [HttpPost("Insert/Encabezado")]
        public tbVentasEncabezado InsertEncabezado(VentasEncabezadoViewModel item)
        {
            try
            {
                var encabezadoExistente = _supermercadoService.ObtenerEncabezadoExistente(item.Clien_Id);

                if (encabezadoExistente != null)
                {
                    var detalle = new tbVentasDetalle
                    {
                        Venen_Id = encabezadoExistente.Venen_Id,
                        Produ_Id = item.Produ_Id,
                        Vende_Cantidad = item.Vende_Cantidad,
                        
                    };
                    var detalleInsertado = _supermercadoService.InsertDetalle(detalle);

                    if (detalleInsertado != null)
                    {
                        return encabezadoExistente;
                    }
                    else
                    {
                        return null;
                    }
                }
                else
                {
                    // Si no existee encc
                    var encabezado = new tbVentasEncabezado
                    {
                        Sucur_Id = item.Sucur_Id,
                        Clien_Id = item.Clien_Id,
                        Venen_FechaPedido = DateTime.Now,
                        Venen_UsuarioCreacion = 1,
                        Venen_FechaCreacion = DateTime.Now
                    };

                    var encabezadoInsertado = _supermercadoService.InsertEncabezado(encabezado);

                    if (encabezadoInsertado != null)
                    {
                        // detalle inserttt
                        var detalle = new tbVentasDetalle
                        {
                            Venen_Id = encabezadoExistente.Venen_Id,
                            Produ_Id = item.Produ_Id,
                            Vende_Cantidad = item.Vende_Cantidad,
                        };
                        var detalleInsertado = _supermercadoService.InsertDetalle(detalle);

                        if (detalleInsertado != null)
                        {
                            return encabezadoInsertado;
                        }
                        else
                        {
                            return null;
                        }
                    }
                    else
                    {
                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }




        



        //[HttpPost("Insert/Encabezado")]
        //public IActionResult InsertEncabezado(VentasEncabezadoViewModel item)
        //{
        //    try
        //    {
        //        var model = _mapper.Map<tbVentasEncabezado>(item);

        //        var result = _supermercadoService.InsertEncabezado(model);

        //        return Ok(result);
        //    }
        //    catch (Exception ex)
        //    {
        //        return BadRequest(ex.Message);
        //    }
        //}





        [HttpPut("Update/Encabezado")]
        public IActionResult Y(VentasEncabezadoViewModel item)
        {
            var model = _mapper.Map<tbVentasEncabezado>(item);
            var modelo = new tbVentasEncabezado()
            {
                Venen_Id = item.Venen_Id,
                Sucur_Id = item.Sucur_Id,
                Venen_FechaPedido = item.Venen_FechaPedido,
                Clien_Id = item.Clien_Id
             
            };
            var result = _supermercadoService.UpdateEncabezado(modelo);

            return Ok("Usuario actualizado exitosamente");

        }



        [HttpGet("Cargar/ListadoCarritoPrincipal")]
        public IActionResult ListadoCarritoPrincipal(int Clien_Id)
        {
            var resultadoServicio = _supermercadoService.ListadoCarritoPrincipal(Clien_Id);

         
                var encabezado = resultadoServicio.Data as IEnumerable<tbVentasEncabezado>;
                return Ok(encabezado);
          
        }




        [HttpDelete("Delete/Encabezado")]
        public IActionResult InsertEncabezado(int Venen_Id)
        {
            var list = _supermercadoService.DeleteEncabezado(Venen_Id);
            return Ok(list);
        }

        [HttpGet("Cargar/Encabezado")]
        public IActionResult CargarEncabezado(int Venen_Id)
        {
            var list = _supermercadoService.CargarEncabezado(Venen_Id);

            return Ok(list);
        }

    }
}
