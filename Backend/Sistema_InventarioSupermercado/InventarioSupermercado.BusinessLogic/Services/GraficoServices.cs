using AHM.Total.Travel.BusinessLogic;
using InventarioSupermercado.DataAccess.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventarioSupermercado.BusinessLogic.Services
{
    public class GraficoServices
    {
        private readonly GraficoRepository _graficoRepository;
        public GraficoServices(GraficoRepository graficoRepository)
        {
            _graficoRepository = graficoRepository;
        }

        public ServiceResult CantidadVentaPorGenero()
        {
            var result = new ServiceResult();
            try
            {
                var list = _graficoRepository.CantidadVentaPorGenero();
                if (list.Any())
                {
                    return result.Ok(list);
                }
                else {
                    return result.Error(list);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        public ServiceResult TotalVentasPorCategoria()
        {
            var result = new ServiceResult();
            try
            {
                var list = _graficoRepository.TotalVentasPorCategoria();
                if (list.Any())
                {
                    return result.Ok(list);
                }
                else
                {
                    return result.Error(list);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        public ServiceResult CantidadRegistrosPorClientesPorGenero()
        {
            var result = new ServiceResult();
            try
            {
                var list = _graficoRepository.CantidadRegistrosPorClientesPorGenero();
                if (list.Any())
                {
                    return result.Ok(list);
                }
                else
                {
                    return result.Error(list);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        public ServiceResult TotalGanancia()
        {
            var result = new ServiceResult();
            try
            {
                var list = _graficoRepository.TotalGanancia();
                if (list.Any())
                {
                    return result.Ok(list);
                }
                else
                {
                    return result.Error(list);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
    }
}
