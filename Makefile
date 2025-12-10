CPSB ?= /usr/bin/cpsb


	
make-all: 
	cd ./public/packages/; \
		for package in *.hb; do \
			$(CPSB) make $$package; \
		done

build:
	cd ./public/packages && $(CPSB) build 
	mv ./public/packages/index ./public/packages/index.b3 ./public/


clean: 
	cd ./public/packages && rm -f index *.clos *.b3 index.b3
	rm -f index index.b3

docker:
	bash ./docker.sh
