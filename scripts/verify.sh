#!/usr/bin/env bash
(cd ./schema/auth/ && sqitch verify)
(cd ./schema/org/ && sqitch verify)