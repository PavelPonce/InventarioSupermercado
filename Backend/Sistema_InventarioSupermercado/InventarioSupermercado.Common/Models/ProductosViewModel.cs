using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.Common.Models
{
    public class ProductosViewModel
    {

        public int Produ_Id { get; set; }
        public string Produ_Descripcion { get; set; }
        public int Produ_Existencia { get; set; }
        public int Unida_Id { get; set; }
        public decimal Produ_PrecioCompra { get; set; }
        public decimal Produ_PrecioVenta { get; set; }
        public int Impue_Id { get; set; }
        public int Categ_Id { get; set; }
        public int Prove_Id { get; set; }
        public int Sucur_Id { get; set; }
        public int Produ_UsuarioCreacion { get; set; }
        public DateTime Produ_FechaCreacion { get; set; }
        public int? Produ_UsuarioModificacion { get; set; }
        public DateTime? Produ_FechaModificacion { get; set; }
        public bool? Produ_Estado { get; set; }

        public string Produ_ImagenUrl { get; set; }

        [NotMapped]
        public string Unida_Descripcion { get; set; }
        [NotMapped]
        public string Prove_Marca { get; set; }
        [NotMapped]
        public decimal Impue_Descripcion { get; set; }

        [NotMapped]
        public string UsuarioCreacion { get; set; }
        [NotMapped]
        public string UsuarioModificacion { get; set; }
        [NotMapped]
        public string Categ_Descripcion { get; set; }

        [NotMapped]
        public string Sucur_Descripcion { get; set; }

        [NotMapped]
        public int Vende_Id { get; set; }
        public int Vende_Cantidad { get; set; }
        [NotMapped]
        public int Vende_UsuarioCreacion { get; set; }
        [NotMapped]
        public DateTime Vende_FechaCreacion { get; set; }
        [NotMapped]
        public int? Vende_UsuarioModificacion { get; set; }
        [NotMapped]
        public DateTime? Vende_FechaModificacion { get; set; }
        [NotMapped]
        public bool? Vende_Estado { get; set; }



        [NotMapped]
        public string cliente { get; set; }





        public int Clien_Id { get; set; }
    }
}
