FROM docker.io/ubuntu

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y apache2 libcap2-bin
ADD index.html /var/www/html/index.html
RUN setcap cap_net_bind_service=+epi /usr/sbin/apache2
RUN mkdir /var/run/apache2
RUN chgrp -R 0 /var/www/html && \
    chmod -R g=u /var/www/html
RUN chgrp -R 0 /var/locks && \
    chmod -R g=u /var/locks
RUN chgrp -R 0 && /var/run/apache2 && \
    chmod -R g=u /var/run/apache2

EXPOSE 80

CMD []

ENTRYPOINT ["apachectl", "-DFOREGROUND"]
