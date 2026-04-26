# RE0 - 从零开始的生图生活 (Starting Image Generation in Another World)

基于 `boxying-image-gateway` 后端能力的异世界风格专业图像创作安卓应用。

## 🌌 视觉方案 (Visual Identity)
- **配色 (Palette)**:
  - `Royal White`: #FDFDFD (主背景 - 爱蜜莉雅的礼服)
  - `Witch's Lavender`: #E6E6FA (辅助色 - 魔法气息)
  - `Crystal Blue`: #4682B4 (交互色 - 魔石/玛那)
  - `Midnight Shadow`: #2C3E50 (深色模式/阴影 - 嫉妒魔女的低语)
- **字体 (Typography)**: 
  - 标题使用具有魔法契约感的衬线体。
  - 正文使用清晰易读的无衬线体。

## 📜 核心术语 (Glossary)
| 原术语 | RE0 术语 | 描述 |
| :--- | :--- | :--- |
| Generate Image | **咏唱 (Chanting)** | 消耗玛那，向世界根源寻求图像。 |
| Edit Image | **死亡回归 (Return by Death)** | 基于旧有结果，回溯时间并修正细节。 |
| Prompt | **咒文 (Spells)** | 引导魔法流向的关键语言。 |
| Quota | **玛那 (Mana)** | 维持生图契约的魔力储备。 |
| History | **记忆回廊 (Corridor of Memories)** | 记录过往所有轮回中诞生的影像。 |

## 🛠 技术架构 (Tech Stack)
- **Framework**: Flutter (Dart)
- **State Management**: Riverpod (提供响应式且安全的玛那管理)
- **Networking**: Dio (异世界网关通讯)
- **Theme**: Custom Theme Extension (实现卷轴与魔石质感)

## 🏗 功能模块
1. **魔法终端 (The Terminal)**: 输入咒文，选择“咏唱”参数。
2. **契约监控 (Covenant Monitor)**: 实时展示剩余玛那。
3. **回廊镜像 (Mirrors of Memory)**: 浏览并交互历史图片。
4. **圣域设置 (The Sanctuary)**: 配置上游网关地址与契约密钥。
