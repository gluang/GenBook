## image: 构建镜像
.PHONY: image
image:
	@echo " 🐋\033[3m\033[96m build image \033[0m"
	@docker build -t gluang/gitbook .
	@echo " 🎉\033[3m\033[96m build image successfully \033[0m"

## container: 构建容器
.PHONY: container
container:
	@echo " 🐋\033[3m\033[96m build container \033[0m"
	@docker run -itd \
		-v ${PWD}:/srv/gitbook \
		-v ${PWD}/docs:/srv/html \
		-p 4000:4000 \
		--name gitbook-example \
		gluang/gitbook:latest bash
	@echo " 🎉\033[3m\033[96m build container successfully \033[0m"

## html: 生成静态文件
.PHONY: html
html:
	@mkdir -p docs
	@docker exec -it gitbook-example gitbook build . /srv/html
	@echo " ✔️\033[3m\033[96m generate html successfully \033[0m"

## pdf: 生成 PDF
.PHONY: pdf
pdf:
	@mkdir -p assets
ifneq ($(strip $(img)),) # 如果提供的 img 参数不为空，则执行转换
	@echo " 🔥\033[96m 将 ${img} 尺寸修改为 1800x2360 \033[0m"
	@docker exec -it gitbook-example convert -resize 1800x2360! $(img) cover.jpg
endif
ifneq ($(strip $(name)),)
	@docker exec -it gitbook-example /usr/local/bin/gitbook pdf . assets/$(name).pdf
	@echo " ✔️\033[3m\033[96m generate assets/$(name).pdf successfully \033[0m"
else
	@docker exec -it gitbook-example /usr/local/bin/gitbook pdf . assets/book.pdf
	@echo " ✔️\033[3m\033[96m generate assets/book.pdf successfully \033[0m"
endif

## serve: 启动本地 web 服务，监听 4000 端口
.PHONY: serve
serve:
	@docker exec -it gitbook-example /usr/local/bin/gitbook serve \
		|| echo "\n ✔️\033[3m\033[92m close service successfully \033[0m"

## clean: 删除命令 html pdf serve 生成的中间物
.PHONY: clean
clean:
	@rm -rf _book assets/* docs/* \
		&& echo " ✔️\033[3m\033[92m clean successfully \033[0m" \
		|| echo " ❌\033[3m\033[91m clean failed \033[0m" \

## rm-container: 删除容器
.PHONY: rm-container
rm-container:
	@docker stop gitbook-example
	@docker rm -f gitbook-example
	@echo " 🐋\033[3m\033[96m remove container successfully \033[0m"

## rm-image: 删除镜像
.PHONY: rm-image
rm-image:
	@docker rmi -f gluang/gitbook
	@echo " 🐋\033[3m\033[96m remove image successfully \033[0m"

## rm: 删除容器和镜像
.PHONY: rm
rm: rm-container rm-image

## help: 打印命令帮助信息
.PHONY: help
help:
	@echo "Usage:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
