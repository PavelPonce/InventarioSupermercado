using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.Common.Models
{
   public class ClienteViewModel
    {
        [Display(Name = "ID")]

        public int Clien_Id { get; set; }
        [Display(Name = "Primer Nombre")]
        public string Clien_PrimerNombre { get; set; }
        [Display(Name = "Segindo Nombre")]
        public string Clien_SegundoNombre { get; set; }
        [Display(Name = "Primer Apellido")]
        public string Clien_PrimerApellido { get; set; }
        [Display(Name = "Segundo Apellido")]
        public string Clien_SegundoApellido { get; set; }
        [Display(Name = "Sexo")]
        public string Clien_Sexo { get; set; }
        [Display(Name = "Estado Id")]
        public int Estad_Id { get; set; }
        [Display(Name = "Telefono")]
        public string Clien_Telefono { get; set; }
        [Display(Name = "Correo")]
        public string Clien_Correo { get; set; }
        [Display(Name = "Municipio")]
        public string Munic_Id { get; set; }
        [NotMapped]
        public string Munic_Descripcion { get; set; }
        [NotMapped]
        public string Estad_Descripcion { get; set; }
        [Display(Name = "Direccion")]
        public string Clien_Direccion { get; set; }
        [Display(Name = "Usuario Creacion")]
        public int Clien_UsuarioCreacion { get; set; }
        public int? Clien_UsuarioModificacion { get; set; }
        public DateTime? Clien_FechaModificacion { get; set; }
        public DateTime? Clien_FechaCreacion { get; set; }
    }
}
