#!/usr/bin/env bash

(cd ./schema/app-roles/ && sqitch deploy $1  && sqitch verify $1)
(cd ./schema/auth/ && sqitch deploy $1  && sqitch verify $1)
(cd ./schema/org/ && sqitch deploy $1  && sqitch verify $1)