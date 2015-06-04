# Contribuindo para Phoenix Project

 - [Fork px-project](#fork)
 - [Clonar px-project](#clone)
 - [Upstream](#upstream)
 - [Pull Request](#pullrequest)
 - [Pull Request Aceito](#merged)

## <a name="fork"></a> Fork px-project

Faça um fork (clicando no botão **Fork**) do repositório oficial [Phoenix Project](https://github.com/wesleifreitas/px-project)

## <a name="clone"></a> Clonar px-project

* Execute o Git Bash
* Navegue até a pasta ColdFusion11/cfusion/wwwroot:

![git_cd_wwwroot](docs/guide-pt-BR/images/git_cd_wwwroot.png)

* Execute o comando git clone para clonar px-project do seu respositório

```shell
git clone git@github.com:YOUR-GITHUB-USERNAME/px-project.git
```

## <a name="upstream"></a> Upstream

* Acesse a pasta do projeto px-project clonado:

```shell
cd px-project
```

* Crie um git remote chamdo **upstream** do repositório oficial:

```shell
git remote add upstream git@github.com:wesleifreitas/px-project.git
```

## <a name="pullrequest"></a> Pull Request

* Faça suas alterações em um novo git branch:

```shell
git checkout -b my-fix-branch master
```

* Após desenvolver e testar suas alterações ralize o commit:

```shell
git commit -a
```
* Envie seu branch para o GitHub

```shell
git push origin my-fix-branch
```
* Acesse seu respositório no site GitHub e envie um Pull Request para o projeto oficial

## <a name="merged"></a> Pull Request aceito

Depois que seu Pull Request for aceito (merged), o branch pode ser removido com segurança e suas alterações devem ser atualizadas do repositório oficial (upstream):


* Remover branch remote:

```shell
git push origin --delete my-fix-branch
```

* Checkout no branch master:

```shell
git checkout master -f
```

* Remover o branch local:

```shell
git branch -D my-fix-branch
```

* Atualizar seu branch master com a última versão (upstream)

```shell
git pull --ff upstream master
```

