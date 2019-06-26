docker build -t sethspitkoski/multi-client:latest -t sethspitkoski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sethspitkoski/multi-server:latest -t sethspitkoski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sethspitkoski/multi-worker:latest -t sethspitkoski/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sethspitkoski/multi-client:latest
docker push sethspitkoski/multi-client:$SHA

docker push sethspitkoski/multi-server:latest
docker push sethspitkoski/multi-server:$SHA

docker push sethspitkoski/multi-worker:latest
docker push sethspitkoski/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sethspitkoski/multi-server:$SHA
kubectl set image deployments/client-deployment client=sethspitkoski/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sethspitkoski/multi-worker:$SHA

