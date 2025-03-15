.PHONY: dockerBuild dockerRun dockerRm dockerShell dockerStartBook all all-interactive
dockerBuild:
	sudo docker build \
		--network=host \
		--build-arg USRNAME=$$(whoami) \
		--build-arg USR_UID=$$(id -u) \
		--build-arg USR_GID=$$(id -g) \
		--build-arg REPO_PATH=$$(pwd) \
		--build-arg HTTP_PROXY=$$http_proxy \
		--build-arg HTTPS_PROXY=$$https_proxy \
		-t rustintroimage .

# if you are under a proxy please set on ~/.docker/config.json to the address 127.0.0.1:3128
dockerRun:
	sudo docker run \
		-dit \
		-v $$(pwd):$$(pwd) \
		--network=host \
		--name rustintro \
		rustintroimage fish

# will start the webserver on localhost:3000
dockerStartBook:
	sudo docker run \
		-dit \
		-v $$(pwd):$$(pwd) \
		--network=host \
		--name rustintro \
		rustintroimage
	@echo ""
	@echo "############################################"
	@echo "webserver started on http://localhost:3000"
	@echo "############################################"

dockerRm:
	sudo docker rm -f rustintro

dockerShell:
	sudo docker exec -it rustintro fish

all: dockerRm dockerBuild dockerStartBook
all-interactive: dockerRm dockerBuild dockerRun dockerShell

.PHONY: bookStart
bookStart:
	mdbook serve

.PHONY: script
script:
	mkdir -p ~/bin
	curl -sSL https://github.com/rust-lang/mdBook/releases/download/v0.4.25/mdbook-v0.4.25-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=/home/$$USER/bin
	curl -sSL https://github.com/cognitive-engineering-lab/aquascope/releases/download/v0.3.4/aquascope-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=/home/$$USER/bin
