#!/usr/bin/env bash

(cd ./schema/app-roles/ && sqitch deploy "$@")
(cd ./schema/auth/ && sqitch deploy "$@")
(cd ./schema/org/ && sqitch deploy "$@")