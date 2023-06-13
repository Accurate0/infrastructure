#!/bin/sh
flyctl machine update --metadata fly_platform_version=v2 "$FLY_MACHINE_ID" --yes
