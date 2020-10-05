docker build -t valentynshcherban/multi-client:latest -t valentynshcherban/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t valentynshcherban/multi-server:latest -t valentynshcherban/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t valentynshcherban/multi-worker:latest -t valentynshcherban/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push valentynshcherban/multi-client:latest
docker push valentynshcherban/multi-server:latest 
docker push valentynshcherban/multi-worker:latest

docker push valentynshcherban/multi-client:$SHA
docker push valentynshcherban/multi-server:$SHA
docker push valentynshcherban/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=valentynshcherban/multi-server:$SHA
kubectl set image deployments/client-deployment client=valentynshcherban/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=valentynshcherban/multi-worker:$SHA