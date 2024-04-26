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
    public class ClienteController : Controller
    {
        private readonly SupermercadoService _supermercadoService;
        private readonly IMapper _mapper;

        public ClienteController(SupermercadoService supermercadoService, IMapper mapper)
        {
            _supermercadoService = supermercadoService;
            _mapper = mapper;
        }
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet("Numeration")]
        public IActionResult Numeration()
        {
            var list = _supermercadoService.CliNumeration();
            return Ok(list);
        }
    }
}
