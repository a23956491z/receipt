# -*- coding: utf-8 -*-`

import urllib2
from sgmllib import SGMLParser
import re

import sys
reload(sys)

sys.setdefaultencoding('utf-8')

class invoiceList(SGMLParser):
    is_td = ""
    name = []
    def start_td(self, attrs):
        self.is_td = 1
    def end_td(self):
        self.is_td = ""
    def handle_data(self, text):
        if self.is_td:
            self.name.append(text)

def online_get_invoice():

    invoiceUrl = "http://invoice.etax.nat.gov.tw/"
    page = urllib2.urlopen(invoiceUrl).read()

    invoice = invoiceList()
    invoice.feed(page)

    data = ""
    for i in invoice.name:
        data += i.decode('utf-8')

    data = re.sub("......<td>", "", data)
    data = re.sub(u"增開六獎號碼相同者.+", "", data)
    reObj = re.findall("\d{3,8}", data)

    for out_invoice in reObj:
        print out_invoice

online_get_invoice()




