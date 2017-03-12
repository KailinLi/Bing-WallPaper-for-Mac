# Bing-WallPaper-for-Mac

一键从Bing获取背景图片并设置为Mac壁纸的脚本

## Tips

感谢[Bing](https://www.bing.com)提供的壁纸和[xCss](https://bing.ioliu.cn)提供的接口。

## 使用

输入`./WallPaper.sh`即可更换当天Bing壁纸。

更多选项：

```shell
./WallPaper.sh -r 更换随机壁纸(或 --random)
./WallPaper.sh -n 选择壁纸编号(如 -5)
./WallPaper.sh -c 清理缓存(或 --clean)
./WallPaper.sh -h 更多帮助内容(或 --help)
```

如需使用定时自动更换壁纸功能，请自行查阅`crontab`的用法。

## 备注

（半小时 胡乱撸出来的代码，请随意喷（逃