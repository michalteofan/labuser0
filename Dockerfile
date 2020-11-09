FROM docker.io/ubuntu

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y apache2
ADD index.html /var/www/html/index.html
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf
RUN sed -i 's/apache2$SUFFIX/apache2/g' /etc/apache2/envvars
RUN mkdir /var/run/apache2
RUN chgrp -R 0 /var/www/html && \
    chmod -R g=u /var/www/html
RUN chgrp -R 0 /var/lock && \
    chmod -R g=u /var/lock
RUN chgrp -R 0 /var/run/apache2 && \
    chmod -R g=u /var/run/apache2
RUN chgrp -R 0 /var/log/apache2 && \
    chmod -R g=u /var/log/apache2

EXPOSE 8080

CMD []

ENTRYPOINT ["apache2ctl", "-DFOREGROUND"]
