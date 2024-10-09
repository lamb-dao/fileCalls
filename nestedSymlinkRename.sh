#!/bin/bash

#creates sym links in target dir

source="/home/holdens/holdensQNAP/LIBS/gbs_snp/cassetteGBS/morex/2019" #no trailing /
dirType="filterOP_*"
f="thin.vcf"
target="$(pwd)/input"
year="2019" #used for name creation

for d in  ${source}/${dirType}
do
  echo "Enter: ${d}"
  (cd "${d}" || exit

   echo "Build name for: ${f}"
   n=$(basename ${d})
   echo ${n}
   n=$(echo ${n} | sed s:NS.*${year}:${year}:g ) # from NS to  year replace with year
   echo ${n}
   digit=$(echo ${n} | grep -o "_[0-9]*$" | sed s:_::g )   # get digit
   echo "digit: ${digit}"
   n=$(echo ${n} | sed s:${year}_[[:digit:]]*$:${year}_P${digit}:g) # &&&replace _{num} _P{num}
   echo ${n}
   n=$(echo ${n} | sed s:OP::g ) # drop OP
   n=$(echo ${n} | sed s:_::g ) # drop underscores
   n+=".vcf" #append filetype
   echo ${n}

   ln -ifs ${d}/${f} ${target}/${n} && echo "Created renamed links in ${target}"
   echo ""
  )
done

exit 0
