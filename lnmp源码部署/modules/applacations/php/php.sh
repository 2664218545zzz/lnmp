#! /bin/bash
# 1.安装依赖
yum -y install libxml2-devel sqlite-devel  bzip2 bzip2-devel libcurl-devel readline-devel libpng-devel libjpeg-turbo-devel freetype-devel libzip-devel ncurses-compat-libs

yum -y install http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/oniguruma-devel-6.8.2-2.el8.x86_64.rpm

# 2.下载php8.2.9版本软件包,编译并安装
cd /usr/src &&\
tar xf php-8.2.9.tar.xz -C /usr/local/ &&\
cd /usr/local/php-8.2.9 &&\
./configure --prefix=/usr/local/php \
--with-config-file-path=/etc \
--enable-fpm \
--disable-debug \
--disable-rpath \
--enable-shared \
--enable-soap \
--with-openssl \
--enable-bcmath \
--with-iconv \
--with-bz2 \
--enable-calendar \
--with-curl \
--enable-exif \
-enable-ftp \
--enable-gd \
--with-jpeg \
--with-zlib-dir \
--with-freetype \
--with-gettext \
--enable-mbstring \
--enable-pdo \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-readline \
--enable-shmop \
--enable-simplexml \
--enable-sockets \
--with-zip \
--enable-mysqlnd-compression-support \
--with-pear \
--enable-pcntl \
--enable-posix &&\
make && make install &&\

# 3.配置php
echo 'export PATH=/usr/local/php/bin:$PATH' > /etc/profile.d/php.sh

cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm

chmod +x /etc/rc.d/init.d/php-fpm

cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf

cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf

# 编写service文件
cat > /usr/lib/systemd/system/php.service <<EOF
[Unit]
Description=php server daemon
After=network.target
[Service]
Type=forking
ExecStart=/etc/init.d/php-fpm start
ExecStop=/etc/init.d/php-fpm stop
ExecReload=/bin/kill -HUP $MAINPID
[Install]
WantedBy=multi-user.target
EOF
# 重新加载并启动服务
systemctl daemon-reload 
systemctl enable --now php-fpm















