# violin-boxplot-combo 详细使用说明

## 模块结构

modules/violin-boxplot-combo/
- code/organized.R    # 主绘图脚本
- module.yml          # 元数据清单
- README.md           # 简要说明
- description.md      # 详细描述
- provenance.md       # 来源声明
- preview.png         # 主预览图（脚本自动生成）
- thumbnail.jpg       # 缩略图

## 运行方式

1. 安装 R 并加载以下包：ggplot2, dplyr, ggpubr
2. 将 code/organized.R 中 data 部分替换为你自己的数据框
3. 数据框需包含两列：分组变量（如 Region）和数值变量（如 Value）
4. 运行脚本，输出图片保存在 output/figures/ 目录下

## 数据格式要求

data <- data.frame(
  Region = factor(c("group1", "group2", ...)),
  Value  = c(数值, 数值, ...)
)

- Region：分组变量，建议因子类型，水平顺序决定 x 轴排列
- Value：连续型数值变量

## 可选参数调整

| 参数 | 说明 | 默认值 |
|------|------|--------|
| fill_cols | 分组颜色向量 | c("#4E79A7", "#F28E2B", "#59A14F") |
| base_size | 主题字号 | 14 |
| bracket.size | 显著性横线粗细 | 0.4 |
| step_increase | 显著性括号高度递增 | 0.08 |
| method | 统计检验方法 | "t.test"（改为 "wilcox.test" 做非参数检验） |

## 替换为自定义数据

# 将第 2 节的示例数据替换为：
data <- read.csv("your_data.csv")  # 确保含 Region 和 Value 两列
data$Region <- factor(data$Region)
