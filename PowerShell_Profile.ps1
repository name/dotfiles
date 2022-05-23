function com {
    $commands = {
      'which',
      'purgedns',
      'random',
      'profile',
      'updateprofile',
      'projects'
    }
    Write-Host "Custom Commands:"
    foreach ($command in $commands) {
      Write-Host $command
    }
  }
  
  function which ($command) {
      Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
  }
  
  function purgedns {
      ipconfig /flushdns
      Get-DnsClientServerAddress | Where-Object { $_.InterfaceAlias -eq 'WiFi' }
  }
  
  function random {
      param (
          [int] $Length = 16
      )
      $charSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.ToCharArray()
      $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
      $bytes = New-Object byte[]($Length)
  
      $rng.GetBytes($bytes)
  
      $result = New-Object char[]($Length)
  
      for ($i = 0 ; $i -lt $Length ; $i++) {
          $result[$i] = $charSet[$bytes[$i]%$charSet.Length]
      }
  
      return (-join $result)
  }
  
  function profile {
      code $env:USERPROFILE\.config\powershell\user_profile.ps1
  }
  
  function updateprofile {
      Copy-Item 'C:\Users\cmaddex\Documents\Projects\Personal\dotfiles\PowerShell_Profile.ps1' $env:USERPROFILE\.config\powershell\user_profile.ps1
  }
  
  function projects {
      Set-Location 'C:\Users\cmaddex\Documents\Projects'
  }
  
  Import-Module posh-git
  Import-Module -Name Terminal-Icons
  
  Set-Alias vim nvim
  Set-Alias ll ls
  Set-Alias g git
  Set-Alias grep findstr
  Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
  Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'