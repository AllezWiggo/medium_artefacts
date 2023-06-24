
# Secret Life of Pods

![Secret Life of Pods](img/secret_life_of_pods.png "Secret Life of Pods")

## Prometheus

### Add Helm Repo

```
helm repo add prometheus https://raw.githubusercontent.com/AllezWiggo/medium_artefacts/main/Secret_Life_of_Pods/Helm/prometheus
```

### Install Helm Charts

Update the local host path if different using a local values file.

values.yaml:

```
storage:
  class: "manual"
  capacity: "10Mi"
  hostPath: "<custom folder path>"
```

```
helm upgrade --install prometheus prometheus/prometheus -f <path to local values.yaml>
```

## Grafana

### Add Helm Repo

```
helm repo add grafana https://raw.githubusercontent.com/AllezWiggo/medium_artefacts/main/Secret_Life_of_Pods/Helm/grafana
```

### Install Helm Charts

```
helm upgrade --install grafana grafana/grafana
```

## Sample Application - restarts

### Add Helm Repo

```
helm repo add restarts https://raw.githubusercontent.com/AllezWiggo/medium_artefacts/main/Secret_Life_of_Pods/Helm/restarts
```

### Install Helm Charts

Sample application written in golang to simulate restarts.

```
helm upgrade --install restarts restarts/restarts
```

### Simulate restarts

The app exposes a health endpoint for liveness. When healthy, it responds with HTTP 200.

```
curl -v http://localhost:8080/health
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Sat, 24 Jun 2023 21:27:18 GMT
< Content-Length: 0
```

It also exposes a `/status` enpoint using `POST` method which can be used to induce a restart. Any value apart from `ok` in the posted body will cause a restart.

```
curl -v -X POST http://localhost:8080/status -d "{'status': 'ko'}"
```

The health will now return 500.

```
curl -v http://localhost:8080/health
<
* Mark bundle as not supporting multiuse
< HTTP/1.1 500 Internal Server Error
< Date: Sat, 24 Jun 2023 21:28:22 GMT
< Content-Length: 0
```

This causes K8s to restart the pod now.

```
NAME                          READY   STATUS    RESTARTS        AGE
restarts-64fb94f79f-7vqq7     1/1     Running   1 (26s ago)     19m
```




