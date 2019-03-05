
dockerized: Dockerfile start.sh
	docker build -t nishedcob/tor-relay:test .
	@touch $@

run: dockerized
	@touch $@
	docker run --rm --name tor-relay nishedcob/tor-relay:test || rm -v $@ || true

stop:
	(docker ps | grep "tor-relay" && docker stop tor-relay && sleep 10s) || (docker ps | grep "tor-relay" || true)
	@rm -v run || true

clean: stop
	docker rmi nishedcob/tor-relay:test || true
	@rm -v run dockerized || true
