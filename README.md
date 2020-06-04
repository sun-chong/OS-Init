# 系统初始化脚本

![macOS Init](https://img.shields.io/badge/macOS-Init-brightgreen)
![Ubuntu Init](https://img.shields.io/badge/Ubuntu-Init-orange)

个人自用的macOS系统、Ubuntu系统初始化配置脚本。

主要用于折腾，其次用来更新记录基础hosts、基础开发环境配置、zsh配置以及自用软件清单等，再次用来初始化各系统。

## 使用脚本

```bash
chmod +x macOS-Init.sh #添加执行权限
./macOS-Init.sh #执行

chmod +x Ubuntu-Init.sh #添加执行权限
./Ubuntu-Init.sh #执行
```

## res文件

- [hosts](res/hosts)：备份基础hosts文件，用于追加到系统`hosts`。更完善的hosts可参考[googlehosts/hosts](https://github.com/googlehosts/hosts)、[HostsToolforMac](https://github.com/ZzzM/HostsToolforMac)，或通过[IPAddress](https://www.ipaddress.com/)查询。
- [zshrc](res/zshrc)：备份zsh配置文件，用于覆盖`.zshrc`。更详细的配置可参考[ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)。
- [iTerm2.json](res/iTerm2.json)：暂仅备份。

## macOS主要配置内容

- 更改默认的计算机名；
- 将`res/hosts`中备份的基础hosts配置，追加到系统`hosts`中；
- 安装Command Line Tools，及安装App Store中推荐的更新；
- 安装[Homebrew](https://github.com/Homebrew/brew)、brew软件包清单和[brew cask](https://github.com/Homebrew/homebrew-cask/)应用清单；
- 配置[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)，将`res/zshrc`中备份的配置文件覆盖`.zshrc`；
- 其他配置，pip安装插件及git基础配置。

## Ubuntu主要配置内容

- 更新系统及软件，清理无用软件
