---Web application for the Project GESTION_DE_SOIREE

1- unzip apache-tomcat-9.0.40.zip
2- chmod 700 apache-tomcat-9.0.40/bin/*.sh
3- cp Gestion_De_Soiree.war apache-tomcat-9.0.40/webapps/
4- run the server ./apache-tomcat-9.0.40/bin/startup.sh
5- creer une BD soiree |
   Creer user "user" (
   sql:"CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';"
   sql:"GRANT ALL PRIVILEGES ON * . * TO 'user'@'localhost';"
   )
   **lancer les scripte de creation et de peuplement sur la bd soiree
6- http://localhost:8080/Gestion_De_Soiree/login.jsp    //8080 est le port utilise par tomcat par defaut (vous pouvez le changer si vous voulez)

7-apres navigation arretez le serveur ./apache-tomcat-9.0.40/bin/shutdown.sh