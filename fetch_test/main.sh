#!/bin/bash
echo "獲取清單中..."
curl -Ls http://invoice.etax.nat.gov.tw/ > source.html
cat source.html | sed 's/spanid/span id/g'  |  tidy -imq --show-errors 0 | grep 'class=".*">[0-9]*<' | sed 's/class=\".*\"//g;s/<h.*>//g;s/[^0-9]//g;5,$ s/\w/:/g;s/\ /:/g;/:/d;/^$/d;s/\ /:/;2 s/^/特別獎：/;3 s/^/特獎：/;4 s/^/增開陸獎：/' > fetch_exp_head
cat source.html | sed 's/spanid/span id/g'  |  tidy -imq --show-errors 0 | sed 's/、/ /g' | grep '".*">[0-9].*<' | grep 'span' | sed 's/class=\".*\"//g;s/\".*\"//g;s/<.*>//g;s/>//g;4,$ s/[0-9]//g;1,2 s/\ /:/g;4,$ s/\ /:/g;/:/d;s/^[\ ]*/:/g;s/:/頭獎：/;s/ /;/g'> fetch_head
cat ./fetch_head >> fetch_exp_head
mv fetch_exp_head fetch_result.txt
read -p "輸入發票末三碼：" last_three
echo "輸入的碼是：" ${last_three}
read -p "(y/n)" confirm
grep_res=$(grep "${last_three}" fetch_result.txt)
if [[ ${confirm} == 'y' ]] ; then
  if [[ ${grep_res} ]] ; then
    if [[ $(${grep_res} | sed 's/[0-9]//;s/://') ==  "增開陸獎" ]] ; then
      echo "增開陸獎"
      exit 0
    else
      read -p "輸入全部號碼：" all_code
      echo "輸入的碼是：" ${all_code}
      read -p "(y/n)" sec_confirm
      if [[ ${sec_confirm} == 'y' ]] ; then
        exit 0
      else
        exit 0
      fi
    fi
  fi
else
  echo "Exit..."
  exit 0
fi
