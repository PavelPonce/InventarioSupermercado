using System;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Options;
using MimeKit;
using System.Threading.Tasks;
using InventarioSupermercado.API.Services;

namespace InventarioSupermercado.API
{
    public class MailService : IMailService
    {
        private readonly MailSettings _mailSettings;

        public MailService(IOptions<MailSettings> mailSettingsOptions)
        {
            _mailSettings = mailSettingsOptions.Value;
        }

        public bool SendMail(MailData mailData)
        {
            try
            {
                string verificationCode = GenerateUniqueVerificationCode();

                using (var emailMessage = new MimeMessage())
                {
                    emailMessage.From.Add(new MailboxAddress(_mailSettings.SenderName, _mailSettings.SenderEmail));
                    emailMessage.To.Add(new MailboxAddress(mailData.EmailToName, mailData.EmailToId));
                    emailMessage.Subject = mailData.EmailSubject;

                    var bodyBuilder = new BodyBuilder();
                    bodyBuilder.TextBody = $"Tu código de verificación es: {verificationCode}";

                    emailMessage.Body = bodyBuilder.ToMessageBody();


                    using (var client = new SmtpClient())
                    {
                        client.ServerCertificateValidationCallback = (s, c, h, e) => true; 

                        client.Connect(_mailSettings.Server, _mailSettings.Port, SecureSocketOptions.Auto);

                        client.Authenticate(_mailSettings.UserName, _mailSettings.Password);

                        client.Send(emailMessage);
                        client.Disconnect(true);
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }




        private string GenerateUniqueVerificationCode()
        {
            Guid guid = Guid.NewGuid();
            string verificationCode = guid.ToString().Substring(0, 6);

            return verificationCode;
        }

    }
}
