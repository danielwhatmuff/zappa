# Zappa
Docker image for Zappa, based on the [Lambda Docker Image](https://github.com/lambci/docker-lambda)

* Alias it to easily build and deploy Zappa projects, using Lambda compatible Libc libraries (No more ELF errors)
```bash
$ docker build -t zappa .
$ alias zappa='docker run -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -v $(pwd):/var/task --entrypoint zappa --rm zappa'
$ alias zappashell='docker run -ti -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -v $(pwd):/var/task  --rm zappa bash'
$ cd yourzappaproject
$ zappa deploy
```
