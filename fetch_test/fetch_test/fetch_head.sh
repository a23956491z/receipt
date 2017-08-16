#!/bin/bash
curl -Ls http://invoice.etax.nat.gov.tw/ | sed 's/spanid/span id/g'  |  tidy -imq --show-errors 0 | sed 's/、/ /g' | grep '".*">[0-9].*<' | grep 'span' | sed 's/class=\".*\"//g' | sed 's/\".*\"//g' | sed 's/<.*>//g' | sed 's/>//g'
