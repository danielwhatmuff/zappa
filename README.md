# Zappa
Docker image for [Zappa](https://github.com/Miserlou/Zappa), based on the [Lambda Docker Image](https://github.com/lambci/docker-lambda)

* Requires Docker to be installed and running :whale2: [Docker Install](https://docs.docker.com/engine/installation/)
* Alias it to easily build and deploy Zappa projects, using Lambda compatible Libc libraries (No more ELF errors)
* Ensure you have the AWS API env vars set for access key, secret key and default region (or use AWS credential/config files)
* Source a pre-created virtual environment located at /var/venv or create your own persistent one within /var/task/ once in the container.

## Build the image
```bash
$ git clone git@github.com:danielwhatmuff/zappa.git && cd zappa && docker build -t danielwhatmuff/zappa .
```

## Build a customized image with extra build deps
```
# Add extra installs to the Dockerfile.update file, then run:
$ docker build --build-arg version=< zappa version > -t danielwhatmuff/zappa:< zappa version > -f Dockerfile.update .
# e.g.
$ docker build --build-arg version=0.38.1 -t danielwhatmuff/zappa:0.38.1 -f Dockerfile.update .
```

## Or pull the image from Docker Hub
```bash
$ docker pull danielwhatmuff/zappa
```

## Using exported AWS_DEFAULT_REGION, AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID env vars
```
$ alias zappashell='docker run -ti -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -v $(pwd):/var/task  --rm danielwhatmuff/zappa bash'
$ alias >> ~/.bash_profile
$ cd yourzappaproject
$ zappashell
# Create a persistent virtualenv within the mounted volume and activate it
zappashell> virtualenv venv 
zappashell> source venv/bin/activate
# OR use the prebaked one...
zappashell> source /var/venv/bin/activate
# Install your requirements
zappashell> pip install -r requirements.txt
# Deploy the thing
zappashell> zappa deploy
# Update the thing
zappashell> zappa update
```

## Using cross account IAM role from CLI config ~/.aws/credentials or ~/.aws/config
* Example CLI config:-
```bash
[profile myprofile]
region = ap-southeast-2
role_arn = arn:aws:iam::ACCOUNTNUMBER:role/YourCrossAccountAssumableRole
```
* Export the AWS_PROFILE to the profile name myprofile
```
$ export AWS_PROFILE=myprofile
```
* Mount the code and config into the container
```
$ alias zappashell='docker run -ti -e AWS_PROFILE=$AWS_PROFILE -v $(pwd):/var/task -v ~/.aws/:/root/.aws  --rm danielwhatmuff/zappa bash'
zappashell> source yourvirtualenv/bin/activate
zappashell> pip install -r requirements.txt
zappashell> zappa deploy
```

## Known Issues
* On Mac - if you leave the Docker daemon running for too long, you will get time drift and zappa commands will fail with the below types of errors (so will AWS CLI commands) - to fix, just restart the daemon
```
Error: No Lambda ... detected in ... - have you deployed yet?
Warning! Couldn't get function ... in ... - have you deployed yet?
```
* Yum installs can timeout due to latency between you and the default repository, override to your local AWS region using
```
# Find your region code here - http://docs.aws.amazon.com/general/latest/gr/rande.html
$ docker build --build-arg region=ap-southeast-2 -t danielwhatmuff/zappa:< zappa version > -f Dockerfile .
```

