#!/bin/bash
[ -z "$1" ] && echo "usage: $0 [name]" && exit 1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

touch $1.swift
sed -i "/^.build\/debug\/\$(EXEC):/ s/$/ $1.swift/" $DIR/Makefile
