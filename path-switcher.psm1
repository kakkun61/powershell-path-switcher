#requires -PSEdition Core

Set-StrictMode -Version Latest

# .SYNOPSIS
# Switch pathes on and off.
function Switch-Path {
  $config = Get-Config powershell-path-switcher

  if ($null -eq $config) {
    Write-Warning "No configurations"
    return
  }

  $configArray = @()
  foreach ($key in $config.Keys) {
    $configArray += [System.Tuple]::Create($key, $config[$key])
  }

  $paths = $Env:Path -split ';'
  $restPaths = $paths | Where-Object { $_ -notin $config.Values }

  $initialSelection = @()
  if ($configArray -is [System.Tuple`2[String, String]]) {
    if ($configArray.Item2 -in $paths) {
      $initialSelection += 0
    }
  }
  else {
    for ($i = 0; $i -lt $configArray.Count; $i++) {
      if ($configArray[$i].Item2 -in $paths) {
        $initialSelection += $i
      }
    }
  }

  $selected = Show-Menu -MenuItems $configArray -MultiSelect -MenuItemFormatter { param ($c) "$($c.Item1): $($c.Item2)" } -InitialSelection $initialSelection

  if ($null -eq $selected) {
    $newPaths = $restPaths
  }
  elseif ($selected -is [System.Tuple`2[System.String, System.String]]) {
    $newPaths = , $selected.Item2 + $restPaths
  }
  else {
    $newPaths = ($selected | ForEach-Object { $_.Item2 }) + $restPaths
  }

  $Env:Path = $newPaths -join ';'
}

Export-ModuleMember -Function Switch-Path
