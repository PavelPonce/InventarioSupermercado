using InventarioSupermercado.Common.Models;
using InventarioSupermercado.API.Services;
using Microsoft.AspNetCore.Mvc;
using System;
using InventarioSupermercado.Entities.Entities;
using InventarioSupermercado.BusinessLogic.Services;
using AutoMapper;

namespace InventarioSupermercado.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MailController : ControllerBase
    {
        private readonly IMailService _mailService;
        private readonly GeneralServices _generalService;
        private readonly IMapper _mapper;



        public MailController(IMailService mailService, GeneralServices generalServices, IMapper mapper)
        {
            _mailService = mailService;
            _generalService = generalServices;
            _mapper = mapper;
        }

        [HttpPost]
        [Route("SendMail")]
        public IActionResult SendMail(MailData mailData)
        {
            bool isSent = _mailService.SendMail(mailData);

            if (isSent)
            {
                return Ok("Si entro");
            }
            else
            {
                return StatusCode(500, "Error al envio");
            }
        }



        [HttpPut("ReestablecerContra")]
        public IActionResult Updatecontra(UsuariosViewModel item)
        {

            var model = _mapper.Map<tbUsuarios>(item);
            var modelo = new tbUsuarios()
            {
                Usuar_Id = item.Usuar_Id,
                Usuar_Contrasena = item.Usuar_Contrasena,
                Usuar_UsuarioModificacion = 1,
                Usuar_FechaModificacion = DateTime.Now,

            };
            var list = _generalService.ReestablecerContra(modelo);
            if (list.Success)
            {
                return Ok(list);
            }
            else
            {
                return Problem(list.Message);
            }
        }
    }
}
