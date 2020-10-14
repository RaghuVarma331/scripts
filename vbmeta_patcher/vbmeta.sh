#!/bin/sh

infile=vbmeta.img
outfile=vbmeta-new.img
dd if=$infile of=$outfile count=1 bs=123
echo -ne '\x02' >> $outfile
dd if=$infile of=$outfile oflag=append skip=1 ibs=124 seek=1 obs=124
