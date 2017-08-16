#!/bin/bash
echo "獲取清單中..."
curl -Ls http://invoice.etax.nat.gov.tw/ | sed 's/spanid/span id/g'  |  tidy -imq --show-errors 0 | grep 'class=".*">[0-9]*<' | sed 's/class=\".*\"//g' | sed 's/<h.*>//g' | sed 's/[^0-9]//g' | sed '5,$ s/\w//g' > fetch_exp_head
curl -Ls http://invoice.etax.nat.gov.tw/ | sed 's/spanid/span id/g'  |  tidy -imq --show-errors 0 | sed 's/、/ /g' | grep '".*">[0-9].*<' | grep 'span' | sed 's/class=\".*\"//g' | sed 's/\".*\"//g' | sed 's/<.*>//g' | sed 's/>//g' | sed '4,$ s/[0-9]//g' > fetch_head
cat ./fetch_head >> fetch_exp_head
mv fetch_exp_head fetch_result.txt
read -p "輸入發票末三碼：" last_three
echo "輸入的碼是：" ${last_three}
read -p "(y/n)" confirm
grep_res=$(grep "${last_three}" fetch_result.txt)
if [[ ${confirm} == 'y' ]] ; then
  if [[ ${grep_res} ]] ; then
    if [[ $(printf "%d" ${#grep_res}) ==  '3' ]] ; then
      echo "增開陸獎"
      exit 0
    else
      read -p "輸入全部號碼：" all_code
      echo "輸入的碼是：" ${all_code}
      read -p "(y/n)" sec_confirm
      if [[ ${sec_confirm} == 'y' ]] ; then
      else
        exit 0
      fi
    fi
  fi
else
  echo "Exit..."
  exit 0
fi
