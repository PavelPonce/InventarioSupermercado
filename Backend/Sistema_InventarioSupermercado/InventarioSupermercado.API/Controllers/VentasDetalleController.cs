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
    public class VentasDetalleController : Controller
    {
        private readonly SupermercadoService _supermercadoService;

        private readonly IMapper _mapper;

        public VentasDetalleController(SupermercadoService supermercadoService, IMapper mapper)
        {
            _supermercadoService = supermercadoService;
            _mapper = mapper;
        }

        [HttpPost("Insert/Detalle")]
        public IActionResult InsertDetalle(tbVentasEncabezado item)
        {
            try
            {
                var model = _mapper.Map<tbVentasDetalle>(item);

                var result = _supermercadoService.InsertDetalle(model);

                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }




        [HttpPut("Update/Detalle")]
        public IActionResult ActualizarDetalle(VentasEncabezadoViewModel item)
        {
            try
            {
                var model = _mapper.Map<tbVentasEncabezado>(item);

                var modeloActualizado = new tbVentasEncabezado
                {
                    Venen_Id = item.Venen_Id,
                    Vende_Id = item.Vende_Id,
                    Produ_Id = item.Produ_Id,
                    Vende_Cantidad = item.Vende_Cantidad,
                    Venen_DireccionEnvio = item.Venen_DireccionEnvio,
                    Venen_FechaPedido = item.Venen_FechaPedido,
                };

                var result = _supermercadoService.UpdateDetalle(modeloActualizado);

                return Json(new { message = "Detalle actualizado exitosamente" });
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message });
            }
        }




        [HttpDelete("Delete/Detalle/{Vende_Id}")]
        public IActionResult DeleteDetalle(int Vende_Id)
        {
            var result = _supermercadoService.DeleteDetalle(Vende_Id);
            return Ok(result);
        }


        [HttpGet("Cargar/Detalle")]
        public IActionResult CargarDetalle(int Venen_Id)
        {
            var list = _supermercadoService.CargarDetalle(Venen_Id);
            return Ok(list);
        }
    }
}
