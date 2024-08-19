# time-api2

#download and install terraform
cd GKS
terraform init
terraform validate
terraform plan 
terraform apply --auto-approve
terraform destroy --auto-approve

#download and install google cloudsdk
gcloud auth login 
gcloud config set project supple-defender-349711 
gcloud iam service-accounts keys create key.json --iam-account time-api2@supple-defender-349711.iam.gserviceaccount.com
#copy the json key
