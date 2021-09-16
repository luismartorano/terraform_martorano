# terraform_martorano
Estudo Descomplicando Docker Terraform




terraform init
terraform plan -out plano
terraform apply "plano"

Provisioner
- Não é bom usar, segundo a Hashicorp, cai na prova, um dia você vai precisar usar e vai te facilitar, como no exemplo em ec2.tf

terraform state pull >> aula-backend.tfstate 
- Utilizado para efetuar o backup do tfstate que está remoto

- Sempre utilizar o recurso resource "aws_dynamodb_table" "dynamodb-terraform-state-lock", porque se outra pessoa estiver mexendo ou executando terraform plan ou algum ci/cd ele vai informar a outra pessoa que eestá executando que existe alguem executando a criação de uma infraestrutura.

#Utilizando o lock state!
-terraform plan -out plano -lock=false 
-terraform apply -lock=false

- Ao efetuar o terraform destroy você pode perder o arquivo lock  - "Error releasing the state lock!" A solução é utilizar 
terraform destroy -lock=false

#WORKSPACE
- terraform workspace new production (Cria novo workspace) -> troca de default para production
  terraform workspace new stage -> troca de production para staging
- Alterei os parÂmetros para as zonas respectivas!
- terraform workspace select nomedoworkspace
- No treino coloquei production em Ohio e  staging São Paulo

#Dados sensíveis no state
- encrypt = true 
Adicionar no main.tf terraform backend "s3"
