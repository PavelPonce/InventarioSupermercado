using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.Common.Models
{
    public class UsuariosViewModel
    {
        [Display(Name = "ID")]

        public int Usuar_Id { get; set; }
        [Display(Name = "Usuario")]

        public string Usuar_Usuario { get; set; }
        [Display(Name = "Contraseña")]

        public string Usuar_Contrasena { get; set; }
        [Display(Name = "idEmpleado")]

        public int Emple_Id { get; set; }
        [Display(Name = "ID Rol")]

        public int Roles_Id { get; set; }
        [Display(Name = "Es Admin")]

        public bool Usuar_Admin { get; set; }
        [Display(Name = "Ultima Sesion")]

        public DateTime? Usuar_UltimaSesion { get; set; }
        [Display(Name = "Usuario Creacion")]

        public int Usuar_UsuarioCreacion { get; set; }
        [Display(Name = "Fecha Creacion")]

        public DateTime Usuar_FechaCreacion { get; set; }
        [Display(Name = "Usuario Modificacion Id")]

        public int? Usuar_UsuarioModificacion { get; set; }
        public DateTime? Usuar_FechaModificacion { get; set; }
        public bool? Usuar_Estado { get; set; }
        [NotMapped]
        [Display(Name = "Usuario creacion")]

        public string UsuarioCreacion { get; set; }
        [NotMapped]
        [Display(Name = "Usuario Modificacion")]

        public string UsuarioModificacion { get; set; }
        [NotMapped]
        [Display(Name = "Empleado")]

        public string empleado { get; set; }
        [NotMapped]
        [Display(Name = "Rol")]

        public string Roles_Descripcion { get; set; }

        [NotMapped]
        [Display(Name = "Nombre Completo")]

        public string Perso_NombreCompleto { get; set; }
        public int Perso_Id { get; set; }
        public bool Usuar_Tipo { get; set; }
    }
}
