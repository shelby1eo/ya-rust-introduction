
.PHONY: dockerBuild dockerRun dockerRm dockerShell all
dockerBuild:
	sudo docker build \
		--build-arg USRNAME=$$(whoami) \
		--build-arg USR_UID=$$(id -u) \
		--build-arg USR_GID=$$(id -g) \
		--build-arg REPO_PATH=$$(pwd) \
		-t rustintroimage .

dockerRun:
	sudo docker run \
		-dit \
		-v $$(pwd):$$(pwd) \
		--name rustintro \
		rustintroimage

dockerRm:
	sudo docker rm -f rustintro

dockerShell:
	sudo docker exec -it rustintro fish

all: dockerRm dockerBuild dockerRun dockerShell
