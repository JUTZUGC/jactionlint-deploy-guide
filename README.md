# jactionlint 一键安装指南

> 第三方部署指南 · 非 jactionlint 官方仓库。官方项目：[jdx/jactionlint](https://github.com/jdx/jactionlint)
> 内容来自官方文档（2026-10-31）。项目迭代快，请以[官方文档](https://jactionlint.jdx.dev)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用等 CI 跑完才发现：触发器拼错、表达式类型不对、脚本里塞了不可信输入，本地一次全查出来。

⚠️ 支持 Windows、macOS、Linux（含 arm64），发布包是单个可执行文件，无需运行环境。默认完全离线，只有显式加 `--online` 才会向 GitHub 查询仓库是否归档、提交是否伪造、有无已发布的安全公告。shellcheck 与 pyflakes 的脚本检查需要本机有对应工具，官方 Docker 镜像里已经内置。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/jactionlint-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统下载发布包，比对 SHA256 后解压，再拿仓库里的工作流跑一次检查，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## jactionlint 是什么？

jactionlint 是开源的一个静态检查器，把 GitHub Actions 工作流里的写错、类型错和脚本注入风险提前挑出来（协议：MIT，<img src="https://img.shields.io/github/stars/jdx/jactionlint?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

检查 GitHub Actions 的正确性与安全性：未知键与事件、表达式里的类型错误、action 输入不匹配、needs 与 cron 写错，以及脚本注入、权限过大、危险触发器、缓存投毒等风险模式。

- 正确性检查：覆盖 actionlint 的全部规则
- 安全检查：对齐 zizmor 的审计思路
- 可自动修：`--fix` 处理机械性问题，`--diff` 先看改动
- 渐进接入：用 profile 控制检查强度，baseline 只报新增问题
- 默认离线：不加 `--online` 不联网
- 单文件分发：三平台免运行环境

（来源：[官方仓库](https://github.com/jdx/jactionlint)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 3 | 0 |
| 单 | 文 |
| 正 | 确 |
| 能 | 自 |
| 默 | 认 |
| 作 | 者 |

| 需要注意 | 说明 |
|---|---|
| 安 | 全 |
| 脚 | 本 |
| 名 | 字 |
| 规 | 则 |
| 项 | 目 |

> 以上基于官方文档与社区反馈整理（2026-10-31），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -o jactionlint.tar.gz https://github.com/jdx/jactionlint/releases/download/v2.4.0/jactionlint_2.4.0_linux_amd64.tar.gz
echo "26ddba81db28fffc51163175c070ee1a9d1150260de4b5232f01d9b749f32d8e  jactionlint.tar.gz" | sha256sum -c -
tar -xzf jactionlint.tar.gz
echo "校验通过：在仓库根目录运行 ./jactionlint"
```

安装包来源：[https://github.com/jdx/jactionlint/releases/tag/v2.4.0](https://github.com/jdx/jactionlint/releases/tag/v2.4.0)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认单文件发布、三平台包与安装方式 | 已核对 2026-10-31 |
| Release v2.4.0 的 Windows 与 Linux 校验值已下载核对 | 已核对 2026-10-31 |
| 未实测检查执行与 --fix | 说明 2026-10-31 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-31 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-31 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装步骤、校验方式与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-31）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\jactionlint-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 发布包对照（v2.4.0）

| 平台 | 文件 | 大小 |
|---|---|---|
| Windows x64 | jactionlint_2.4.0_windows_amd64.zip | 7.19 MB |
| Windows arm64 | jactionlint_2.4.0_windows_arm64.zip | 6.46 MB |
| macOS Intel | jactionlint_2.4.0_darwin_amd64.tar.gz | 7.22 MB |
| macOS Apple Silicon | jactionlint_2.4.0_darwin_arm64.tar.gz | 6.49 MB |
| Linux x64 | jactionlint_2.4.0_linux_amd64.tar.gz | 6.99 MB |
| Linux arm64 | jactionlint_2.4.0_linux_arm64.tar.gz | 6.34 MB |

Release 里带 `jactionlint_2.4.0_checksums.txt`，可一次核对全部文件。

## 其它安装方式

```bash
mise use -g jactionlint          # 推荐，跨平台
brew tap jdx/jactionlint https://github.com/jdx/jactionlint
uvx jactionlint                  # 不安装直接用
pipx install jactionlint
go install github.com/jdx/jactionlint/v2/cmd/jactionlint@latest
```

注意：Homebrew core 里的 `actionlint` 是原项目，不是这个 fork。

## 第一次使用

```bash
cd 你的仓库
jactionlint                # 检查工作流、复合 action、dependabot.yml 与 lock 文件
jactionlint --diff         # 先看 --fix 会改什么
jactionlint --fix          # 自动修机械性问题
jactionlint .github/workflows/ci.yml   # 只查指定文件
```

退出码为 1 表示仍有 `error` 级问题，可直接串进 CI。

## 注意

- 默认不联网，加 `--online` 才会查归档仓库、伪造提交与安全公告
- `run:` 里的 shell、Python 脚本检查依赖本机有 shellcheck / pyflakes
- 不加参数时在仓库根目录执行，否则找不到工作流
- baseline 模式下只报新增问题，老问题不会一次性刷屏
- MIT 协议，可商用

## 常见坑

- 校验失败：重新下载，确认文件名与校验串一致
- Windows 拦执行：右键属性解除锁定，或核对 SHA256 后再放行
- 装成了 actionlint：确认包名是 jactionlint，Homebrew core 那个不是
- 找不到工作流：在仓库根目录执行，或显式传文件路径
- 误报太多：先用 profile 降低强度，或加 baseline
- 脚本检查缺失：装 shellcheck（Shell）与 pyflakes（Python）
- CI 里报错但本地正常：确认两端工具链与规则版本一致

## 免责声明

本仓库为第三方指南，与 jactionlint 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-31），项目迭代快，请以[官方文档](https://jactionlint.jdx.dev)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
