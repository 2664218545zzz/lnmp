#! /bin/bash
# 1.创建nginx用户
useradd -r -M -s /sbin/nologin nginx

# 2.安装依赖环境
yum -y install pcre-devel openssl openssl-devel gd-devel gcc gcc-c++ make &&\

# 3.创建日志存放目录
mkdir -p /var/log/nginx
chown -R nginx.nginx /var/log/nginx

# 4.下载nginx源码包
cd /usr/src &&\
	tar xf nginx-1.22.1.tar.gz -C /usr/local/ &&\
cd /usr/local/nginx-1.22.1 &&\
./configure \
--prefix=/usr/local/nginx \
--user=nginx \
--group=nginx \
--with-debug \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_image_filter_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--http-log-path=/var/log/nginx/access.log \
--error-log-path=/var/log/nginx/error.log &&\
make -j $(grep 'processor' /proc/cpuinfo | wc -l) && make install

# 5.配置nginx
# 配置环境变量
echo 'export PATH=/usr/local/nginx/sbin:$PATH' > /etc/profile.d/nginx.sh

# 6.编写service文件
cat > /usr/lib/systemd/system/nginx.service << EOF
[Unit]
Description=nginx server daemon
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/nginx/sbin/nginx
ExecStop=/usr/local/nginx/sbin/nginx -s stop
ExecReload=/usr/local/nginx/sbin/nginx -s reload
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
EOF

# 7.刷新服务，启动nginx服务并设置开机自启
systemctl daemon-reload
systemctl enable --now nginx

