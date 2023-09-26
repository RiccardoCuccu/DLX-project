#!/bin/bash

if [ ! -r $1 ]
then
	echo "Usage: $0 <dlx_assembly_file>.asm"
	exit 1
fi

asmfile=`echo $1 | sed s/[.].*//g | sed 's/asm_example\///'`
perl ./assembler.bin/dlxasm.pl -o $asmfile.bin -list $asmfile.list $1
rm $asmfile.bin.hdr
cat $asmfile.bin | hexdump -v -e '/1 "%02X" /1 "%02X" /1 "%02X" /1 "%02X\n"' > firmware.asm.mem
rm $asmfile.bin
rm $asmfile.list
