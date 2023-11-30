import subprocess
import sys

def create_github_repo(Depot_terraform):
    try:
        subprocess.run(["terraform", "apply", "-auto-approve", "-var", f"repo_name={Depot_terraform}"])
    except Exception as e:
        print(f"Erreur lors de la création du dépôt : {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Utilisation : python script.py Depot_terraform")
        sys.exit(1)

    Depot_terraform = sys.argv[1]

    create_github_repo(Depot_terraform)
