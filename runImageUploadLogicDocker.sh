#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED runImageUploadLogicDocker ***
***************
'
    echo "An error occurred runImageUploadLogicDocker . Exiting..." >&2
    exit 1
}

trap 'abort' 0

#Kill the process
unset DOCKER_HOST
unset DOCKER_TLS_VERIFY
unset DOCKER_TLS_PATH
echo "Trying to login. If you are NOT logged in, there will be a prompt"
docker login

# It will print the log folder wise
echo "Building image-upload-logic"
docker build -f Dockerfile -t $DOCKERUSER_ID/image-upload-logic .
# Now image building is done 
# So now we will push that image to dockerhub
echo "Pushing image-upload-logic"
docker push $DOCKERUSER_ID/image-upload-logic
# Here we run the container with that port 3000:3000
echo "Running image-upload-logic"
# Do not run when building it takes a port away
docker run -d -p 3000:3000 $DOCKERUSER_ID/image-upload-logic &
sleep 5
echo "List of containers running now"
docker container ls -a

ImageUploadLogicId="$(docker container ls -f ancestor="$DOCKERUSER_ID/image-upload-logic" -f status=running -aq)"
echo " The one we just started is : $ImageUploadLogicId"

if [ -n "$ImageUploadLogicId" ]; then
  echo "image-upload container is running $(docker container ls -f ancestor=$DOCKERUSER_ID/image-upload-logic -f status=running -aq) :) "
else
  echo "ERROR: image-upload is NOT running. :(  . Please Check logs/ImageUpload-logic.log"
  exit 1
fi

trap : 0

echo >&2 '
************
*** DONE runImageUploadLogicDocker ***
************'