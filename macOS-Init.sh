#!/bin/bash

# -------------------
# - macOS个人装机配置 -
# -------------------

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

cus_echo "Hello $(whoami), 需要输入密码：" r false

#更改计算机名
sudo scutil --set LocalHostName sunc-MBP
cus_echo "已更改计算机名" g

#更新hosts，将自定义hosts追加到系统hosts中
readonly HOST_NAME="hosts"
sudo sh -c "cat $CUR_DIR/$HOST_NAME >> /etc/hosts"
sudo dscacheutil -flushcache
cus_echo "已更新hosts" g

#安装Command Line Tools
xcode-select --install

#安装App Store推荐的更新
sudo softwareupdate -ir
cus_echo "已更新App Store应用" g

#默认终端切换到zsh
HAVE_ZSH=$(cat /etc/shells | grep /bin/zsh)
if [ "$HAVE_ZSH" == "/bin/zsh" ]; then
    chsh -s /bin/zsh
fi

#安装Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
cus_echo "已安装Homebrew" g

brew install dotnet     #安装.NET Core
brew install python     #安装Python最新版
brew install zsh        #安装zsh最新版
brew install git        #安装git最新版
brew install hub        #安装hub命令
brew install shellcheck #安装ShellCheck
brew install tree       #安装tree命令
cus_echo "已完成安装brew软件包清单" g
brew cleanup

# hub api user            #设置hub命令的OAuth认证，需输入GitHub帐号密码
# eval "$(hub alias -s)"  #设置hub命令git别名

#安装Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#安装zsh-syntax-highlighting高亮插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#安装zsh-autosuggestions自动提示插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#更新zsh配置文件（备份配置中已包含环境变量）
readonly ZSHRC_NAME="zshrc"
cat "$CUR_DIR/$ZSHRC_NAME" >~/.zshrc

cus_echo "已完成配置Oh My Zsh" g

#安装应用
brew cask install visual-studio-code #安装vscode
brew cask install tencent-lemon      #安装Lemon
brew cask install sogouinput         #安装搜狗输入法
brew cask install baidunetdisk       #安装百度网盘
brew cask install sunlogincontrol    #安装向日葵控制端
brew cask install iina               #安装IINA视频播放器
brew cask install itsycal            #安装Itsycal日历
brew cask install motrix             #安装Motrix下载器
brew cask install iterm2             #安装iTerm2终端
brew cask install kite               #安装Kite，Python语法提示
brew cask install virtualbox         #安装VirtualBox虚拟机
# brew cask install google-chrome      #安装Chrome
# brew install vitorgalvao/tiny-scripts/cask-repair #安装cask提交更新脚本
cus_echo "已完成安装brew cask应用清单" g

#Python插件
pip3 install flake8
pip3 install yapf

#Git基础配置
git config --global color.ui auto
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto

cus_echo "全部运行完毕" r
say Init is complete
