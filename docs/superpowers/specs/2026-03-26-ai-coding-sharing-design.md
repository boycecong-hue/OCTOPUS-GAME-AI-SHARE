# AI Coding 技术分享会设计方案 (2026)

## 1. 项目背景
公司内部 AI 技术分享，旨在提升研发团队对前沿 AI Coding 工具（尤其是 CLI 类）的认知与实操能力，推动研发全链路（SDLC）的 AI 化转型。

## 2. 核心目标
- **认知对齐**：理清 Agent、Copilot、Skill、MCP 等核心术语。
- **工具普及**：掌握 Claude Code、Gemini CLI 的核心用法与场景。
- **流程重塑**：演示 AI 如何贯穿从初始化、TDD 开发到质量保证的全生命周期。
- **安全规范**：明确企业级落地的隐私边界与合规操作。

## 3. 交付物架构
本项目采用 **交互式 Web 页面 (SPA)** 形式替代传统 PPT，增强演示的极客感与互动性。

### 3.1 页面模块
1. **引导页 (Intro)**：背景、愿景与开发者范式转移。
2. **术语地图 (Terminology)**：
   - LLM vs. Copilot vs. Agent 对比。
   - Skill vs. MCP 深度解析。
   - 知识增强路径对比 (RAG vs. Long Context)。
3. **CLI 工具实战 (CLI Suite)**：
   - Claude Code：任务驱动、自主执行、跨文件重构。
   - Gemini CLI：超长上下文分析、多模态架构扫描。
   - Codex/API：原子化工具、自定义提效脚本。
4. **全链路演示 (SDLC Workflow)**：
   - 场景：微服务模块的从零开发。
   - 步骤：初始化 -> TDD 循环 -> 文档自动化。
5. **企业落地 (Enterprise)**：
   - 安全边界 (`.claudignore`)。
   - 团队别名 (Alias) 与规范。

### 3.2 交互技术栈
- **前端**：Vanilla HTML5 / CSS3 (Inter 字体, Fira Code 字体) / Vanilla JS。
- **风格**：现代简约、硬核终端感。
- **特性**：侧边导航跳转、模拟终端组件、离线单文件运行。

## 4. 易混淆概念对比表 (核心内容摘要)

| 概念 | 核心比喻 | 关键特征 |
| :--- | :--- | :--- |
| **Skill** | AI 的“手” | 工具内置的可执行动作 (Action)。 |
| **MCP** | AI 的“标准插座” | 开放协议，连接外部数据 (Data Sources)。 |
| **Agent** | AI 的“代驾” | 目标驱动 (Goal-driven)，具备自主性。 |
| **Copilot** | AI 的“导航员” | 预测驱动 (Predictive)，依赖人工引导。 |

## 5. 后续计划
1. [x] 完成交互式 HTML 大纲。
2. [x] 编写讲演者备注与脚本。
3. [ ] 准备实操 Demo 仓库（包含 `tests`, `src`, `.claudignore` 等）。
4. [ ] 进行模拟分享演练。
