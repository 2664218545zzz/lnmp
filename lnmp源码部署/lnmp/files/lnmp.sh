#! /bin/bash
# 1.写入php页面
cat > /usr/local/nginx/html/index.php <<EOF
<?php
   phpinfo();
?>
EOF

# 2.启动nginx服务并设置开机自启
systemctl restart php-fpm
systemctl restart nginx
