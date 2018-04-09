#!/usr/bin/env bash
(cd ./schema/org/ && sqitch engine add pg "$@")
(cd ./schema/auth/ && sqitch engine add pg "$@")
(cd ./schema/app-roles/ && sqitch engine add pg "$@")
