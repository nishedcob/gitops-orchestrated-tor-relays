
up:
	cd docker-tor-relay; make dockerized; cd ..
	docker-compose up

down:
	docker-compose down
	cd docker-tor-relay; make clean; cd ..

komposed: docker-compose.yaml
	kompose convert
	@mv -v torrelay*-*.yaml kubernetes/gitops/
	@touch $@
