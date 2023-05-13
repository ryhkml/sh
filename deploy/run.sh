set -ae

source .env

set +a

if [ "$DOCKER_BUILD_ARGS" = "EMPTY" ]; then
  docker build -t $IMAGE:$TAG .
else
  docker build -t $IMAGE:$TAG $DOCKER_BUILD_ARGS .
fi

docker tag $IMAGE:$TAG $CLOUD_ARTIFACT_REGISTRY_HOSTNAME/$PROJECT_ID/$DIRECTORY_NAME/$IMAGE:$TAG

docker push $CLOUD_ARTIFACT_REGISTRY_HOSTNAME/$PROJECT_ID/$DIRECTORY_NAME/$IMAGE:$TAG

if [ "$CLOUD_RUN_FLAGS" = "EMPTY" ]; then
  gcloud run deploy $CLOUD_RUN_SERVICE_NAME \
    --image=$CLOUD_ARTIFACT_REGISTRY_HOSTNAME/$PROJECT_ID/$DIRECTORY_NAME/$IMAGE:$TAG \
    --region=$CLOUD_RUN_REGION
else
  gcloud run deploy $CLOUD_RUN_SERVICE_NAME \
    --image=$CLOUD_ARTIFACT_REGISTRY_HOSTNAME/$PROJECT_ID/$DIRECTORY_NAME/$IMAGE:$TAG \
    --region=$CLOUD_RUN_REGION $CLOUD_RUN_FLAGS
fi

gcloud run services update-traffic $CLOUD_RUN_SERVICE_NAME \
  --region=$CLOUD_RUN_REGION \
  --to-latest

echo "Done"