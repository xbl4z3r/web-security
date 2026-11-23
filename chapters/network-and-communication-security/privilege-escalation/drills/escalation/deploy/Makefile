run: build
	docker run -d -it --platform=linux/amd64 --hostname=escalation -p 5555:1234 --name sss-web-09_escalation sss-web-09_escalation

build:
	docker build --platform linux/amd64 -f Dockerfile -t sss-web-09_escalation ..

stop:
	docker stop sss-web-09_escalation

clean: stop
	docker rm sss-web-09_escalation

.PHONY: build run stop clean
