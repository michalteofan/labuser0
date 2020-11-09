FROM docker.io/ubuntu

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y apache2 
ADD index.html /var/www/html/index.html

EXPOSE 80

CMD []

ENTRYPOINT ["apachectl", "-DFOREGROUND"]
