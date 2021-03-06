#!/bin/bash

LIBS="-lm"
INCS=""
DEFS=""

if [[ $OS = *"Windows"* ]]; then
  LIBS="$LIBS -largp"
  DEFS="-D_GNU_SOURCE"
elif [[ `uname` = Darwin ]]; then
  if [ -f /opt/local/include/argp.h ]; then
    # MacPorts packages required: argp-standalone
    LIBS="$LIBS -L/opt/local/lib -largp"
    INCS="$INCS -I/opt/local/include"

    # (MacPorts md5sha1sum required for tests)
  else
    echo "argp not found - but will try building anyway"
  fi
else
  DEFS="-D_GNU_SOURCE"
fi

gcc -Wall -O3 -g $DEFS $INCS -o decode6502 src/main.c src/em_6502.c src/profiler.c src/profiler_instr.c src/profiler_block.c src/profiler_call.c src/tube_decode.c src/musl_tsearch.c $LIBS
