img ?=itaru2622/nodered-mcp:trixie
base ?=itaru2622/mcp:trixie
cName ?=mcp-nodered

wDir ?=${PWD}


dind  ?=true
ifneq ($(dind),true)
# case1) ordinal mode (dind != true)
cmd     ?=/bin/bash
dOpts   ?=-t --rm 
dnsOpts ?=
# case1 end
else
# case2) docker in docker mode (dind == true)
cmd     ?=/lib/systemd/systemd
dOpts   ?=-d --privileged
dnsOpts ?=-v /etc/resolv.conf:/etc/resolv.conf:ro
# case2 end
endif

build:
	docker build \
	--build-arg base=${base} \
	-t ${img} .

start:
	docker run --name ${cName} \
	-p 1880:1880 \
	-i ${dOpts} ${dnsOpts} \
	-v ${wDir}:${wDir} -w ${wDir} \
	${img} ${cmd}

stop:
	docker rm -f ${cName} 

bash:
	docker exec -it ${cName} /bin/bash
