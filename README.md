# fluid-demo
Demos of fluid

## AI

### MNIST DEMO
1. Install Pytorch Operator and arena
```
# 1. Install kustomize : https://kubectl.docs.kubernetes.io/installation/kustomize/
# 2. Install Pytorch Operator with kustomize, notice update your kubectl above 1.21.0 
kubectl apply -k "github.com/kubeflow/training-operator/manifests/overlays/standalone?ref=v1.3.0"
# 3. Install arena submit job tool for kubeflow https://arena-docs.readthedocs.io/en/latest/installation/complete/
```

2. Install Fluid with GooseFS
```
# 1. Download fluid chart and install
$ wget https://github.com/fluid-cloudnative/fluid/releases/download/v0.6.0/fluid-0.6.0.tgz
$ helm install --set runtime.goosefs.enabled=true fluid fluid-0.6.0.tgz 
$ kubectl get pod -n fluid-system
NAME                                         READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
alluxioruntime-controller-86b9fd59df-7tdtk   1/1     Running   0          13s   172.16.2.57    172.16.2.128   <none>           1/1
csi-nodeplugin-fluid-dln92                   2/2     Running   0          13s   172.16.2.30    172.16.2.30    <none>           <none>
csi-nodeplugin-fluid-fcl4k                   2/2     Running   0          13s   172.16.2.128   172.16.2.128   <none>           <none>
csi-nodeplugin-fluid-h8j5v                   2/2     Running   0          13s   172.16.2.109   172.16.2.109   <none>           <none>
dataset-controller-7dd7fd5b8d-llhrg          1/1     Running   0          13s   172.16.2.85    172.16.2.128   <none>           1/1
fluid-webhook-5f8d99bf76-nbfqt               1/1     Running   0          13s   172.16.2.94    172.16.2.128   <none>           1/1
goosefsruntime-controller-86876f7444-8gckk   1/1     Running   0          13s   172.16.2.110   172.16.2.128   <none>           1/1
```

3. Create COS pvc and GooseFS Instance
```
# COS CSI usage from https://cloud.tencent.com/document/product/457/40934 
$ kubectl apply -f ai/mnist-demo/cos/secret.yaml
$ kubectl apply -f ai/mnist-demo/cos/pv.yaml
$ kubectl apply -f ai/mnist-demo/cos/pvc.yaml

$ kubectl get pvc
NAME               STATUS   VOLUME            CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mnist              Bound    default-mnist     100Gi      ROX            fluid          7m1s
mnist-cos-pvc      Bound    mnist-cos-pv      200Gi      RWX                           75d

```

4. Submit job with goosefs accelerate and without goosefs accelerate
```
$ ./ai/mnist-demo/cos/submit.sh
$ arena logs mnist-cos -i mnist-cos-master-0 -c pytorch
$ arena delete mnist-cos
$ ./ai/mnist-demo/goosefs/submit.sh
$ arena logs mnist-goosefs -i mnist-goosefs-master-0 -c pytorch
$ arena delete mnist-goosefs
```
