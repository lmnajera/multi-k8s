docker build -t lnajera/multi-client:latest -t lnajera/multi-client:$SHA -f  ./client/Dockerfile ./client
docker build -t lnajera/multi-server:latest -t lnajera/multi-server:$SHA -f  ./server/Dockerfile ./server
docker build -t lnajera/multi-worker:latest -t lnajera/multi-worker:$SHA -f  ./worker/Dockerfile ./worker

docker push lnajera/multi-client:latest
docker push lnajera/multi-server:latest
docker push lnajera/multi-worker:latest

docker push lnajera/multi-client:$SHA
docker push lnajera/multi-server:$SHA
docker push lnajera/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lnajera/multi-client:$SHA
kubectl set image deployments/server-deployment server=lnajera/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lnajera/multi-worker:$SHA