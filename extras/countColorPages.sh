#!/bin/sh

gs -o - -sDEVICE=inkcov $1 | sed '/^Page*/N;s/\n//'|sed -E '/Page [0-9]+ 0.00000  0.00000  0.00000  / d'|tail -n +4
