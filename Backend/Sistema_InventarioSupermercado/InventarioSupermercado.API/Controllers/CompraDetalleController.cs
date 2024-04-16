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
    public class CompraDetalleController : Controller
    {
        private readonly CompraService _compraService;
        private readonly IMapper _mapper;

        public CompraDetalleController(CompraService compraService, IMapper mapper)
        {
            _compraService = compraService;
            _mapper = mapper;
        }

        [HttpGet("List/CompraDetalle")]
        public IActionResult ListCompraDetalle()
        {
            var list = _compraService.ListCompraDetalle();
            return Ok(list);
        }


        [HttpPost("Insert/CompraDetalle")]
        public IActionResult InsertCompraDetalle(ComprasDetalleViewModel item)
        {
            var model = _mapper.Map<tbComprasDetalle>(item);
            var modelo = new tbComprasDetalle()
            {
                Comen_Id = item.Comen_Id,
                Produ_Id = item.Produ_Id,
                Comde_Cantidad = item.Comde_Cantidad

            };
            var list = _compraService.InsertCompraDetalle(modelo);
            return Ok(list);
        }

        [HttpPut("Update/CompraDetalle")]
        public IActionResult UpdateCompraDetalle(ComprasDetalleViewModel item)
        {
            var model = _mapper.Map<tbComprasDetalle>(item);
            var modelo = new tbComprasDetalle()
            {
                Comde_Id = item.Comde_Id,
                Comen_Id = item.Comen_Id,
                Produ_Id = item.Produ_Id,
                Comde_Cantidad = item.Comde_Cantidad
            };
            var list = _compraService.UpdateCompraDetalle(modelo);
            return Ok(list);
        }

        [HttpDelete("Delete/CompraDetalle")]
        public IActionResult DeleteCompraDetalle(int Paren_Id)
        {
            var list = _compraService.DeleteCompraDetalle(Paren_Id);
            return Ok(list);
        }

        [HttpGet("Cargar/CompraDetalle")]
        public IActionResult CargarCompraDetalle(int Paren_Id)
        {
            var list = _compraService.CargarCompraDetalle(Paren_Id);

            return Ok(list);
        }

        [HttpGet("Detalles/CompraDetalle")]
        public IActionResult DetallesCompraDetalle(int Paren_Id)
        {
            var list = _compraService.DetallesCompraDetalle(Paren_Id);

            return Ok(list);
        }

    }
}
