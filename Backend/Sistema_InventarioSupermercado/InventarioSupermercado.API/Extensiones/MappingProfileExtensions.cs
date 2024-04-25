using AutoMapper;
using InventarioSupermercado.Entities;
using InventarioSupermercado.Common.Models;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using InventarioSupermercado.Entities.Entities;

namespace InventarioSupermercado.API.Extensiones
{
    public class MappingProfileExtensions : Profile
    {
        public MappingProfileExtensions()
        {
            CreateMap<DepartamentosViewModel, tbDepartamentos>().ReverseMap();
            CreateMap<ComprasDetalleViewModel, tbComprasDetalle>().ReverseMap();
            CreateMap<UsuariosViewModel, tbUsuarios>().ReverseMap();
            CreateMap<ClienteViewModel, tbClientes>().ReverseMap();
            CreateMap<ProductosViewModel, tbProductos>().ReverseMap();
            CreateMap<VentasEncabezadoViewModel, tbVentasEncabezado>().ReverseMap();
            CreateMap<VentasDetalleViewModel, tbVentasDetalle>().ReverseMap();
            CreateMap<GraficosViewModel, tbGraficos>().ReverseMap();


        }
    }
}
