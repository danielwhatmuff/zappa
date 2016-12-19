# zappa
Docker image for Zappa, based on the official Amazon Linux image

* Alias for building projects with compatible Libc libraries
```bash
$ alias zappa='docker run -v $(pwd):/code --rm danielwhatmuff/zappa'
```
