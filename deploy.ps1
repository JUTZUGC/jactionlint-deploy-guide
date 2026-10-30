# jactionlint 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://jactionlint.jdx.dev
# 更新日期：2026-10-31
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fL -o jactionlint.zip https://github.com/jdx/jactionlint/releases/download/v2.4.0/jactionlint_2.4.0_windows_amd64.zip
$h=(Get-FileHash .\jactionlint.zip -Algorithm SHA256).Hash.ToLower()
if ($h -ne "4e0c7b428a4faa35bb3b86af6fa65a0ac9797edcd4c64e4f7e16ca886437e172") { throw "SHA256 校验失败" }
Expand-Archive -Path .\jactionlint.zip -DestinationPath .\jactionlint -Force
Write-Host "校验通过：在仓库根目录运行 .\jactionlint\jactionlint.exe"

Write-Host ''

Write-Host '下载与校验完成，安装包在 .download 目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://jactionlint.jdx.dev'
