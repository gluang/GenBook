# 项目结构

```
.
├── .git
├── assets      // 存放生成的 pdf 文件
├── content     // 存放 markdown 文件
├── docs        // 存放 web 静态资源文件
├── font        // 打印 pdf 所需字体
├── images      // 存放图片
├── .bookignore
├── .gitignore
├── Dockerfile  // Docker 构建文件
├── LICENSE
├── Makefile    // 指令
├── README.md   // 项目简介
├── SUMMARY.md  // 项目目录
├── book.json   // pdf 配置文件
└── cover.jpg   // pdf 封面图
```

# 查看帮助

```
$ make help
Usage:
  image          构建镜像
  container      构建容器
  html           生成静态文件
  pdf            生成 PDF，如果需要转换封面尺寸，请使用 img=xxx 指定图片
  serve          启动本地 web 服务，监听 4000 端口
  clean          删除命令 html pdf serve 生成的中间物
  rm-container   删除容器
  rm-image       删除镜像
  rm             删除容器和镜像
  help           打印命令帮助信息
```

# 生成电子书

```bash
$ make image
$ make container

$ make html

$ make pdf 
# 可使用 img=xxx 指定需要封面图
$ make pdf img=images/cover.jpg
# 使用 name=xxx 指定生成 pdf 文件名，默认为 book.pdf
$ make pdf img=images/cover.jpg name=mybook

$ make serve
# 浏览器访问 ip:4000

$ make rm
```

# 封面图
* [O’RLY 动物书封面](https://github.com/nanmu42/orly)

# TODO
- [ ] 将静态资源文件打包，构建可执行文件
- [ ] 时区问题以及查看生成的 PDF 文件时间是否有更新
