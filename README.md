# keycloak_cache_expiry_oom
Demonstrates that cache items like sessions are never garbage collected, see https://issues.redhat.com/browse/KEYCLOAK-18518

# This version is adapated to show that standalone mode (non HA) also has memory leak.

## Usage
Start dockers.

`docker-compose up`

Once dockers are started, query keycloak metrics to observe that Old Gen constantly increases.

`curl -sS localhost:9991/metrics | grep vendor_memoryPool_usage_bytes | grep "G1 Old Gen"`
