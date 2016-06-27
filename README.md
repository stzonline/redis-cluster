```
firewall-cmd --permanent --add-port={7001/tcp,7002/tcp,7003/tcp,7004/tcp,7005/tcp,7006/tcp}
firewall-cmd --reload

docker build -t redis/nodemodule:0.1.0 

./start.sh

cd /home/work/
wget http://download.redis.io/releases/redis-3.0.3.tar.gz
tar xvf redis-3.0.3.tar.gz
cd /home/work/redis-3.0.3
make MALLOC=libc
make install
cd /home/work/redis-3.0.3/src

ruby redis-trib.rb create 192.168.146.141:7001 192.168.146.141:7002 192.168.146.141:7003 192.168.146.141:7004 192.168.146.141:7005 192.168.146.141:7006
```