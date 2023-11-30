provider "github" {
  owner  = "K-Pascaline"
  token  = "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"
}

resource "github_repository" "nouveau_depot" {
  name        = "Depot_terraform"
  description = "nouveau dépot sur git"
  visibility  = "public"
}

variable "nom_du_repo" {
  description = "Depot_terraform"
  type        = string
}

