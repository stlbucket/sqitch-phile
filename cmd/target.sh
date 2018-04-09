#!/usr/bin/env bash
(cd ./schema/org/ && sqitch target add "$@")
(cd ./schema/auth/ && sqitch target add "$@")
(cd ./schema/app-roles/ && sqitch target add "$@")
