# powershell-path-switcher

[![GitHub Actions: install](https://github.com/kakkun61/powershell-path-switcher/workflows/install/badge.svg)](https://github.com/kakkun61/powershell-path-switcher/actions?query=workflow%3Ainstall) [![GitHub Actions: lint](https://github.com/kakkun61/powershell-path-switcher/workflows/lint/badge.svg)](https://github.com/kakkun61/powershell-path-switcher/actions?query=workflow%3Alint) [![PowerShell Gallery](https://img.shields.io/powershellgallery/p/path-switcher.svg)](https://www.powershellgallery.com/packages/path-switcher/) [![Sponsor](https://img.shields.io/badge/Sponsor-%E2%9D%A4-red?logo=GitHub)](https://github.com/sponsors/kakkun61)

Path Environment Variable Quick Switcher.

https://user-images.githubusercontent.com/282593/130179275-62a876d7-4e93-488a-93b8-7688535251d6.mp4

## Install

Invoke the following commands to install this.

```PowerShell
> Install-Module path-switcher
> Import-Module path-switcher
```

### HEAD

If you want to use HEAD, follow this instruction.

```PowerShell
> git clone git@github.com:kakkun61/powershell-path-switcher.git
> Import-Module .\powershell-path-switcher\path-switcher.psd1 # -Force option may be necessary
```

## Configuration

This module treats three types of configurations:

- local configuration
- user global configuration
- system global configuration

### Local configuration

A local configuration is named _powershell-path-switcher.yaml_ and located at the current working directory or its parents recursively.

### User global configuration

A user global configuration is named _config.yaml_ and located at _`$Env:APPDATA\powershell-path-switcher`_.

### System global configuration

A system global configuration is named _config.yaml_ and located at _`$Env:ProgramData\powershell-path-switcher`_.

### Overwriting

When the configurations have the same keys, upper ones overwrite.

For example there are following configurations:

```yaml
# local configuration
foo: foo
```

```yaml
# user global configuration
bar: bar
```

```yaml
# system global configuration
bar: buzz
```

you get:

```yaml
foo: foo
bar: bar
```

`bar: buzz` is overwritten.

