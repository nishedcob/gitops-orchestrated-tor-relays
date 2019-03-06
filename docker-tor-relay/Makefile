
TAGGED_TEST_IMAGE="nishedcob/tor-relay:test"
CONTAINER_NAME="tor-relay"

dockerized: Dockerfile start.sh
	docker build -t $(TAGGED_TEST_IMAGE) .
	@touch $@

push: dockerized
	docker push $(TAGGED_TEST_IMAGE)
	@touch $@

run: dockerized
	@touch $@
	docker run --rm --name $(CONTAINER_NAME) $(TAGGED_TEST_IMAGE) || rm -v $@ || true

stop:
	(docker ps | grep $(CONTAINER_NAME) && docker stop $(CONTAINER_NAME) && sleep 10s) || (docker ps | grep $(CONTAINER_NAME) || true)
	@rm -v run || true

clean: stop
	docker rmi $(TAGGED_TEST_IMAGE) || true
	@rm -v run push dockerized || true
