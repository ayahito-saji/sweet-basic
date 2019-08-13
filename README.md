# Sweet BASIC

Sweet BASIC is a programming language being compatible with Smile BASIC 2.* (SmileBoom).

## Require Software
* gcc
* make
* bison(yacc)
* flex(lex)

## Build
```
$ make build
```

## Test
```
$ make test
```

# Use Vagrant
If you installed vagrant, you can use Ubuntu 16.04 as virtual environment.
Exec follow commands:

```
$vagrant up
$vagrant ssh
```
This repo files are in `/vagrant`

If you stop or pause development, you execute follow commands.
```
#exit
$ vagrant halt
```

# Use Docker
If you installed docker and docker-compose, you can use Ubuntu 16.04 as virtual environment.
Exec follow commands:
```
$ docker-compose up -d
$ docker-compose exec app bash
```
This repo files are in `/share`.
If you stop or pause development, you execute follow commands.
```
#exit
$ docker-compose stop
```
