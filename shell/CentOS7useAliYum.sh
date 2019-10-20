# 首先备份源镜像源
cd /etc/yum.repos.d
mv CentOS-Base.repo CentOS-Base.repo.bak

# 下载新镜像源并更改名称
wget http://mirrors.aliyun.com/repo/Centos-7.repo
mv Centos-7.repo CentOS-Base.repo

# 更新镜像源使其生效
yum clean all
yum makecache
yum update