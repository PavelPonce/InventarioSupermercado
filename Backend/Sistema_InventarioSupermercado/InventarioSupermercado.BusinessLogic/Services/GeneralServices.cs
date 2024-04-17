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
  public  class GeneralServices
    {
        private readonly DepartamentosRepository _departamentosRepository;
        private readonly ContraeñaRepository _contraeñaRepository;


        public GeneralServices(DepartamentosRepository departamentosRepository, ContraeñaRepository contraeñaRepository)
        {
            _departamentosRepository = departamentosRepository;
            _contraeñaRepository = contraeñaRepository;
        }




        #region Departamento
        public ServiceResult ListadoDepto1()
        {
            var result = new ServiceResult();
            try
            {
                var list = _departamentosRepository.List();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        #endregion


        #region contra
        public ServiceResult ReestablecerContra(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _contraeñaRepository.ActualizarContra(item);

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
        #endregion
    }
}
