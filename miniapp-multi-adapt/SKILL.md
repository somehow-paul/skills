---
name: miniapp-multi-adapt
description: UniApp 小程序多端适配规则与检查清单。When modifying any files under miniapp/ (pages, pages-tab, pages-sub, components, styles, composables, utils), use this skill to prevent simulator-vs-device UI differences, enforce safe-area handling, avoid fragile viewport math, and run required validation before finishing.
---

# Miniapp Multi Adapt

## Overview

在修改 `miniapp/` 下代码时，严格按本技能执行，优先保证微信开发者工具模拟器、iOS 真机、Android 真机的一致性。

## Mandatory Rules

### 1) Viewport And Layout

- 禁止新增页面根容器的脆弱组合：`height: 100vh` + `overflow: hidden`。
- 优先使用可伸缩布局：`display: flex` + 动态测量列表高度。
- 列表可视区高度必须基于真实测量值，不依赖固定头部高度魔法值。
- 固定底部操作栏必须给内容区预留底部空间，避免遮挡最后一屏内容。

### 2) Safe Area Strategy

- 安全区读取顺序必须一致：
  1. `uni.getWindowInfo()`
  2. 项目封装 `getSystemInfo()`
  3. 项目封装 `getSafeAreaInsets()` 兜底
- `safeAreaInsets` 取值为 `0` 时必须做兜底，不能直接使用。
- 顶部区域使用 `env(safe-area-inset-top)` 时，仍需在 TS 逻辑里保留兜底高度计算。

### 3) Scroll And Fixed Components

- `scroll-view` 与 `position: fixed` 共存时，必须在滚动内容增加 `padding-bottom: calc(... + env(safe-area-inset-bottom))`。
- 避免页面级多重滚动容器互相嵌套，优先保持单一主滚动区域。
- 发生筛选栏展开、分类切换、横竖屏变化时，必须触发列表高度重算（如 `onShow/onResize`）。

### 4) Units And Text Stability

- 间距和尺寸优先 `rpx`；细线和边框可用 `1px`/半像素方案。
- 不要依赖“固定高度等于固定行高”的文本布局作为核心结构。
- 字体导致的换行差异要有容错（`min-height`、ellipsis、可扩展容器）。

### 5) ID Precision Safety

- 后端 Long 主键在小程序端必须全链路按 `string` 透传。
- 禁止对主键做 `Number(id)`、`parseInt(id)`、`+id` 后再请求接口。

## Execution Workflow

### Step 1: Pre-check Hotspots

在改动前先快速扫描目标文件是否存在高风险模式：

- `100vh`
- `overflow: hidden`
- `position: fixed`
- `safeAreaInsets?.top` / `safeAreaInsets?.bottom`
- `Number(id)` / `parseInt(id)` / `+id`

### Step 2: Implement With Minimal Risk

- 优先做最小改动，不重写页面结构。
- 先修正高度计算和安全区兜底，再调整样式。
- 保持现有业务逻辑不变，只修复跨端显示不一致问题。

### Step 3: Required Validation

完成后至少执行：

```bash
cd miniapp
npm run type-check
```

涉及布局改动时，补充真机回归清单：

- iOS 刘海屏：顶部是否遮挡、底部是否露白
- Android 常见机型：滚动区域是否可到底、固定栏是否遮挡
- 切前后台后：列表高度是否恢复正常

## Done Criteria

满足以下条件才可结束：

- 无新增 `100vh + overflow: hidden` 页面根容器组合
- 安全区读取具备统一兜底路径
- 关键滚动页面无底部遮挡、无顶部错位
- `type-check` 通过
