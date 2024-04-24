using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.Common.Models
{
   public class VentasEncabezadoViewModel
    {
        //encabezadooo
        public int Venen_Id { get; set; }
        public int Sucur_Id { get; set; }
        public string Venen_DireccionEnvio { get; set; }
        public DateTime Venen_FechaPedido { get; set; }
        public int Venen_UsuarioCreacion { get; set; }
        public DateTime Venen_FechaCreacion { get; set; }
        public int? Venen_UsuarioModificacion { get; set; }
        public DateTime? Venen_FechaModificacion { get; set; }
        public bool? Venen_Estado { get; set; }

        //detalle
        [NotMapped]
        public int Vende_Id { get; set; }

        public int Produ_Id { get; set; }
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



        //Productos
        [NotMapped]
        public string Produ_Descripcion { get; set; }
        [NotMapped]
        public int Produ_Existencia { get; set; }
        [NotMapped]
        public int Unida_Id { get; set; }
        [NotMapped]
        public decimal Produ_PrecioCompra { get; set; }
        [NotMapped]
        public decimal Produ_PrecioVenta { get; set; }
        [NotMapped]
        public int Impue_Id { get; set; }
        [NotMapped]
        public int Categ_Id { get; set; }
        [NotMapped]
        public int Prove_Id { get; set; }
        [NotMapped]

        public int Produ_UsuarioCreacion { get; set; }
        [NotMapped]
        public DateTime Produ_FechaCreacion { get; set; }
        [NotMapped]
        public int? Produ_UsuarioModificacion { get; set; }
        [NotMapped]
        public DateTime? Produ_FechaModificacion { get; set; }
        [NotMapped]
        public bool? Produ_Estado { get; set; }
        [NotMapped]

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
        public string cliente { get; set; }




     
        public int Clien_Id { get; set; }
        [NotMapped]
        public string Clien_PrimerNombre { get; set; }
        [NotMapped]
        public string Clien_SegundoNombre { get; set; }
        [NotMapped]
        public string Clien_PrimerApellido { get; set; }
        [NotMapped]
        public string Clien_SegundoApellido { get; set; }
        [NotMapped]
        public string Clien_Sexo { get; set; }
        [NotMapped]
        public int Estad_Id { get; set; }
        [NotMapped]
        public string Clien_Telefono { get; set; }
        [NotMapped]
        public string Clien_Correo { get; set; }
        [NotMapped]
        public string Munic_Id { get; set; }
        [NotMapped]
        public string Clien_Direccion { get; set; }
        [NotMapped]
        public int Clien_UsuarioCreacion { get; set; }
        [NotMapped]
        public int? Clien_UsuarioModificacion { get; set; }
        [NotMapped]
        public DateTime? Clien_FechaModificacion { get; set; }
        [NotMapped]
        public DateTime? Clien_FechaCreacion { get; set; }
        [NotMapped]
        public string Munic_Descripcion { get; set; }
        [NotMapped]
        public string Estad_Descripcion { get; set; }


    }
}
