#!/bin/bash
#一舉將變數設定到陣列中
array=(Redhat Novell MicroSoft Sun IBM HP Dell)

#利用for loop將陣列中的變數印出
for i in 0 1 2 3 4 5 6
do
echo "array[$i]=${array[$i]}"
done

#設定間隔符號為: 搭配$*將陣列的值一口氣輸出
IFS=:
echo "${array[*]}"

#設定間隔符號為換行,搭配$*將陣列的值一口氣輸出
IFS=$'\n'
echo "${array[*]}"

#將陣列中的值利用$@一口氣輸出與$*不同的是,不會將值合併成單一字串
echo "${array[@]}"

#印出陣列中有幾筆資料
echo "${#array[@]}"

