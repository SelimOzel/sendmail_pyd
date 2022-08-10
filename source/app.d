import std.stdio;
import pyd.pyd, pyd.embedded;

shared static this() {
    py_init();
}

void main() {
    auto context = new InterpContext();
    context.py_stmts("
        import smtplib
        from email.mime.multipart import MIMEMultipart
        from email.mime.text import MIMEText

        msg = MIMEMultipart()
        msg.set_unixfrom('author')
        msg['From'] = 'mail@server.com'
        msg['To'] = 'mail@server.com'
        msg['Subject'] = 'simple email in python'
        message = 'here is the email'
        msg.attach(MIMEText(message))

        mailserver = smtplib.SMTP_SSL('smtpout.secureserver.net', 465)
        mailserver.ehlo()
        mailserver.login('mail@server.com', 'password')
        mailserver.sendmail('mail@server.com','mail@server.com',msg.as_string())
        mailserver.quit()");
}