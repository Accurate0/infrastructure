#!/bin/sh
fly machine update --metadata fly_platform_version=v2 "$FLY_MACHINE_ID_SYD" --yes
fly machine update --metadata fly_platform_version=v2 "$FLY_MACHINE_ID_SYD_2" --yes
fly machine update --metadata fly_platform_version=v2 "$FLY_MACHINE_ID_SIN" --yes
