# Zappa
Docker image for Zappa, based on the [Lambda Docker Image](https://github.com/lambci/docker-lambda)

* Requires Docker to be installed and running :whale2: [Docker Install](https://docs.docker.com/engine/installation/)
* Alias it to easily build and deploy Zappa projects, using Lambda compatible Libc libraries (No more ELF errors)
* Ensure you have the AWS API env vars set for access key, secret key and default region
```bash
$ git clone git@github.com:danielwhatmuff/zappa.git && cd zappa && docker build -t zappa .
$ alias zappashell='docker run -ti -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -v $(pwd):/var/task  --rm zappa bash'
$ alias >> ~/.bash_profile
$ cd yourzappaproject
$ zappashell
zappashell> source yourvirtualenv/bin/activate
zappashell> pip install -r requirements.txt
zappashell> zappa deploy
```
