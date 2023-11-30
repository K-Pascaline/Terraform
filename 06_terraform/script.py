import subprocess
import sys

Depot_terraform = sys.argv[1]

# Commande Terraform pour appliquer en utilisant le nom_du_repo fourni en argument
def terraform_github(Depot_terraform):
    subprocess.run= ["terraform", "apply", "-auto-approve", f"-var=Depot_terraform{Depot_terraform}", "-auto-approve", "-auto-approve", "-auto-approve",]

    print("créé avec succès.")

def main():
    Depot_terraform= sys.argv[1]
    terraform_github(Depot_terraform)
if __name__ == "__main__":
    main()
