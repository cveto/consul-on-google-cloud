"`n"
"DeleteCluster script. A script that will delete your cluster of 4 from Google Cloud."
$confirmation = Read-Host "Are you Sure You Want To Annihialate Your Cluster? [y/n/all]"

"Set project zardoz339"
gcloud config set project zardoz339

"`n"
if ($confirmation -eq 'y') {
    gcloud compute instances delete node1
    gcloud compute instances delete node2
    gcloud compute instances delete node3
    gcloud compute instances delete node4
} elseif ($confirmation -eq 'all') {
    "`n"
    "--- Working on it (allthought it does not seem like it) ---"
    gcloud compute instances delete node1 --quiet
    gcloud compute instances delete node2 --quiet
    gcloud compute instances delete node3 --quiet
    gcloud compute instances delete node4 --quiet
} 

"`n"
"Done!"
Read-Host -Prompt "Press Enter to exit"
