#! /bin/bash
# 1.五条命令直接部署完成mariadb10.5.9
yum -y install http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/mariadb-common-10.5.9-1.module_el8.5.0+732+7afc82e7.x86_64.rpm &&\
yum -y install http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/mariadb-connector-c-3.1.11-2.el8_3.x86_64.rpm &&\
yum -y install http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/mariadb-errmsg-10.5.9-1.module_el8.5.0+732+7afc82e7.x86_64.rpm &&\
yum -y install http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/mariadb-10.5.9-1.module_el8.5.0+732+7afc82e7.x86_64.rpm &&\
yum -y install http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/mariadb-server-10.5.9-1.module_el8.5.0+732+7afc82e7.x86_64.rpm &&\
systemctl enable --now mariadb
