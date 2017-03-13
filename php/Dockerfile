FROM centos:7
# docker build -t 123.206.77.131:5000/php:latest .
# docker run --privileged -d --name php --volumes-from src -p 9999:9000 123.206.77.131:5000/php
MAINTAINER gongyousan@jikexueyuan.com

RUN yum -y update \
    && yum -y install \
        gcc \
        gcc-c++ \
        automake \
        autoconf \
        libtool \
        make \
        libjpeg \
        libjpeg-devel \
        libpng \
        libpng-devel \
        freetype \
        freetype-devel \
        libxml2 \
        libxml2-devel \
        zlib \
        zlib-devel \
        glibc \
        glibc-devel \
        glib2 \
        glib2-devel \
        bzip2 \
        bzip2-devel \
        ncurses \
        ncurses-devel \
        curl \
        curl-devel \
        e2fsprogs \
        e2fsprogs-devel \
        krb5 \
        krb5-devel \
        libidn \
        libidn-devel \
        openssl \
        openssl-devel \
        openldap \
        openldap-devel \
        nss_ldap \
        openldap-clients \
        openldap-servers \
    && yum clean all
ADD libiconv-1.7.tar.gz /service/install
ADD libxml2-2.7.2.tar.gz /service/install
ADD libmcrypt-2.5.7.tar.gz /service/install

RUN cd /service/install/libiconv-1.7 && \
    ./configure --prefix=/service/webserver/libiconv && \
    make && \
    make install && \
    make clean && \
    \
    cd /service/install/libxml2-2.7.2 && \
    ./configure --prefix=/service/webserver/libxml2 && \
    make && \
    make install && \
    make clean && \
    \
    cd /service/install/libmcrypt-2.5.7 && \
    ./configure --prefix=/service/webserver/libmcrypt && \
    make && \
    make install && \
    make clean && \
    \
    ln -s /usr/lib64/libjpeg.so /usr/lib/ && \
    ln -s /usr/lib64/libpng.so  /usr/lib/ && \
    ln -s /usr/lib64/libldap.so  /usr/lib/ && \
    ln -s /service/webserver/libiconv/lib/lib* /usr/lib64/ && \
    ln -s /usr/lib64/liblber* /usr/lib

ADD php-5.6.6.tar.gz /service/install

RUN groupadd -g 65530 www \
    && adduser -g 65530 -u 65530 www \
    && cd /service/install/php-5.6.6/ && \
    ./configure \
        --prefix=/service/webserver/php5.6.6 \
        --with-config-file-path=/service/webserver/php5.6.6/etc \
        --with-mysql=mysqlnd \
        --with-mysqli=mysqlnd \
        --with-iconv-dir=/service/webserver/libiconv/ \
        --with-freetype-dir \
        --with-jpeg-dir \
        --with-png-dir \
        --with-libxml-dir=/service/webserver/libxml2/ \
        --enable-xml \
        --disable-rpath \
        --enable-safe-mode \
        --enable-bcmath \
        --enable-shmop \
        --enable-sysvsem \
        --enable-inline-optimization \
        --with-curl \
        --enable-mbregex \
        --enable-fpm \
        --with-fpm-user=www \
        --with-fpm-group=www \
        --enable-force-cgi-redirect \
        --enable-mbstring \
        --with-mcrypt=/service/webserver/libmcrypt/ \
        --with-gd \
        --enable-gd-native-ttf \
        --with-openssl \
        --with-mhash \
        --enable-pcntl \
        --enable-sockets \
        --with-ldap \
        --with-ldap-sasl \
        --with-xmlrpc \
        --enable-soap \
        --enable-pdo \
        --enable-opcache=no \
        --with-pdo-mysql=mysqlnd && \
    make && \
    make install && \
    make clean && \
    ln -s /service/webserver/php5.6.6/bin/* /usr/local/bin/ && \
    ln -s /service/webserver/php5.6.6/sbin/* /usr/local/sbin/ && \
    rm -fr /service/install && \
    mkdir -p /service/webserver/php5.6.6/var/tmp && \
    chmod 777 /service/webserver/php5.6.6/var/tmp

ADD no-debug-non-zts-20131226/. /service/webserver/php5.6.6/lib/php/extensions/no-debug-non-zts-20131226/
ADD etc/. /service/webserver/php5.6.6/etc/

RUN mkdir -p /datas/wwwroot \
    && chown -R www:www /datas/wwwroot/

EXPOSE 9000

ENTRYPOINT ["/usr/local/sbin/php-fpm", "-F", "-c", "/service/webserver/php5.6.6/etc/php.ini", "-y", "/service/webserver/php5.6.6/etc/php-fpm.conf"]