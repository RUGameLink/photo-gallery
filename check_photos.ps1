$photosPath = ".\\photos"
$albums = Get-ChildItem -Path $photosPath -Directory

foreach ($album in $albums) {
    $photos = Get-ChildItem -Path $album.FullName -File | Select-Object -Skip 1
    $relativeFolderPath = $album.FullName.Replace((Resolve-Path .).Path, '').TrimStart('\').Replace('\', '/')
    $photoList = @()
    foreach ($photo in $photos) {
        $photoInfo = @{
            "name" = $photo.Name
        }
        $photoList += $photoInfo
    }
    $photoList | ConvertTo-Json | Set-Content -Path "$($album.FullName)\\photos.json"
}
