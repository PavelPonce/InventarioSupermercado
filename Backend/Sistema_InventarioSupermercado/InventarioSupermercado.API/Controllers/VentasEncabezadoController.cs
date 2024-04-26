using AutoMapper;
using InventarioSupermercado.BusinessLogic.Services;
using InventarioSupermercado.Common.Models;
using InventarioSupermercado.DataAccess.Repository;
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



        private readonly VentasDetalleRepository _ventasDetalleRepository;

        private readonly SupermercadoService _supermercadoService;

        private readonly IMapper _mapper;

        public VentasEncabezadoController(SupermercadoService supermercadoService, IMapper mapper, VentasDetalleRepository ventasDetalleRepository)
        {
            _supermercadoService = supermercadoService;
            _mapper = mapper;
            _ventasDetalleRepository = ventasDetalleRepository;

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
        public IActionResult InsertEncabezado(VentasEncabezadoViewModel item)
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
                        return Ok(encabezadoExistente);
                    }
                    else
                    {
                        return BadRequest("Error al insertar el detalle");
                    }

                    return Ok(GetEncabezadoVariables(encabezadoExistente));
                }
                else
                {
                    var encabezado = new tbVentasEncabezado
                    {
                        Sucur_Id = item.Sucur_Id,
                        Clien_Id = item.Clien_Id,
                        Venen_FechaPedido = DateTime.Now,
                        Venen_UsuarioCreacion = 1,
                        Venen_FechaCreacion = DateTime.Now
                    };

                    // Insertar el encabezado
                    var resultadoInsertarEncabezado = _supermercadoService.InsertEncabezado(encabezado);

                    if (resultadoInsertarEncabezado != null && resultadoInsertarEncabezado.Venen_Id > 0)
                    {
                        var salidaEncabezado = new
                        {
                            Venen_Id = resultadoInsertarEncabezado.Venen_Id,
                            Sucur_Id = resultadoInsertarEncabezado.Sucur_Id,
                            Clien_Id = resultadoInsertarEncabezado.Clien_Id,
                            Venen_FechaPedido = resultadoInsertarEncabezado.Venen_FechaPedido,
                            Venen_UsuarioCreacion = resultadoInsertarEncabezado.Venen_UsuarioCreacion,
                            Venen_FechaCreacion = resultadoInsertarEncabezado.Venen_FechaCreacion
                        };

                        if (item.Produ_Id != null && item.Vende_Cantidad > 0)
                        {
                            var detalle = new tbVentasDetalle
                            {
                                Venen_Id = resultadoInsertarEncabezado.Venen_Id,
                                Produ_Id = item.Produ_Id,
                                Vende_Cantidad = item.Vende_Cantidad,
                            };
                            var detalleInsertado = _supermercadoService.InsertDetalle(detalle);

                            if (detalleInsertado != null)
                            {
                                return Ok(new { Encabezado = salidaEncabezado, Detalle = detalleInsertado });
                            }
                            else
                            {
                                return BadRequest("Error al insertar el detalle");
                            }
                        }

                        return Ok(new { Encabezado = salidaEncabezado });
                    }
                    else
                    {
                        return BadRequest("Error al insertar el encabezado");
                    }
                }
            }
            catch (Exception ex)
            {
                return BadRequest("Error interno del servidor: " + ex.Message);
            }
        }



        private object GetEncabezadoVariables(tbVentasEncabezado encabezado)
        {
            var salidaEncabezado = new
            {
                Venen_Id = encabezado.Venen_Id,
                Sucur_Id = encabezado.Sucur_Id,
                Clien_Id = encabezado.Clien_Id,
                Venen_FechaPedido = encabezado.Venen_FechaPedido,
                Venen_UsuarioCreacion = encabezado.Venen_UsuarioCreacion,
                Venen_FechaCreacion = encabezado.Venen_FechaCreacion
            };

            return salidaEncabezado;
        }





        //[HttpPost("Insert/Encabezado")]
        //public IActionResult InsertEncabezado(VentasEncabezadoViewModel item)
        //{
        //    try
        //    {
        //        var encabezadoExistente = _supermercadoService.ObtenerEncabezadoExistente(item.Clien_Id);

        //        if (encabezadoExistente != null)
        //        {
        //            var detalle = new tbVentasDetalle
        //            {
        //                Venen_Id = encabezadoExistente.Venen_Id,
        //                Produ_Id = item.Produ_Id,
        //                Vende_Cantidad = item.Vende_Cantidad,
        //            };
        //            var detalleInsertado = _ventasDetalleRepository.Insert(detalle);
        //            if (detalleInsertado.CodeStatus > 0)
        //            {
        //                return Ok(new { Venden_Id = encabezadoExistente.Venen_Id, DetalleId = detalleInsertado });
        //            }
        //            else { return BadRequest("Error al insertar el detalle"); }
        //        }
        //        else
        //        {
        //            var encabezado = new tbVentasEncabezado
        //            {
        //                Sucur_Id = item.Sucur_Id,
        //                Clien_Id = item.Clien_Id,
        //                Venen_FechaPedido = DateTime.Now,
        //                Venen_UsuarioCreacion = 1,
        //                Venen_FechaCreacion = DateTime.Now
        //            };

        //            var encabezadoInsertadoId = _supermercadoService.InsertEncabezado(encabezado);

        //            if (encabezadoInsertadoId > 0)
        //            {
        //                var detalle = new tbVentasDetalle
        //                {
        //                    Venen_Id = encabezadoInsertadoId,
        //                    Produ_Id = item.Produ_Id,
        //                    Vende_Cantidad = item.Vende_Cantidad,
        //                };

        //                var detalleInsertadoId = _ventasDetalleRepository.Insert(detalle);

        //                if (detalleInsertadoId.CodeStatus > 0)
        //                {
        //                    // Devolver venen_Id junto con otros datos
        //                    return Ok(new { Venden_Id = encabezadoInsertadoId, DetalleId = detalleInsertadoId });
        //                }
        //                else
        //                {
        //                    return BadRequest("Error al insertar el detalle");
        //                }
        //            }
        //            else
        //            {
        //                return BadRequest("Error al insertar el encabezado");
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return BadRequest("Error interno del servidor: " + ex.Message);
        //    }
        //}






        //[HttpPost("Insert/Encabezado")]
        //public IActionResult InsertEncabezado(VentasEncabezadoViewModel item)
        //{
        //    try
        //    {
        //        var encabezadoExistente = _supermercadoService.ObtenerEncabezadoExistente(item.Clien_Id);

        //        if (encabezadoExistente != null)
        //        {
        //            var detalle = new tbVentasDetalle
        //            {
        //                Venen_Id = encabezadoExistente.Venen_Id,
        //                Produ_Id = item.Produ_Id,
        //                Vende_Cantidad = item.Vende_Cantidad,

        //            };
        //            var detalleInsertado = _ventasDetalleRepository.Insert(detalle);

        //            if (detalleInsertado.CodeStatus > 0)
        //            {
        //                return Ok(new { Encabezado = encabezadoExistente, DetalleId = detalleInsertado.CodeStatus });
        //            }
        //            else
        //            {
        //                return BadRequest("Error al insertar el detalle");
        //            }
        //        }
        //        else
        //        {
        //            // Si no existe encabezado
        //            var encabezado = new tbVentasEncabezado
        //            {
        //                Sucur_Id = item.Sucur_Id,
        //                Clien_Id = item.Clien_Id,
        //                Venen_FechaPedido = DateTime.Now,
        //                Venen_UsuarioCreacion = 1,
        //                Venen_FechaCreacion = DateTime.Now
        //            };

        //            var encabezadoInsertado = _supermercadoService.InsertEncabezado(encabezado);

        //            if (encabezadoInsertado != null)
        //            {
        //                // detalle insert
        //                var detalle = new tbVentasDetalle
        //                {
        //                    Venen_Id = encabezadoExistente.Venen_Id,
        //                    Produ_Id = item.Produ_Id,
        //                    Vende_Cantidad = item.Vende_Cantidad,
        //                };
        //                var detalleInsertado = _ventasDetalleRepository.Insert(detalle);

        //                if (detalleInsertado.CodeStatus > 0)
        //                {
        //                    return Ok(new { Encabezado = encabezadoInsertado, DetalleId = detalleInsertado.CodeStatus });
        //                }
        //                else
        //                {
        //                    return BadRequest("Error al insertar el detalle");
        //                }
        //            }
        //            else
        //            {
        //                return BadRequest("Error al insertar el encabezado");
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return BadRequest("Error interno del servidor: " + ex.Message);
        //    }
        //}







        //[HttpPost("Insert/Encabezado")]
        //public IActionResult InsertEncabezado(VentasEncabezadoViewModel item)
        //{
        //    try
        //    {
        //        var encabezadoExistente = _supermercadoService.ObtenerEncabezadoExistente(item.Clien_Id);

        //        if (encabezadoExistente != null)
        //        {
        //            var detalle = new tbVentasDetalle
        //            {
        //                Venen_Id = encabezadoExistente.Venen_Id,
        //                Produ_Id = item.Produ_Id,
        //                Vende_Cantidad = item.Vende_Cantidad,

        //            };
        //            var detalleInsertado = _ventasDetalleRepository.Insert(detalle);

        //            if (detalleInsertado.CodeStatus > 0)
        //            {
        //                return Ok(new { Encabezado = encabezadoExistente, DetalleId = detalleInsertado.CodeStatus });
        //            }
        //            else
        //            {
        //                return BadRequest("Error al insertar el detalle");
        //            }
        //        }
        //        else
        //        {
        //            // Si no existe encabezado
        //            var encabezado = new tbVentasEncabezado
        //            {
        //                Sucur_Id = item.Sucur_Id,
        //                Clien_Id = item.Clien_Id,
        //                Venen_FechaPedido = DateTime.Now,
        //                Venen_UsuarioCreacion = 1,
        //                Venen_FechaCreacion = DateTime.Now
        //            };

        //            var encabezadoInsertado = _supermercadoService.InsertEncabezado(encabezado);

        //            if (encabezadoInsertado != null)
        //            {
        //                // detalle insert
        //                var detalle = new tbVentasDetalle
        //                {
        //                    Venen_Id = encabezadoExistente.Venen_Id,
        //                    Produ_Id = item.Produ_Id,
        //                    Vende_Cantidad = item.Vende_Cantidad,
        //                };
        //                var detalleInsertado = _ventasDetalleRepository.Insert(detalle);

        //                if (detalleInsertado.CodeStatus > 0)
        //                {
        //                    return Ok(new { Encabezado = encabezadoInsertado, DetalleId = detalleInsertado.CodeStatus });
        //                }
        //                else
        //                {
        //                    return BadRequest("Error al insertar el detalle");
        //                }
        //            }
        //            else
        //            {
        //                return BadRequest("Error al insertar el encabezado");
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return BadRequest("Error interno del servidor: " + ex.Message);
        //    }
        //}










        //[HttpPost("Insert/Encabezado")]
        //public tbVentasEncabezado InsertEncabezado(VentasEncabezadoViewModel item)
        //{
        //    try
        //    {
        //        var encabezadoExistente = _supermercadoService.ObtenerEncabezadoExistente(item.Clien_Id);

        //        if (encabezadoExistente != null)
        //        {
        //            var detalle = new tbVentasDetalle
        //            {
        //                Venen_Id = encabezadoExistente.Venen_Id,
        //                Produ_Id = item.Produ_Id,
        //                Vende_Cantidad = item.Vende_Cantidad,

        //            };
        //            var detalleInsertado = _supermercadoService.InsertDetalle(detalle);

        //            if (detalleInsertado != null)
        //            {
        //                return encabezadoExistente;
        //            }
        //            else
        //            {
        //                return null;
        //            }
        //        }
        //        else
        //        {
        //            // Si no existee encc
        //            var encabezado = new tbVentasEncabezado
        //            {
        //                Sucur_Id = item.Sucur_Id,
        //                Clien_Id = item.Clien_Id,
        //                Venen_FechaPedido = DateTime.Now,
        //                Venen_UsuarioCreacion = 1,
        //                Venen_FechaCreacion = DateTime.Now
        //            };

        //            var encabezadoInsertado = _supermercadoService.InsertEncabezado(encabezado);

        //            if (encabezadoInsertado != null)
        //            {
        //                // detalle inserttt
        //                var detalle = new tbVentasDetalle
        //                {
        //                    Venen_Id = encabezadoExistente.Venen_Id,
        //                    Produ_Id = item.Produ_Id,
        //                    Vende_Cantidad = item.Vende_Cantidad,
        //                };
        //                var detalleInsertado = _supermercadoService.InsertDetalle(detalle);

        //                if (detalleInsertado != null)
        //                {
        //                    return encabezadoInsertado;
        //                }
        //                else
        //                {
        //                    return null;
        //                }
        //            }
        //            else
        //            {
        //                return null;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return null;
        //    }
        //}








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



        [HttpPost("EmisionFactura")]
        public IActionResult EmisionFactura(int mtPag_Id, int venen_Id, string venen_NroTarjeta)
        {
            try
            {
                bool actualizacionExitosa = _supermercadoService.ActualizarEncabezado(mtPag_Id, venen_Id, venen_NroTarjeta);

                if (actualizacionExitosa)
                {
                    return Ok("La actualización del encabezado fue exitosa.");
                }
                else
                {
                    return NotFound("No se encontró ningún encabezado con los parámetros proporcionados o la actualización no pudo realizarse.");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error interno del servidor: " + ex.Message);
            }
        }






        [HttpGet("MetodoPago/DDL")]
        public IActionResult ListarMetodosPago()
        {
            try
            {
                var metodosPago = _supermercadoService.ListarMetodosPago();
                return Ok(metodosPago);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error interno del servidor: " + ex.Message);
            }
        }


    }
}






//using AutoMapper;
//using InventarioSupermercado.BusinessLogic.Services;
//using InventarioSupermercado.Common.Models;
//using InventarioSupermercado.Entities.Entities;
//using Microsoft.AspNetCore.Mvc;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Threading.Tasks;

//namespace InventarioSupermercado.API.Controllers
//{
//    public class VentasEncabezadoController : Controller
//    {
//        private readonly SupermercadoService _supermercadoService;

//        private readonly IMapper _mapper;

//        public VentasEncabezadoController(SupermercadoService supermercadoService, IMapper mapper)
//        {
//            _supermercadoService = supermercadoService;
//            _mapper = mapper;
//        }

//        [HttpGet("List/Encabezado")]
//        public IActionResult ListEncabezado()
//        {
//            try
//            {
//                var usuarios = _supermercadoService.ListEncabezado();
//                return Ok(usuarios);
//            }
//            catch (Exception ex)
//            {
//                return StatusCode(500, "Error al obtener la lista de usuarios.");
//            }
//        }

//        [HttpGet("List/Sucursales")]
//        public IActionResult ListSucursales()
//        {
//            try
//            {
//                var usuarios = _supermercadoService.ListSucursal();
//                return Ok(usuarios);
//            }
//            catch (Exception ex)
//            {
//                return StatusCode(500, "Error al obtener la lista de roles.");
//            }
//        }










//        [HttpPost("Insert/Encabezado")]
//        public tbVentasEncabezado InsertEncabezado(VentasEncabezadoViewModel item)
//        {
//            try
//            {
//                var encabezadoExistente = _supermercadoService.ObtenerEncabezadoExistente(item.Clien_Id);

//                if (encabezadoExistente != null)
//                {
//                    var detalle = new tbVentasDetalle
//                    {
//                        Venen_Id = encabezadoExistente.Venen_Id,
//                        Produ_Id = item.Produ_Id,
//                        Vende_Cantidad = item.Vende_Cantidad,

//                    };
//                    var detalleInsertado = _supermercadoService.InsertDetalle(detalle);

//                    if (detalleInsertado != null)
//                    {
//                        return encabezadoExistente;
//                    }
//                    else
//                    {
//                        return null;
//                    }
//                }
//                else
//                {
//                    // Si no existee encc
//                    var encabezado = new tbVentasEncabezado
//                    {
//                        Sucur_Id = item.Sucur_Id,
//                        Clien_Id = item.Clien_Id,
//                        Venen_FechaPedido = DateTime.Now,
//                        Venen_UsuarioCreacion = 1,
//                        Venen_FechaCreacion = DateTime.Now
//                    };

//                    var encabezadoInsertado = _supermercadoService.InsertEncabezado(encabezado);

//                    if (encabezadoInsertado != null)
//                    {
//                        // detalle inserttt
//                        var detalle = new tbVentasDetalle
//                        {
//                            Venen_Id = encabezadoExistente.Venen_Id,
//                            Produ_Id = item.Produ_Id,
//                            Vende_Cantidad = item.Vende_Cantidad,
//                        };
//                        var detalleInsertado = _supermercadoService.InsertDetalle(detalle);

//                        if (detalleInsertado != null)
//                        {
//                            return encabezadoInsertado;
//                        }
//                        else
//                        {
//                            return null;
//                        }
//                    }
//                    else
//                    {
//                        return null;
//                    }
//                }
//            }
//            catch (Exception ex)
//            {
//                return null;
//            }
//        }








//        //[HttpPost("Insert/Encabezado")]
//        //public IActionResult InsertEncabezado(VentasEncabezadoViewModel item)
//        //{
//        //    try
//        //    {
//        //        var model = _mapper.Map<tbVentasEncabezado>(item);

//        //        var result = _supermercadoService.InsertEncabezado(model);

//        //        return Ok(result);
//        //    }
//        //    catch (Exception ex)
//        //    {
//        //        return BadRequest(ex.Message);
//        //    }
//        //}





//        [HttpPut("Update/Encabezado")]
//        public IActionResult Y(VentasEncabezadoViewModel item)
//        {
//            var model = _mapper.Map<tbVentasEncabezado>(item);
//            var modelo = new tbVentasEncabezado()
//            {
//                Venen_Id = item.Venen_Id,
//                Sucur_Id = item.Sucur_Id,
//                Venen_FechaPedido = item.Venen_FechaPedido,
//                Clien_Id = item.Clien_Id

//            };
//            var result = _supermercadoService.UpdateEncabezado(modelo);

//            return Ok("Usuario actualizado exitosamente");

//        }



//        [HttpGet("Cargar/ListadoCarritoPrincipal")]
//        public IActionResult ListadoCarritoPrincipal(int Clien_Id)
//        {
//            var resultadoServicio = _supermercadoService.ListadoCarritoPrincipal(Clien_Id);


//                var encabezado = resultadoServicio.Data as IEnumerable<tbVentasEncabezado>;
//                return Ok(encabezado);

//        }




//        [HttpDelete("Delete/Encabezado")]
//        public IActionResult InsertEncabezado(int Venen_Id)
//        {
//            var list = _supermercadoService.DeleteEncabezado(Venen_Id);
//            return Ok(list);
//        }

//        [HttpGet("Cargar/Encabezado")]
//        public IActionResult CargarEncabezado(int Venen_Id)
//        {
//            var list = _supermercadoService.CargarEncabezado(Venen_Id);

//            return Ok(list);
//        }

//    }
//}
