#!/usr/bin/env bash
(cd ./schema/app-roles/ && cp sqitch.conf.starter sqitch.conf)
(cd ./schema/auth/ && cp sqitch.conf.starter sqitch.conf)
(cd ./schema/org/ && cp sqitch.conf.starter sqitch.conf)