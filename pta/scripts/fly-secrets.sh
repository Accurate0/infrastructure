#!/bin/sh
flyctl secrets set PTA_REALTIME_API_KEY="$PTA_REALTIME_API_KEY" -a pta-api
flyctl secrets set PTA_REFERENCE_DATA_API_KEY="$PTA_REFERENCE_DATA_API_KEY" -a pta-api

flyctl secrets set PTA_REALTIME_API_KEY="$PTA_REALTIME_API_KEY" -a pta-worker
flyctl secrets set PTA_REFERENCE_DATA_API_KEY="$PTA_REFERENCE_DATA_API_KEY" -a pta-worker
