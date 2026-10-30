#!/usr/bin/env bash
set -euo pipefail
# jactionlint 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://jactionlint.jdx.dev
# 更新日期：2026-10-31
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fL -o jactionlint.tar.gz https://github.com/jdx/jactionlint/releases/download/v2.4.0/jactionlint_2.4.0_linux_amd64.tar.gz
echo "26ddba81db28fffc51163175c070ee1a9d1150260de4b5232f01d9b749f32d8e  jactionlint.tar.gz" | sha256sum -c -
tar -xzf jactionlint.tar.gz
echo "校验通过：在仓库根目录运行 ./jactionlint"

echo ""

echo "下载与校验完成，安装包在 .download 目录"
echo "若结果异常或需要改配置，请参考官方文档：https://jactionlint.jdx.dev"
