#!/usr/bin/env bash
(cd ./schema/app-roles/ && sqitch verify)
(cd ./schema/auth/ && sqitch verify)
(cd ./schema/org/ && sqitch verify)