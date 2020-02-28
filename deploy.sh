docker build -t schemido/multi-client:latest -t schemido/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t schemido/multi-server:latest -t schemido/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t schemido/multi-worker:latest -t schemido/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push schemido/multi-client:latest
docker push schemido/multi-client:$SHA
docker push schemido/multi-server:latest
docker push schemido/multi-server:$SHA
docker push schemido/multi-worker:latest
docker push schemido/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=schemido/multi-server:$SHA
kubectl set image deployments/client-deployment client=schemido/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=schemido/multi-worker:$SHA