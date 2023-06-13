#!/bin/sh
flyctl secrets set PTA_REALTIME_API_KEY="$PTA_REALTIME_API_KEY" -a perthtransport-api
flyctl secrets set PTA_REFERENCE_DATA_API_KEY="$PTA_REFERENCE_DATA_API_KEY" -a perthtransport-api

flyctl secrets set PTA_REALTIME_API_KEY="$PTA_REALTIME_API_KEY" -a perthtransport-worker
flyctl secrets set PTA_REFERENCE_DATA_API_KEY="$PTA_REFERENCE_DATA_API_KEY" -a perthtransport-worker
