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
            InventarioSupermercadoContext.BuildConnectionString(conn);

            //}

            //public static void BusinessLogic(this IServiceCollection service)
            //{
            //    service.AddScoped<GeneralServices>();


        }



        public static void BusinessLogic(this IServiceCollection service)
        {
            service.AddScoped<GeneralServices>();


        }
    }
}
