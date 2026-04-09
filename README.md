# OCTOPUS-GAME-AI-SHARE

一个用于公司内部技术分享的 AI Coding 演示 Deck 项目。

这个仓库不是传统 PPT，而是一个基于静态网页的分享材料：`index.html` 负责展示壳与渲染逻辑，`sections/*.md` 负责各章节内容。这样可以像写文档一样迭代分享内容，也方便后续持续调整结构和表达。

## 项目特点
- 使用 `Markdown + HTML` 组织整场分享内容
- 用单页静态站方式展示，不依赖构建系统
- 支持 Mermaid 图表与代码高亮
- 适合快速修改章节顺序、文案和叙事结构

## 目录结构
- `index.html`：演示主页面、导航、Markdown 渲染与 Mermaid 渲染逻辑
- `sections/`：分享章节内容来源
- `docs/`：设计草稿、规划文档与补充材料
- `start_sharing.sh`：本地启动分享页面
- `ai-share.sh`：本地启动脚本（包含固定路径）
- `CLAUDE.md`：项目协作说明

## 快速开始
在仓库根目录执行：

```bash
python3 -m http.server 8000
```

然后打开：

```bash
http://localhost:8000/index.html
```

也可以使用项目自带脚本：

```bash
bash start_sharing.sh
bash ai-share.sh
```

## 不启动服务时如何查看
如果你暂时不想启动本地 HTTP 服务，也可以直接查看源码内容：
- 直接打开 `sections/*.md`，查看每一章的原始分享文案
- 打开 `index.html`，查看页面结构、导航顺序和渲染逻辑
- 使用支持 Markdown 预览的编辑器阅读 `sections/*.md`

注意：这种方式只能查看原始内容，**不能完整预览最终演示效果**。因为章节加载依赖浏览器通过 HTTP `fetch` 读取 `sections/*.md`，直接打开 `index.html` 的 `file://` 页面通常会加载失败。

## 内容章节
当前内容按章节拆分在 `sections/` 中维护：
- `00-cover.md`：封面与开场
- `01-intro.md`：为什么现在要讲 AI Coding
- `02-models.md`：先看模型层
- `03-cli.md`：产品与执行体系（为什么竞争转到执行体系）
- `02-terms.md`：调用链路与执行机制（Harness 如何组织执行能力）
- `03-ccswitch.md`：CC Switch（个人 AI 工作台的统一控制台）
- `03-claude-tips.md`：Claude Code 的 15 点实用技巧
- `04-sdlc.md`：AI 如何真正进入研发闭环
- `06-future.md`：角色演进与结尾

如果新增、重命名或调整章节顺序，需要同步更新 `index.html` 中的导航配置，以及 `sections/01-intro.md` 里的“讲述路径”说明。 

## 注意事项
- 这是纯静态项目，没有构建步骤，也没有测试框架。
- 需要通过 HTTP 服务访问，直接打开 `file://` 会导致章节加载失败。
- `ai-share.sh` 中包含绝对路径，如果仓库位置变化，需要手动更新。
- Mermaid、Markdown 渲染和代码高亮依赖 CDN 资源，离线环境下可能无法正常展示。
