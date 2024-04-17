using InventarioSupermercado.API;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InventarioSupermercado.API.Services
{
    public interface IMailService
    {
        bool SendMail(MailData mailData);
    }
}
