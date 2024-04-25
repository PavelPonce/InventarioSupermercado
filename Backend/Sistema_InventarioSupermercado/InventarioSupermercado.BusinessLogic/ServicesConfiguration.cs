using InventarioSupermercado.BusinessLogic.Services;
using InventarioSupermercado.DataAccess;
using InventarioSupermercado.DataAccess.Repository;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace InventarioSupermercado.BusinessLogic
{
    public static class ServicesConfiguration
    {
        public static void DataAccess(this IServiceCollection service, string conn)
        {
          service.AddScoped<DepartamentosRepository>();
            service.AddScoped<ComprasDetalleRepository>();
            service.AddScoped<ComprasEncabezadoRepository>();
            service.AddScoped<ProductosRepository>();
            service.AddScoped<UsuariosRepository>();
            service.AddScoped<VentasDetalleRepository>();
            service.AddScoped<VentasEncabezadoRepository>();
            service.AddScoped<ContraeñaRepository>();
            service.AddScoped<ClientesRepository>();
            service.AddScoped<ProductosRepository>();
            service.AddScoped<GraficoRepository>();


            InventarioSupermercadoContext.BuildConnectionString(conn);
        }

        public static void BusinessLogic(this IServiceCollection service)
        {
            service.AddScoped<GeneralServices>();
            service.AddScoped<AccesoService>();
            service.AddScoped<GraficoServices>();
            service.AddScoped<CompraService>();
            service.AddScoped<SupermercadoService>();


        }
    }
}
