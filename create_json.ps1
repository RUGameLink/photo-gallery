$photosPath = ".\\photos"
$albums = Get-ChildItem -Path $photosPath -Directory

$albumList = @()

foreach ($album in $albums) {
    $firstPhoto = Get-ChildItem -Path $album.FullName -File | Select-Object -First 1
    $relativeFolderPath = $album.FullName.Replace((Resolve-Path .).Path, '').TrimStart('\').Replace('\', '/')
    $albumInfo = @{
        "name" = $album.Name
        "cover" = $firstPhoto.Name
        "folder" = $relativeFolderPath
    }
    $albumList += $albumInfo
}

$albumList | ConvertTo-Json | Set-Content -Path ".\\albums.json"
