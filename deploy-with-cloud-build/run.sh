set -ae

source .env

set +a

gcloud builds submit \
  --config=cloudbuild.yaml \
  --substitutions=_REPO="$CLOUD_ARTIFACT_REGISTRY_HOSTNAME/$PROJECT_ID/$DIRECTORY_NAME/$IMAGE",_TAG="$TAG"

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