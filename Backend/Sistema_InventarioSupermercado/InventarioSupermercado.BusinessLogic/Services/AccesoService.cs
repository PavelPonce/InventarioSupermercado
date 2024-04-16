using AHM.Total.Travel.BusinessLogic;
using InventarioSupermercado.DataAccess.Repository;
using InventarioSupermercado.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.BusinessLogic.Services
{
   public class AccesoService
    {
        private readonly UsuariosRepository _usuariosRepository;


        public AccesoService(UsuariosRepository usuariosRepository)
        {
            _usuariosRepository = usuariosRepository;
        }

        #region Usuarios
        public ServiceResult ListUsuarios()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuariosRepository.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        public ServiceResult InsertUsuarios(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuariosRepository.Insert(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult UpdateUsuarios(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuariosRepository.Update(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult DeleteUsuarios(int Usuar_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuariosRepository.Delete(Usuar_Id);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult CargarUsuarios(int Usuar_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuariosRepository.find(Usuar_Id);

                return result.Ok(lost);

            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult DetallesUsuarios(int Usuar_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuariosRepository.Details(Usuar_Id);

                return result.Ok(lost);

            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        #endregion

    }
}
