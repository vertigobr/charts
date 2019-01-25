DigitalOcean
=======

# Passos

1. Editar variáveis e tokens

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

4. Forkar e clonar projeto git que contém os charts originais

```sh
git clone git@github.com:vertigobr/charts.git
```

4. Editar helm chart (mudar values.yaml para novos defaults)

Ex: testar diversos cenários (LoadBalancer, NodePort, ClusterIP), observando as formas de acesso existentes para cada deployment. O chart stable/wordpress serve como exemplo.

5. Gerar packages para os charts modificados e gerar índices

```sh
helm package -d docs stable/wordpress
helm repo index docs
```

6. Submeter 'docs' para o repositório Git

```sh
git add .
git commit -m "......"
git push origin master
```

7. Criar Github Pages para a pasta `docs` do projeto. Anotar URL - este será o repositório Helm dos charts customizados

8. Adicionar repo ao kubeapps

