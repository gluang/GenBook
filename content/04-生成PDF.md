# PDF 
生成的 PDF 电子书位于 `assets` 目录下。

```bash
$ make pdf 
# 如果有封面图，可使用 img=xxx 指定
$ make pdf img=images/cover.jpg
# 可以使用 name=xxx 指定生成的 pdf 文件名，默认为 book.pdf
$ make pdf name=mybook
```
