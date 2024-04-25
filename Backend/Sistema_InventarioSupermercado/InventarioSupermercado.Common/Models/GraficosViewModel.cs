using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.Common.Models
{
    public class GraficosViewModel
    {
        public int Cantidad { get; set; }
        public double Total { get; set; }
        public char Genero { get; set; }
        public int Ano { get; set; }
        public int Mes { get; set; }
        public string Categoria { get; set; }

    }
}
