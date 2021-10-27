
# Image Upload Docker

Here we will creating a docker container of ``Image Upload``.
For that first clone my thi github repo.
Now you need to build the docker image via this command

```
docker build -t image-upload-docker .
```
Now your dockker image is ready so expose it on port via this command

```
docker run -dp 8080:8080 image-upload-docker
```

Then try this [link](http://localhost:5051).


Here we have another thing is ``jenkinsfile``, which will help us to build docker image & push it on ``dockerhub`` automatically.

First you need to push the code in github then you can integrate and add credentials of github to jenkins, then this jenkinsfile will enter into this picture and do it automatically.  



Thank you... :)
