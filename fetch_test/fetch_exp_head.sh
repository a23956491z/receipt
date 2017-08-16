#!/bin/bash
curl -Ls http://invoice.etax.nat.gov.tw/ | sed 's/spanid/span id/g'  |  tidy -imq --show-errors 0 | grep 'class=".*">[0-9]*<' | sed 's/class=\".*\"//g' | sed 's/<h.*>//g' | sed 's/[^0-9]//g'
