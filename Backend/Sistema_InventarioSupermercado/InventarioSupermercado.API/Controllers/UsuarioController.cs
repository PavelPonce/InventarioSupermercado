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
    public class UsuarioController : Controller
    {
        private readonly AccesoService _accesoService;
        private readonly IMapper _mapper;

        public UsuarioController(AccesoService accesoService, IMapper mapper)
        {
            _accesoService = accesoService;
            _mapper = mapper;
        }

        [HttpGet("List/Usuarios")]
        public IActionResult ListCompraDetalle()
        {
            var list = _accesoService.ListUsuarios();
            return Ok(list);
        }


        [HttpPost("Insert/Usuarios")]
        public IActionResult InsertCompraDetalle(UsuariosViewModel item)
        {
            var model = _mapper.Map<tbUsuarios>(item);
            var modelo = new tbUsuarios()
            {
                Usuar_Usuario = item.Usuar_Usuario,
                Usuar_Contrasena = item.Usuar_Contrasena,
                Emple_Id = item.Emple_Id,
                Roles_Id = item.Roles_Id,
                Usuar_Admin = item.Usuar_Admin,
                Usuar_UltimaSesion = item.Usuar_UltimaSesion
            };
            var list = _accesoService.InsertUsuarios(modelo);
            return Ok(list);
        }

        [HttpPut("Update/Usuarios")]
        public IActionResult UpdateCompraDetalle(UsuariosViewModel item)
        {
            var model = _mapper.Map<tbUsuarios>(item);
            var modelo = new tbUsuarios()
            {
                Usuar_Usuario = item.Usuar_Usuario,
                Usuar_Contrasena = item.Usuar_Contrasena,
                Emple_Id = item.Emple_Id,
                Roles_Id = item.Roles_Id,
                Usuar_Admin = item.Usuar_Admin,
                Usuar_UltimaSesion = item.Usuar_UltimaSesion
            };
            var list = _accesoService.UpdateUsuarios(modelo);
            return Ok(list);
        }

        [HttpDelete("Delete/Usuarios")]
        public IActionResult DeleteCompraDetalle(int Usuar_Id)
        {
            var list = _accesoService.DeleteUsuarios(Usuar_Id);
            return Ok(list);
        }

        [HttpGet("Cargar/Usuarios")]
        public IActionResult CargarUsuarios(int Usuar_Id)
        {
            var list = _accesoService.CargarUsuarios(Usuar_Id);

            return Ok(list);
        }

        [HttpGet("Detalles/Usuarios")]
        public IActionResult DetallesUsuarios(int Usuar_Id)
        {
            var list = _accesoService.DetallesUsuarios(Usuar_Id);

            return Ok(list);
        }
    }
}
