#!/usr/bin/env bash
(cd ./schema/org/ && sqitch engine add pg $1)
(cd ./schema/auth/ && sqitch engine add pg $1)
(cd ./schema/app-roles/ && sqitch engine add pg $1)
