import smtplib, email
from email import encoders
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import os
import argparse
import json,io
from bs4 import BeautifulSoup
 
parser = argparse.ArgumentParser(description='Email companion program for fastlane')
parser.add_argument("-s", "--success", help="Sends a successful email", action="store_true")
parser.add_argument("-f", "--failure", help="Sends a failure email", action="store_true")
parser.add_argument("--no-attachment", help="Skips attachment if set", action="store_true")
args = parser.parse_args()
 
runId = os.getenv('GITHUB_RUN_ID' , "")
runNumber = os.getenv('GITHUB_RUN_NUMBER')
actionId = os.getenv('GITHUB_ACTION')
apiLevel = os.getenv('API' , "")
githubRunUrl = "https://github.com/PyiHeinTun/tmdb_movie/actions/runs/%s"%(runId)
githubActionUrl = "https://github.com/PyiHeinTun/tmdb_movie/runs/%s?check_suite_focus=true"%(actionId)
 
 
 
# Settings
 
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
SMTP_USERNAME = 'pyihein.tun@mm-digital-solutions.com'
SMTP_PASSWORD = 'Pyiheintun109677'
SMTP_FROM = 'pyihein.tun@mm-digital-solutions.com'
SMTP_TO = 'pyihein.tun@mm-digital-solutions.com'
 
TEXT_FILENAME = "./TestReport%sAPI%s.zip"%(runNumber, apiLevel)
 
SUCCESS_HEADER = "Jolly Theme One CI Job Successful (#%s)"%(runNumber)
SUCCESS_MESSAGE = """\
Test Automation (#%s) for Project Completed Successfully
See the results here:
%s
"""%(runNumber, githubRunUrl)
 
FAILURE_HEADER = "Jolly Theme One CI Job Failure (#%s)"%(runNumber)
FAILURE_MESSAGE = """\
There was a failure in Test Automation (#%s) for Project
Please check the error log output here
%s
"""%(runNumber, githubRunUrl)
 
 
 
HTML_TEMPLATE = """\
<html>
<head>
<style>
#summary {
   margin-top: 30px;
   margin-bottom: 40px;
}
#summary table {
   border-collapse: collapse;
}
#summary td {
   vertical-align: top;
}
.infoBox {
   width: 110px;
   padding-top: 15px;
   padding-bottom: 15px;
   text-align: center;
}
.infoBox p {
   margin: 0;
}
.counter, .percent {
   font-size: 120%;
   font-weight: bold;
   margin-bottom: 8px;
}
#duration {
   width: 125px;
}
 
#successRate, .summaryGroup {
   border: solid 2px #d0d0d0;
   -moz-border-radius: 10px;
   border-radius: 10px;
   behavior: url(css3-pie-1.0beta3.htc);
}
 
#successRate {
   width: 140px;
   margin-left: 35px;
}
 
#successRate .percent {
   font-size: 180%;
}
 
.success, .success a {
   color: #008000;
}
 
div.success, #successRate.success {
   background-color: #bbd9bb;
   border-color: #008000;
}
 
.failures, .failures a {
   color: #b60808;
}
 
div.failures, #successRate.failures {
   background-color: #ecdada;
   border-color: #b60808;
}
</style>
</head>
<body>
 
<div id="content">
<h1>Test Summary</h1>
<div id="summary">
<table>
<tr>
<td>
<div style="border: solid 2px #d0d0d0;
   -moz-border-radius: 10px;
   border-radius: 10px;
   behavior: url(css3-pie-1.0beta3.htc);">
<table>
<tr>
<td>
<div class="infoBox" id="tests">
<div class="counter">tests</div>
<p>tests</p>
</div>
</td>
<td>
<div class="infoBox" id="failures">
<div class="counter">failures</div>
<p>failures</p>
</div>
</td>
<td>
<div class="infoBox" id="duration">
<div class="counter">duration</div>
<p>duration</p>
</div>
</td>
</tr>
</table>
</div>
</td>
<td>
<div class="infoBox failures" id="successRate">
<div class="percent">percent</div>
<p>successful</p>
</div>
</td>
</tr>
</table>
</div>
 
</body>
</html>
"""
 
jsonFile = open("MailRecipients.json").read()
recipients = json.loads(jsonFile)
 
# Now construct the message
msg = email.mime.multipart.MIMEMultipart()
 
msg.add_header('To', ",".join(recipients["mails"]))
msg.add_header('From', SMTP_FROM)
if args.success :
   msg.add_header('Subject' , SUCCESS_HEADER)
   body = email.mime.text.MIMEText(SUCCESS_MESSAGE)
elif args.failure :
   msg.add_header('Subject' , FAILURE_HEADER)
   body = email.mime.text.MIMEText(FAILURE_MESSAGE)
 
   # importing
   HTML_FILE_PATH = "./TestReport%sAPI%s/index.html"%(runNumber, apiLevel)
   with io.open(HTML_FILE_PATH, "r", encoding="utf-8") as f:
       mailBody= f.read()
 
   soup = BeautifulSoup(mailBody, 'html.parser')
   counters = soup.find_all("div", class_="counter")
   successRate = soup.find_all("div", class_="percent")[0].contents[0]
   successRateClass = soup.find(id="successRate")['class'][1]
   failedTests = soup.find(id="tab0")
   print(failedTests.prettify())
   testCount = counters[0].contents[0]
   failures = counters[1].contents[0]
   duration = counters[2].contents[0]
 
   htmlTemplate = BeautifulSoup(HTML_TEMPLATE, 'html.parser')
   placeHolders = htmlTemplate.find_all("div", class_="counter")
   htmlTemplate.find_all("div", class_="percent")[0].contents[0] = successRate
   htmlTemplate.find(id="successRate")['class'][1] = successRateClass
   placeHolders[0].contents[0] = testCount
   placeHolders[1].contents[0] = failures
   placeHolders[2].contents[0] = duration
 
   msgTestSummary = email.MIMEText.MIMEText(htmlTemplate.prettify(), 'html')
   htmlTestSummaryPart = MIMEMultipart('alternative')
   htmlTestSummaryPart.attach(msgTestSummary)
 
   msgFailedTests = email.MIMEText.MIMEText(failedTests.prettify(), 'html')
   htmlFailedTestsPart = MIMEMultipart('alternative')
   htmlFailedTestsPart.attach(msgFailedTests)
 
   msg.attach(body)
   msg.attach(htmlTestSummaryPart)
   msg.attach(htmlFailedTestsPart)
 
   # msgAlternative = MIMEMultipart('alternative')
   # msg.attach(msgAlternative)
 
   # msgText = MIMEText('This is the alternative plain text message.')
   # msgAlternative.attach(msgText)
 
   # # We reference the image in the IMG SRC attribute by the ID we give it below
   # msgText = MIMEText(mailBody, 'html')
   # msgAlternative.attach(msgText)
 
   if args.no_attachment != True :
       attachment = email.MIMEBase.MIMEBase('application', 'octet-stream')
       attachment.set_payload(open(TEXT_FILENAME).read())
       attachment.add_header('Content-Disposition', 'attachment', filename=os.path.basename(TEXT_FILENAME))
       encoders.encode_base64(attachment)
       msg.attach(attachment)
 
# msg.attach(body)
 
 
# Now send the message
mailer = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
# EDIT: mailer is already connected
# mailer.connect()
# mailer.connect(SMTP_SERVER,SMTP_PORT)
mailer.ehlo()
mailer.starttls()
mailer.ehlo()
mailer.login(SMTP_USERNAME, SMTP_PASSWORD)
mailer.sendmail(SMTP_FROM, recipients["mails"], msg.as_string())
mailer.close()