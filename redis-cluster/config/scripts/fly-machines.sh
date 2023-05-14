#!/bin/sh
flyctl machine update --metadata fly_platform_version=v2 "$FLY_MACHINE_ID_SYD" --yes
flyctl machine update --metadata fly_platform_version=v2 "$FLY_MACHINE_ID_SIN" --yes
