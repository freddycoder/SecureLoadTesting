# Command parameter
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Namespace = "securetesting"
)

# create a namespace
kubectl create namespace $Namespace

# create a secret
kubectl apply -f .\k8s\password-secret.yml -n securetesting

# create a configmap from the example directory
kubectl create configmap securetesting-example -n securetesting --from-file=.\example

# deploy the examples
kubectl apply -f .\k8s\securetesting-artillery-pod.yml -n $Namespace
kubectl apply -f .\k8s\securetesting-k6-pod.yml -n $Namespace
kubectl apply -f .\k8s\securetesting-newman-pod.yml -n $Namespace