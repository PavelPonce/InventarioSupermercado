using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.DataAccess.Context
{
   public class DB_SupermercadoInventarioContext : DbContext
    {
        public DB_SupermercadoInventarioContext()
        {
        }

        public DB_SupermercadoInventarioContext(DbContextOptions<DB_SupermercadoInventarioContext> options)
            : base(options)
        {
        }
    }
}
