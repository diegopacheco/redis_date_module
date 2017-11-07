# Redis Date Module

Simple Redis_Module for Date. <BR/>

## Usage

### Build and Bake
```bash
make
make docker
```

### Running
```bash
make run
```

### Testing
```
redis-cli
dp.DATE
```
or...
```bash
make redis_test
```

## Commands

ft.DATE : Returns the current date in String. I.e: Tue Nov  7 20:32:27 2017.

## Dependencies

* docker
* redis-cli
* build-essential

Cheers, <BR/>
Diego Pacheco <BR/>
[diegopacheco.github.io](http://diegopacheco.github.io)
