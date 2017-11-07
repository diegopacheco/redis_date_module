DEBUGFLAGS = -g -ggdb -O2
ifeq ($(DEBUG), 1)
	DEBUGFLAGS = -g -ggdb -O0
endif

# find the OS
uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
CPPFLAGS =  -Wall -Wno-unused-function $(DEBUGFLAGS) -fPIC -std=gnu99 -D_GNU_SOURCE
CC:=$(shell sh -c 'type $(CC) >/dev/null 2>/dev/null && echo $(CC) || echo gcc')

# Compile flags for linux / osx
ifeq ($(uname_S),Linux)
	SHOBJ_CFLAGS ?=  -fno-common -g -ggdb
	SHOBJ_LDFLAGS ?= -shared -Bsymbolic -Bsymbolic-functions
else
	CFLAGS += -mmacosx-version-min=10.6
	SHOBJ_CFLAGS ?= -dynamic -fno-common -g -ggdb
	SHOBJ_LDFLAGS ?= -dylib -exported_symbol _RedisModule_OnLoad -macosx_version_min 10.6
endif

ROOT=$(shell pwd)
# Flags for preprocessor
LDFLAGS = -lm -lc

MODULE_OBJ = $(ROOT)/src/date.o
MODULE_SO = $(ROOT)/redis_date_module.so

export

all: $(MODULE_SO)

$(MODULE_SO): $(MODULE_OBJ) $(DEPS)
	$(LD) $^ -o $@ $(SHOBJ_LDFLAGS) $(LDFLAGS)

clean:
	$(RM) $(MODULE_OBJ) $(MODULE_SO) $(DEPS)
	$(RM) -rf build/

distclean: clean

docker_clean: clean all
	docker build --rm . -t diegopacheco/redis_date_module --network=host --no-cache

docker:
		docker build --rm . -t diegopacheco/redis_date_module --network=host

docker_push: docker
	docker push diegopacheco/redis_date_module:latest

run:
	docker run -p 6379:6379 --rm diegopacheco/redis_date_module
