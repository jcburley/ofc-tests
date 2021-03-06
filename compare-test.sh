#!/bin/bash

usage() { echo "Usage: $0 [OFC_PATH] [FORTRAN_SOURCE_PATH]" 1>&2; exit 1; }

[ $# -eq 2 ] || usage
[ -e "$2"  ] || { echo "File not found: $2"; usage; }

MKTEMP=tempfile
which mktemp &> /dev/null && MKTEMP=mktemp

TGFOR=$($MKTEMP)
TREFOR=$($MKTEMP)
TAOUT=$($MKTEMP)
chmod +x $TAOUT &> /dev/null

FRONTEND=$1

SRC_PATH=$(realpath $2)
SRC_NAME=$(basename $SRC_PATH)
SRC_DIR=$(dirname $SRC_PATH)

INC_DIR=$SRC_DIR/include/

STDIN_NAME=$SRC_DIR/stdin/$SRC_NAME
STDOUT_NAME=$SRC_DIR/stdout/$SRC_NAME

## Compile directly with gfortran
if [ -f $STDOUT_NAME ]
then
	cp $STDOUT_NAME $TGFOR
else
	gfortran -I $INC_DIR $SRC_PATH -o $TAOUT &> /dev/null
	if [ $? -eq 0 ]
	then
		pushd $(dirname $TAOUT)
		rm -f fort.*
		if [ -f $STDIN_NAME ]
		then
			cat $STDIN_NAME | $TAOUT > $TGFOR
		else
			$TAOUT > $TGFOR
		fi
		popd
		rm $TAOUT &> /dev/null
	else
		rm $TAOUT &> /dev/null
		rm $TGFOR &> /dev/null
		rm $TREFOR &> /dev/null
		exit 1
	fi
fi

## Compile with gfortran OFC output
$FRONTEND --sema-tree --include $INC_DIR $SRC_PATH 2> /dev/null | gfortran -x f77 - -o $TAOUT &> /dev/null
if [ $? -eq 0 ]
then
	pushd $(dirname $TAOUT)
	rm -f fort.*
	if [ -f $STDIN_NAME ]
	then
		cat $STDIN_NAME | $TAOUT > $TREFOR
	else
		$TAOUT > $TREFOR
	fi
	popd
	rm $TAOUT &> /dev/null
else
	rm $TGFOR &> /dev/null
	rm $TREFOR &> /dev/null
	exit 1
fi

diff $TGFOR $TREFOR &> /dev/null
if [ $? -eq 0 ]
then
	rm $TGFOR &> /dev/null
	rm $TREFOR &> /dev/null
	exit 0
fi

rm $TGFOR &> /dev/null
rm $TREFOR &> /dev/null
exit 1
