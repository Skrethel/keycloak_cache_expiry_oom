#!/bin/ash

RETRIES=${RETRIES_COUNT:-10}
CHECK=0;
echo "Waiting for Keycloak-Instance to start..."
until [ "$CHECK" != 0 ]; do
    STATUSCODE=$(curl -o /dev/null -s -w "%{http_code}" -L -X POST 'http://keycloak:8080/auth/realms/testRealm/protocol/openid-connect/token' -H 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'client_id=testClient' --data-urlencode 'grant_type=password' --data-urlencode 'scope=openid' --data-urlencode 'username=testUser' --data-urlencode 'password=passw0rd')
	echo "HTTP-Response: $STATUSCODE - $RETRIES"
    if [ "$STATUSCODE" == 200 ]; then
	     let "CHECK=1"
	else
		if [ $RETRIES -gt 0 ]; then
			 let "RETRIES-=1"
			 echo "Keycloak-Instances are not ready. ${RETRIES} attempts left. Retry in 10 seconds..."
			 sleep 10
		else
			 echo "Failed to connect to Keycloak-Instances"
			 exit 1
		fi
	fi
	echo "Keycloak-Instances are up and ready"
done

STATUSCODE=200
REQUEST_NUMBER=1
echo "start generating login requests"
while true
do
  STATUSCODE=$(curl -o /dev/null -s -w "%{http_code}" -L -X POST 'http://keycloak:8080/auth/realms/testRealm/protocol/openid-connect/token' -H 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'client_id=testClient' --data-urlencode 'grant_type=password' --data-urlencode 'scope=openid' --data-urlencode 'username=testUser' --data-urlencode 'password=passw0rd')
  echo "Login #$REQUEST_NUMBER HTTP-Response: $STATUSCODE"
  REQUEST_NUMBER=$((REQUEST_NUMBER+1))
done
sleep 3600