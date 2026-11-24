**ALL TERRAFORM COMMANDS MUST BE RUN INDIVIDUALLY IN EACH FOLDER (MODULAR DESIGN)**

DETAILS
    ubuntu-uvu-it3200-jacob
        *image:* "ubuntu-os-cloud/ubuntu-minimal-2610-amd64" (provided by GCP)
        *compute instance:* e2-micro with 10GB disk
        *Terraform Variables:*
            project_id: *GCP project ID within which the VM will be created*
     windows-uvu-it3200-jacob
        *image:* "windows-cloud/windows-2025"
        *compute instance:* e2-medium with 50GB disk
        *Terraform Variables:*
            project_id: *GCP project ID within which the VM will be created*
       *Additional:*
            -*Without a Microsoft account with existing licensing for virtualization (or a single-image license on hand), Windows is not available on GCP other than Windows Server, which includes a pay-as-you-use licensing fee*
            -*This is a WINDOWS SERVER image*
    kali-uvu-it3200-jacob
        *image:* must be provided by user (recommend VirtualBox .ova download here: https://www.kali.org/get-kali/#kali-virtual-machines)
        *compute instance:* e2-medium with 30GB disk
        *Terraform Variables:*
            project_id: *GCP project ID within which the VM will be created*
            image_dir: *location within GCP of the image to be used for installation*
        *Additional:*
            -*Kali is BYOI (bring your own image) and an image (.ova is easiest) can be downloaded directly from Kali and uploaded/imported into GCP*


SPECIAL CONSIDERATIONS
    -*In the 'kali' folder, the 'terraform.tfvars' file must be updated with the user's project ID and the location of the saved Kali image in GCP before any automation.*
    -*In the 'ubuntu' and 'windows' folders, only the project ID must be updated in the 'terraform.tfvars' file before any automation.*

AUTOMATION WITH TERRAFORM
    *Once for each folder, run (from the folder, while logged into the GCP CLI):*
        terraform init
        terraform fmt
        terraform validate
        terraform plan
    *At this point, ensure that the VM of choice is being created with the expected parameters.*
        terraform apply
    *If needed, the resources created can be removed via*
        terraform destroy