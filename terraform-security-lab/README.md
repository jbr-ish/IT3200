# GCP Multi-OS Terraform Deployment (Modular Design)

> **Important:** This repository uses a modular folder structure. **All Terraform commands must be run individually inside each OS folder** (`ubuntu/`, `windows/`, `kali/`).

---

##  Project Layout & Configurations

### 1. `ubuntu/` — `ubuntu-uvu-it3200-jacob`
* **Image:** `ubuntu-os-cloud/ubuntu-minimal-2610-amd64` *(provided by GCP)*
* **Compute Instance:** `e2-micro` with `10GB` disk
* **Terraform Variables (`terraform.tfvars`):**
  * `project_id`: GCP project ID within which the VM will be created

---

### 2. `windows/` — `windows-uvu-it3200-jacob`
* **Image:** `windows-cloud/windows-2025`
* **Compute Instance:** `e2-medium` with `50GB` disk
* **Terraform Variables (`terraform.tfvars`):**
  * `project_id`: GCP project ID within which the VM will be created
* **Additional Notes:**
  * Without a Microsoft account with existing licensing for virtualization (or a single-image license on hand), Windows is not available on GCP other than **Windows Server**, which includes a pay-as-you-use licensing fee.
  * This is a **Windows Server** image.

---

### 3. `kali/` — `kali-uvu-it3200-jacob`
* **Image:** Bring Your Own Image (BYOI) — must be provided by the user *(recommended: VirtualBox `.ova` download from [Kali Virtual Machines](https://www.kali.org/get-kali/#kali-virtual-machines))*
* **Compute Instance:** `e2-medium` with `30GB` disk
* **Terraform Variables (`terraform.tfvars`):**
  * `project_id`: GCP project ID within which the VM will be created
  * `image_dir`: Location within GCP of the image to be used for installation
* **Additional Notes:**
  * Kali is **BYOI** (Bring Your Own Image). An image (`.ova` is easiest) can be downloaded directly from Kali and uploaded/imported into GCP.

---

##  Special Considerations (Pre-Deployment)

Before running any automation, update the `terraform.tfvars` file inside your target directory:

* **`ubuntu/` & `windows/` folders:** Update only the `project_id` variable in `terraform.tfvars`.
* **`kali/` folder:** Update both `project_id` and `image_dir` (location of the saved Kali image in GCP) in `terraform.tfvars`.

---

##  Automation with Terraform

Navigate into your desired OS directory (`cd ubuntu`, `cd windows`, or `cd kali`) while authenticated with the GCP CLI, and run the following workflow:

```bash
# 1. Initialize the working directory and download providers
terraform init

# 2. Format configuration files to canonical style
terraform fmt

# 3. Validate syntax and configuration consistency
terraform validate

# 4. Preview changes and verify the VM is being created with expected parameters
terraform plan

# 5. Provision the infrastructure
terraform apply
