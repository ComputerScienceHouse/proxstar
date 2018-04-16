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
    body = "The following VMs in Proxstar are expiring soon or have already expired:\n\n"
    for vm in vms:
        if vm[2] == -6:
            body += "    - {} ({}) has expired (VM has been stopped and will be deleted in 1 day)\n".format(vm[1], vm[0])
        elif vm[2] < 0:
            body += "    - {} ({}) has expired (VM has been stopped and will be deleted in {} days)\n".format(
                vm[1], vm[0], (7 + int(vm[2])))
        elif vm[2] == 0:
            body += "    - {} ({}) expires today (VM has been stopped and will be deleted in 7 days)\n".format(vm[1], vm[0])
        elif vm[2] == 1:
            body += "    - {} ({}) expires in 1 day\n".format(vm[1], vm[0])
        else:
            body += "    - {} ({}) expires in {} days\n".format(vm[1], vm[0], vm[2])
    body += "\nPlease login to Proxstar (https://proxstar.csh.rit.edu/) and renew any VMs you would like to keep."
    send_email(toaddr, subject, body)


def send_rtp_vm_delete_email(vms):
    toaddr = 'rtp@csh.rit.edu'
    subject = 'Proxstar VM Deletion Report'
    body = "The following VMs in Proxstar have expired and will be deleted soon:\n\n"
    for vm in vms:
        if vm[2] == -6:
            body += "    - {} ({}) will be deleted in 1 day\n".format(vm[1], vm[0])
        else:
            body += "    - {} ({}) will be deleted in {} days\n".format(vm[1], vm[0], (7 + int(vm[2])))
    body += "\nPlease verify this list to ensure there aren't any pools included in Proxstar that shouldn't be."
    send_email(toaddr, subject, body)
