Param(
  [switch]$Reset,
  [int]$Categories = 5,
  [int]$Companies = 6,
  [int]$Customers = 12,
  [int]$Products = 30,
  [int]$Invoices = 24,
  [int]$Seed = 42,
  [string]$DbFile = ".seed_db/system_loja.sqlite"
)

$ErrorActionPreference = "Stop"

$argsList = @(
  "run",
  "tool/seed_app_database.dart",
  "--categories=$Categories",
  "--companies=$Companies",
  "--customers=$Customers",
  "--products=$Products",
  "--invoices=$Invoices",
  "--seed=$Seed",
  "--dbFile=$DbFile"
)

if ($Reset) {
  $argsList += "--reset"
}

Write-Host "Executando seed de dados do AppDatabase..."
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir

Push-Location $repoRoot
try {
  dart @argsList
}
finally {
  Pop-Location
}
