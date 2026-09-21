<#
.SYNOPSIS
  Create a new blog post, vulnerability write-up, or research note.

.EXAMPLE
  .\new.ps1 post "Reversing a Router Firmware Update"
  .\new.ps1 writeup "Heap Overflow in FooLib Parser"
  .\new.ps1 note "Frida Cheat Sheet" -Area reverse-engineering
#>
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [ValidateSet('post', 'writeup', 'note')]
  [string]$Type,

  [Parameter(Mandatory = $true, Position = 1)]
  [string]$Title,

  # Sub-folder under content/notes/ (only used for notes)
  [string]$Area = 'reverse-engineering',

  # Don't open the new file in VS Code
  [switch]$NoOpen
)

$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

# "Heap Overflow in FooLib!" -> "heap-overflow-in-foolib"
$slug = ($Title.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')

switch ($Type) {
  'post'    { $target = "blog/$slug";              $kind = 'blog';    $file = "content/blog/$slug/index.md" }
  'writeup' { $target = "blog/$slug";              $kind = 'writeup'; $file = "content/blog/$slug/index.md" }
  'note'    { $target = "notes/$Area/$slug.md";    $kind = 'notes';   $file = "content/notes/$Area/$slug.md" }
}

if (Test-Path $file) { throw "Already exists: $file" }

hugo new content $target --kind $kind
if ($LASTEXITCODE -ne 0) {
  # Hugo can leave a placeholder file behind on failure; don't keep it.
  if (Test-Path $file) { Remove-Item $file }
  if ($Type -ne 'note' -and (Test-Path (Split-Path $file))) { Remove-Item (Split-Path $file) -Recurse }
  throw "hugo new failed"
}

# Replace the slug-derived title with the exact title you typed.
$escaped = $Title -replace '"', '\"'
$text = [IO.File]::ReadAllText((Resolve-Path $file))
$text = $text -replace '(?m)^title: ".*"', "title: `"$escaped`""
[IO.File]::WriteAllText((Resolve-Path $file), $text)

Write-Host ""
Write-Host "Created $file" -ForegroundColor Green
Write-Host "Preview with:  hugo server -D   then open http://localhost:1313/"
Write-Host "Publish by setting 'draft: false', then commit and push."

if (-not $NoOpen -and (Get-Command code -ErrorAction SilentlyContinue)) {
  code $file
}
