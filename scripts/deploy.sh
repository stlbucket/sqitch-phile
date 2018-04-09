#!/usr/bin/env bash
(cd ./schema/auth/ && sqitch deploy)
(cd ./schema/org/ && sqitch deploy)