# 三元相图 Ternary Plot

基于 ggtern 包的 R 语言绘图模板，展示三个组分的组成关系。

## 快速开始

```r
source("code/main.R")
```

## 依赖包

- ggtern
- RColorBrewer
- grid
- scales

## 数据格式

示例数据已内嵌在代码中。用户替换数据时，需保持以下格式：
- 三列数值数据（A, B, C）
- 可选的 ID 列

## 输出

生成三元相图 PNG，包含：
- 三角形边界和背景
- 按分组着色的散点
- 点大小反映平均值
