#!/bin/bash
# Publie la dernière version du dashboard sur GitHub Pages.
# Copie dashboard.html (généré dans le dossier Drive) -> index.html, commit, push.
set -e
DIR="$HOME/Library/CloudStorage/GoogleDrive-h.iacopinelli@groupe-gexxia.fr/Mon Drive/GEXXIA/DASHBOARD VENTE"
REPO="$HOME/dashboard-web"

# Génère la version initiales (anonymisée) à partir du dernier export
python3 "$DIR/generer_dashboard.py" --initiales >/dev/null
cp "$DIR/dashboard_public.html" "$REPO/index.html"
cd "$REPO"
if ! git diff --quiet -- index.html; then
  git add index.html
  git commit -q -m "MAJ dashboard $(date '+%Y-%m-%d %H:%M')"
  git push -q
  echo "Publié."
else
  echo "Aucun changement à publier."
fi
