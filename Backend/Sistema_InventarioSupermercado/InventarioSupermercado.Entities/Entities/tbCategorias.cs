﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace InventarioSupermercado.Entities.Entities
{
    public partial class tbCategorias
    {
        public tbCategorias()
        {
            tbProductos = new HashSet<tbProductos>();
        }

        public int Categ_Id { get; set; }
        public string Categ_Descripcion { get; set; }
        public string Cate_ImagenUrl { get; set; }

        public int Categ_UsuarioCreacion { get; set; }
        public DateTime Categ_FechaCreacion { get; set; }
        public int? Categ_UsuarioModificacion { get; set; }
        public DateTime? Categ_FechaModificacion { get; set; }
        public bool? Categ_Estado { get; set; }

        public virtual tbUsuarios Categ_UsuarioCreacionNavigation { get; set; }
        public virtual tbUsuarios Categ_UsuarioModificacionNavigation { get; set; }
        public virtual ICollection<tbProductos> tbProductos { get; set; }
    }
}