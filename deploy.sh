docker build -t lienejansone/multi-client:latest -t lienejansone/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lienejansone/multi-server:latest -t lienejansone/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lienejansone/multi-worker:latest -t lienejansone/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lienejansone/multi-client:latest
docker push lienejansone/multi-client:$SHA
docker push lienejansone/multi-server:latest
docker push lienejansone/multi-server:$SHA
docker push lienejansone/multi-worker:latest
docker push lienejansone/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lienejansone/multi-server:$SHA
kubectl set image deployments/client-deployment client=lienejansone/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=lienejansone/multi-worker:$SHA
