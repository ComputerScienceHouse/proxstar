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


def send_vm_expire_email(user, vms):
    toaddr = "{}@csh.rit.edu".format(user)
    subject = 'Proxstar VM Expiration Notice'
    body = "The following VMs in Proxstar are expiring soon:\n\n"
    for vm in vms:
        if vm[1] == 0:
            body += "    - {} today (VM has been stopped)\n".format(
                vm[0], vm[1])
        if vm[1] == 1:
            body += "    - {} in 1 day\n".format(vm[0])
        else:
            body += "    - {} in {} days\n".format(vm[0], vm[1])
    body += "\nPlease login to Proxstar and renew any VMs you would like to keep."
    send_email(toaddr, subject, body)
