#!/bin/sh
###############################################################################
#* Copyright (c) 1998, Regents of the University of California
#* All rights reserved.
#* Redistribution and use in source and binary forms, with or without
#* modification, are permitted provided that the following conditions are met:
#*
#*     * Redistributions of source code must retain the above copyright
#*       notice, this list of conditions and the following disclaimer.
#*     * Redistributions in binary form must reproduce the above copyright
#*       notice, this list of conditions and the following disclaimer in the
#*       documentation and/or other materials provided with the distribution.
#*     * Neither the name of the University of California, Berkeley nor the
#*       names of its contributors may be used to endorse or promote products
#*       derived from this software without specific prior written permission.
#*
#* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS" AND ANY
#* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
#* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##################################################################################
set -e

declare -r FILE_DIR="./es_mon.conf"
function discovery_es_key(){	
	item=$1
    	eskeyarray=(`cat $FILE_DIR|grep $item`)
    	arraynum=${#eskeyarray[@]}

    	printf "{\n    \"data\":[\n"
    	for ((i=0;i<${arraynum};i++))
    	do
        	KEY=`echo ${eskeyarray[$i]}|awk -F \. '{print $1"."$2"."}'`
        	ARGV=`echo ${eskeyarray[$i]}|awk -F \. '{print $3}'`
        	printf '\n\t{'
       		printf "\"{#KEY}\":\"$KEY\",\"{#ARGV}\":\"$ARGV\"}"
        	if [ $i -lt $[${arraynum}-1] ]
		then
        		printf ','
        	fi
    	done
    	printf "\n    ]\n"
    	printf "}\n"
}

function main(){
	local item=$1
	discovery_es_key $item
}

main $@