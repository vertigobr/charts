DigitalOcean
=======

# Passos

1. Editar variaveis e tokens

2. Rodar terraform:

```sh
terraform init
terraform apply
terraform output my-kubeconfig > kubeconfig
export KUBECONFIG=$(pwd)/kubeconfig
kubectl get nodes
```

3. Instalar Helm/Tiller

```sh
helm init
kubectl create rolebinding default-view \
  --clusterrole=view \
  --serviceaccount=kube-system:default \
  --namespace=kube-system
kubectl create clusterrolebinding add-on-cluster-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:default
```

