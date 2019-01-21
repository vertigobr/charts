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

