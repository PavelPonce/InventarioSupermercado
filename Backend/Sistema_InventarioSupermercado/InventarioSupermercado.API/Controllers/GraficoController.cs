using AutoMapper;
using InventarioSupermercado.BusinessLogic.Services;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InventarioSupermercado.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GraficoController : Controller
    {
        private readonly GraficoServices _graficoServices;

        private readonly IMapper _mapper;

        public GraficoController(GraficoServices graficoServices, IMapper mapper)
        {
            _graficoServices = graficoServices;
            _mapper = mapper;
        }

        [HttpGet("Grafico1")]
        public IActionResult Grafico1()
        {
            var listado = _graficoServices.CantidadVentaPorGenero();

            return Ok(listado);
        }
        [HttpGet("Grafico2")]
        public IActionResult Grafico2()
        {
            var listado = _graficoServices.TotalVentasPorCategoria();

            return Ok(listado);
        }
        [HttpGet("Grafico3")]
        public IActionResult Grafico3()
        {
            var listado = _graficoServices.CantidadRegistrosPorClientesPorGenero();

            return Ok(listado);
        }
        [HttpGet("Grafico4")]
        public IActionResult Grafico4()
        {
            var listado = _graficoServices.TotalGanancia();

            return Ok(listado);
        }
    }
}
