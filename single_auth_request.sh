#/bin/sh

curl -o /dev/null -s -w "%{http_code}\n" -L -X POST 'http://keycloak:8080/auth/realms/testRealm/protocol/openid-connect/token' -H 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'client_id=testClient' --data-urlencode 'grant_type=password' --data-urlencode 'scope=openid' --data-urlencode 'username=testUser' --data-urlencode 'password=passw0rd'
