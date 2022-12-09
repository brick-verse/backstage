cd brickstage
npm i -g yarn
yarn install --production=false
yarn tsc
yarn build:backend
DOCKER_BUILDKIT=1 yarn build-image --tag jefftian/backstage
docker images
docker run --network host -e CI=true -d -p 127.0.0.1:7007:7007 --name backstage jefftian/backstage
docker ps | grep -q backstage
docker ps -aqf "name=backstage$"
docker push jefftian/backstage
docker logs $(docker ps -aqf name=backstage$)
curl localhost:7007 || docker logs $(docker ps -aqf name=backstage$)
docker kill backstage || echo "backstage killed"
docker rm backstage || echo "backstage removed"
