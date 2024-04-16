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
    public class CompraService
    {
        private readonly ComprasDetalleRepository _comprasDetalleRepository;


        public CompraService(ComprasDetalleRepository comprasDetalleRepository)
        {
            _comprasDetalleRepository = comprasDetalleRepository;
        }


        #region ComprasDetalle
        public ServiceResult ListCompraDetalle()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _comprasDetalleRepository.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        public ServiceResult InsertCompraDetalle(tbComprasDetalle item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _comprasDetalleRepository.Insert(item);
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

        public ServiceResult UpdateCompraDetalle(tbComprasDetalle item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _comprasDetalleRepository.Update(item);
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

        public ServiceResult DeleteCompraDetalle(int Comde_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _comprasDetalleRepository.Delete(Comde_Id);
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

        public ServiceResult CargarCompraDetalle(int Comde_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _comprasDetalleRepository.find(Comde_Id);

                return result.Ok(lost);

            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult DetallesCompraDetalle(int Comde_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _comprasDetalleRepository.Details(Comde_Id);

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
