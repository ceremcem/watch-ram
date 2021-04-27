#!/bin/bash
# Displays last log
(cd logs; ls  -1 | sort -r | head -n1 | xargs cat)
