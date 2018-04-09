#!/usr/bin/env bash
postgraphile -c postgres://localhost/phile -s auth,org -a -j -M