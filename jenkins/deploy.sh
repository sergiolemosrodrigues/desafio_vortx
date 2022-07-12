export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
cd /var/opt/metabase
sudo rm metabase.jar
ps -ef | grep java | grep metabase | awk '{print $2}' | xargs sudo kill -9
sudo wget --quiet https://downloads.metabase.com/v0.35.4/metabase.jar
sudo nohup java -jar metabase.jar &
