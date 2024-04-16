using AHM.Total.Travel.BusinessLogic;
using InventarioSupermercado.DataAccess.Repository;
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

        public GeneralServices(DepartamentosRepository departamentosRepository)
        {
            _departamentosRepository = departamentosRepository;
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
    }
}
