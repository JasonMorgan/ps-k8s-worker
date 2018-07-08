$file = Get-ChildItem -Path cluster-repo/Deployment/$ENV:DEPLOYMENT
$newName = "$($ENV:IMAGE_NAME):$(Get-Content -Raw -Path bump/version)"
$string = (Get-Content -Raw -Path $file.FullName) -replace "image: .*", "image: $newName"
$string | Set-Content $file.FullName
$string
# Get-ChildItem bump -Recurse | foreach { $_ | get-content}
# cat bump/ci/metadata/tag
# Get-ChildItem -path cluster-repo -force
Copy-Item -Recurse -Path cluster-repo/* -Destination out/ -Force
cd out
# git init
git config --global user.email "jmorgan@f9vs.com"
git config --global user.name "JasonMorgan"
git add .
git commit -m "Updated via Concourse. Modified the deployment $ENV:DEPLOYMENT"
