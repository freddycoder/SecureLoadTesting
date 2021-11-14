[CmdletBinding()]
param (
    [Parameter()]
    [bool]
    $DoPush = $false,
    [Parameter()]
    [string]
    $accountName = "erabliereapi",
    [Parameter()]
    [string]
    $tag = "initial"
)

docker build -t securetesting/artillery -f Artillery.dockerfile .
docker build -t securetesting/k6 -f k6.dockerfile .
docker build -t securetesting/newman -f Newman.dockerfile .

if ($DoPush) {
    docker tag securetesting/artillery $accountName/securetesting-artillery:$tag
    docker tag securetesting/k6 $accountName/securetesting-k6:$tag
    docker tag securetesting/newman $accountName/securetesting-newman:$tag

    docker push $accountName/securetesting-artillery:$tag
    docker push $accountName/securetesting-k6:$tag
    docker push $accountName/securetesting-newman:$tag
}