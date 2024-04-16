using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.Common.Models
{
  public  class ComprasDetalleViewModel
    {
        [Display(Name = "ID")]

        public int Comde_Id { get; set; }
        [Display(Name = "ID Encabezado")]

        public int Comen_Id { get; set; }
        [Display(Name = "Id Producto")]

        public int Produ_Id { get; set; }
        [Display(Name = "Cantidad")]

        public int Comde_Cantidad { get; set; }
        [Display(Name = "Producto")]

        [NotMapped]
        public string Produ_Descripcion { get; set; }
        [Display(Name = "Precio Producto")]

        [NotMapped]

        public decimal Produ_PrecioCompra { get; set; }
        public int Comde_UsuarioCreacion { get; set; }
        public DateTime Comde_FechaCreacion { get; set; }
        public int? Comde_UsuarioModificacion { get; set; }
        public DateTime? Comde_FechaModificacion { get; set; }
        public bool? Comde_Estado { get; set; }
    }
}
