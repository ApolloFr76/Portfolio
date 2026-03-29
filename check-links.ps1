$root = "c:\Travail\Portfolio\Portfolio\portfolio-site\html"
$files = Get-ChildItem -Path $root -Filter *.html
$pattern = '(?i)(?:href|src)\s*=\s*[""'']([^""''#]+)[""'']'
$broken = @()
foreach ($f in $files) {
  $content = Get-Content -LiteralPath $f.FullName -Raw
  $matches = [regex]::Matches($content, $pattern)
  foreach ($m in $matches) {
    $link = $m.Groups[1].Value.Trim()
    if ($link -match '^(https?:|mailto:|tel:|javascript:|data:|\$\{)') { continue }
    $target = Join-Path $f.DirectoryName ($link -replace '/', '\\')
    if (-not (Test-Path -LiteralPath $target)) {
      $broken += [PSCustomObject]@{File=$f.Name; Link=$link; Target=$target}
    }
  }
}
if ($broken.Count -eq 0) {
  Write-Output "NO_BROKEN_LINKS"
} else {
  $broken | Sort-Object File, Link | Format-Table -AutoSize
}
