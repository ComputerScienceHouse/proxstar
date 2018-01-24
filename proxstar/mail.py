import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


def send_email(toaddr, subject, body):
    fromaddr = 'proxstar@csh.rit.edu'
    msg = MIMEMultipart()
    msg['From'] = fromaddr
    msg['To'] = toaddr
    msg['Subject'] = subject
    body = body
    msg.attach(MIMEText(body, 'plain'))
    server = smtplib.SMTP('mail.csh.rit.edu', 25)
    server.starttls()
    text = msg.as_string()
    server.sendmail(fromaddr, toaddr, text)
    server.quit()


def send_vm_expire_email(user, name, days):
    toaddr = "{}@csh.rit.edu".format(user)
    subject = 'Proxstar VM Expiration Notice'
    if days != 1:
        body = "{} is expiring in {} days. If you would like to keep this VM, please log into Proxstar and renew it.".format(
            name, days)
    else:
        body = "{} is expiring in {} day. If you would like to keep this VM, please log into Proxstar and renew it.".format(
            name, days)
    send_email(toaddr, subject, body)
