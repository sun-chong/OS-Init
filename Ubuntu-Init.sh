#!/bin/bash

# --------------------
# - Ubuntu个人装机配置 -
# --------------------

set -e
# set -x

#获取当前目录
readonly CUR_DIR="$(cd "$(dirname "$0")" && pwd)/res/"

#自定义信息输出函数
function cus_echo() {
    local CL_GREEN="42;30m" #$2 : 绿底黑字
    local CL_RED="41;37m"   #$2 : 红底白字
    local MSG=$1            #$1 : 信息内容
    if [ "$3" = "" ]; then  #$3 : 空:显示时间；fase:隐藏时间
        MSG="$(date "+%Y-%m-%d %H:%M:%S") -> $1"
    fi
    case $2 in
    g)
        echo -e "\033[$CL_GREEN$MSG\033[0m"
        ;;
    r)
        echo -e "\033[$CL_RED$MSG\033[0m"
        ;;
    *)
        echo "$MSG"
        ;;
    esac
}

#更改hostname函数
function hostname_change() {
    OLD_HOSTNAME="$(hostname)"
    NEW_HOSTNAME="$1"

    #临时变更hostname
    sudo hostname "$NEW_HOSTNAME"
    sudo hostnamectl set-hostname "$NEW_HOSTNAME"

    #永久变更hostname
    sudo sed -i "s/HOSTNAME=.*/HOSTNAME=$NEW_HOSTNAME/g" /etc/hostname
    # sudo sed -i "s/HOSTNAME=.*/HOSTNAME=$NEW_HOSTNAME/g" /etc/mailname

    if [ -n "$(grep "$OLD_HOSTNAME" /etc/hosts)" ]; then
        sudo sed -i "s/$OLD_HOSTNAME/$NEW_HOSTNAME/g" /etc/hosts
    fi
    echo "hostname已经修改为：$NEW_HOSTNAME"
}

cus_echo "Hello $(whoami), 需要输入密码：" r false

#执行更改hostname主机名
hostname_change "sunc-Ubuntu"
cus_echo "已更改计算机名" g

#更新hosts，将自定义hosts追加到系统hosts中
readonly HOST_NAME="hosts"
sudo sh -c "cat $CUR_DIR/$HOST_NAME >> /etc/hosts"
sudo systemd-resolve --flush-caches #清除Systemd Resolved DNS缓存
cus_echo "已更新hosts" g

#更新系统
sudo apt update
cus_echo "已更新Ubuntu系统" g

#卸载LibreOffice办公套件
sudo apt remove --purge libreoffice-common

#卸载火狐浏览器
sudo apt remove --purge firefox firefox-locale-en firefox-locale-zh-hans
rm -r ~/.mozilla/firefox/*.default/ #删除火狐缓存

#卸载Ubuntu内置游戏：数独、对对碰、扫雷、纸牌
sudo apt remove --purge gnome-sudoku gnome-mahjongg gnome-mines aisleriot

cus_echo "已卸载系统内无用的内置软件" g

#更新所有软件
sudo apt upgrade
cus_echo "已更新所有软件" g

#清理apt软件包
sudo apt autoremove && sudo apt-get autoclean

#更改Ubuntu系统设置
sudo add-apt-repository multiverse                         #增加第三方自由库的软件支持
gsettings set org.gnome.desktop.interface scaling-factor 2 #设置高分屏适配，200%缩放，重启生效

cus_echo "已更改Ubuntu部分系统设置" g

#安装apt软件清单
sudo apt install ubuntu-restricted-extras #安装媒体编解码器扩展包
sudo apt install figlet                   #安装FIGlet，终端Ascii Art
sudo apt install toilet                   #安装TOIlet，FIGlet颜色扩展
cus_echo "已完成安装apt软件清单" g

#安装自定义软件清单
cd ~/下载/ #进入Ubuntu下载目录进行下载安装

#安装Chrome浏览器
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

#安装Firefly萤火虫代理
wget https://github.com/yinghuocho/download/blob/master/firefly_linux_amd64_install.deb?raw=true
sudo dpkg -i firefly_linux_amd64_install.deb
rm firefly_linux_amd64_install.deb

sudo apt-get -f install
cus_echo "已完成安装自定义软件清单" g

toilet -kf standard -F gay "Ubuntu - Init"
cus_echo "全部运行完毕，HiDPI需重启后生效。" r
