using AHM.Total.Travel.DataAccess.Repositories;
using System.Collections.Generic;

namespace InventarioSupermercado.DataAccess.Repository
{
    public interface IRepository<T>
    {
        public RequestStatus Insert(T item);
        public RequestStatus Update(T item);
        public RequestStatus Delete(int? id);
        public IEnumerable<T> List();
        public T Find(int? id);

    }
}