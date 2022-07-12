#!/bin/bash

cd /var/opt/metabase

sudo mv /home/useradmin/deploy.sh .
sudo mv /home/useradmin/lista_de_plugins .

sudo su - jenkins -c "cp /tmp/jenkins.war /home/jenkins"
sudo su - jenkins -c "nohup java -jar /home/jenkins/jenkins.war &"
sleep 120
sudo wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar
export JENKINS_API_TOKEN=`sudo su - jenkins -c "cat /home/jenkins/.jenkins/secrets/initialAdminPassword"`
export JENKINS_USER_ID=admin
resposta=`java -jar jenkins-cli.jar -s http://127.0.0.1:8080 who-am-i | grep authenticated | tr -d ' '`
autenticado="authenticated"
if [ "$resposta" = "$autenticado" ]
then
     echo "Jenkins instalado corretamente."
else
     echo "Jenkins nao foi instalado corretamente!"
     exit 1
fi
sudo sed -i s/NEW/RUNNING/ /home/jenkins/.jenkins/config.xml
sudo su - jenkins -c "echo 'false' > /home/jenkins/.jenkins/jenkins.install.runSetupWizard"
sudo su - jenkins -c "cp /home/jenkins/.jenkins/jenkins.install.UpgradeWizard.state /home/jenkins/.jenkins/jenkins.install.InstallUtil.lastExecVersion"
sudo su - jenkins -c "cp /home/useradmin/jenkins.model.JenkinsLocationConfiguration.xml /home/jenkins/.jenkins"
for i in `cat lista_de_plugins`
do
	java -jar jenkins-cli.jar -s http://127.0.0.1:8080 install-plugin $i -deploy
done
sudo su - jenkins -c "cp /home/useradmin/job.tar.gz /home/jenkins/.jenkins/jobs"
sudo su - jenkins -c "cd /home/jenkins/.jenkins/jobs && tar -zxvf job.tar.gz"
sudo su root -c "echo 'jenkins ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/jenkins"
sudo chown jenkins:jenkins deploy.sh
sudo chmod 755 deploy.sh
ps -ef | grep java | grep jenkins | awk '{print $2}' | xargs sudo kill -9
sudo su - jenkins -c "nohup java -jar /home/jenkins/jenkins.war &"
sudo cat /home/jenkins/.jenkins/secrets/initialAdminPassword
exit 0

