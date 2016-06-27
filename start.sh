#!/bin/bash

#firewall-cmd --permanent --add-port={7001/tcp,7002/tcp,7003/tcp,7004/tcp,7005/tcp,7006/tcp}
#firewall-cmd --reload
#netstat -nltp
#ruby redis-trib.rb create 192.168.146.141:7001 192.168.146.141:7002 192.168.146.141:7003 192.168.146.141:7004 192.168.146.141:7005 192.168.146.141:7006

# the default node number is 3
#N=${1:-3}
N=${1:-6}


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	p=$(( $i + 7000 ))
	sudo docker rm -f redisNode$i &> /dev/null
	echo "start redisNode$i container..."
	sudo docker run -d --name redisNode$i --net=host -v /root/redissoft/$p/data:/root/redissoft/$p/data  redis/nodemodule:0.1.0   /bin/sh -c "redis-server /root/config/$p/redis.conf"
	i=$(( $i + 1 ))
done 

# get into hadoop master container
#sudo docker exec -it master bash
