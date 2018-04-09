#!/usr/bin/env bash
(cd ./schema/org/ && sqitch tag $1 $2 $3)
(cd ./schema/auth/ && sqitch tag $1 $2 $3)
(cd ./schema/app-roles/ && sqitch tag $1 $2 $3)
git commit -am $3
git tag $1 -am $3

