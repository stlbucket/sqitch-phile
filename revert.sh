#!/usr/bin/env bash
(cd ./schema/org/ && sqitch revert)
(cd ./schema/auth/ && sqitch revert)
(cd ./schema/app-roles/ && sqitch revert)
