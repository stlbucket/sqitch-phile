#!/usr/bin/env bash
(cd ./schema/org/ && sqitch target add $1 $2)
(cd ./schema/auth/ && sqitch target add $1 $2)
(cd ./schema/app-roles/ && sqitch target add $1 $2)
