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
        public IActionResult Y(VentasEncabezadoViewModel item)
        {
            var model = _mapper.Map<tbVentasEncabezado>(item);
            var modelo = new tbVentasEncabezado()
            {
                Venen_Id = item.Venen_Id,
                Sucur_Id = item.Sucur_Id,
                Venen_DireccionEnvio = item.Venen_DireccionEnvio,
                Venen_FechaPedido = item.Venen_FechaPedido,

            };
            var result = _supermercadoService.UpdateEncabezado(modelo);

            return Ok("Usuario actualizado exitosamente");

        }


        [HttpDelete("Delete/Detalle")]
        public IActionResult DeleetDetalle(int Vende_Id)
        {
            var list = _supermercadoService.DeleteDetalle(Vende_Id);
            return Ok(list);
        }

        [HttpGet("Cargar/Detalle")]
        public IActionResult CargarDetalle(int Venen_Id)
        {
            var list = _supermercadoService.CargarDetalle(Venen_Id);
            return Ok(list);
        }
    }
}
