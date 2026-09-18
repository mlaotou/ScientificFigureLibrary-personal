rm(list = ls())

library(ggtern)
library(RColorBrewer)
library(grid)
library(scales)

# 内嵌示例数据
data_text <- "ID	A	B	C
OTU799	0	0	0
OTU768	3	3	8
OTU711	3	23	1
OTU943	4	1	14
OTU1091	0	0	3
OTU434	8	6	10
OTU788	0	0	3
OTU1151	0	0	0
OTU501	2	0	1
OTU500	3	3	6
OTU503	8	26	6
OTU502	21	55	26
OTU505	0	0	0
OTU504	1	7	0
OTU507	3	9	10
OTU506	0	0	9
OTU509	2	2	2
OTU508	2	5	8
OTU804	1	0	1
OTU712	1	1	1
OTU1090	2	0	0
OTU1156	0	4	1
OTU1106	1	3	2
OTU480	1	1	1
OTU481	1	0	3
OTU482	4	6	4
OTU483	16	39	28
OTU484	0	0	1
OTU485	0	1	0
OTU338	31	41	25
OTU339	0	3	1
OTU336	1	6	4
OTU337	54	62	65
OTU334	12	8	5
OTU335	0	0	0
OTU332	0	0	0
OTU333	9	2	8
OTU330	19	20	48
OTU331	11	12	13
OTU1093	0	2	0
OTU928	0	1	1
OTU730	3	1	2
OTU806	0	0	0
OTU950	1	1	0
OTU805	1	1	1
OTU349	0	1	0
OTU348	1	3	4
OTU439	33	29	24
OTU438	2	16	4
OTU343	7	1	16
OTU342	9	3	3
OTU341	1	0	2
OTU340	6	26	9
OTU347	29	17	39
OTU346	5	1	4
OTU345	40	35	10
OTU344	1	1	1
OTU655	3	0	21
OTU654	8	12	9
OTU158	24	12	41
OTU159	1	2	2
OTU651	0	3	0
OTU650	0	1	5
OTU653	1	2	3
OTU652	3	5	2
OTU152	13	14	19
OTU153	3	2	17
OTU150	5	1	8
OTU151	20	0	2
OTU156	73	71	154
OTU157	2	2	5
OTU154	2	0	0
OTU155	10	8	9
OTU938	0	5	2
OTU939	0	0	0
OTU1020	0	0	0
OTU924	0	0	1
OTU930	0	0	0
OTU888	0	0	0
OTU932	6	8	2"

# 加载数据
df <- read.table(text = data_text, sep = "\t", header = TRUE, check.names = FALSE)

# 创建分组信息数据集
df$group <- rep(c("T", "D", "L", "K"), each = 20)

# 计算3个样本的平均值定义点的大小
df$size <- (apply(df[2:4], 1, mean))

# 配色
col <- colorRampPalette(brewer.pal(11, "Set1"))(4)

# 背景色
color <- colorRampPalette(brewer.pal(11, "PuOr"))(30)

# 绘图
p <- ggtern(data = df, aes(x = A, y = B, z = C)) +
  geom_mask() +
  geom_point(aes(size = size, color = group), alpha = 0.8) +
  scale_colour_manual(values = col) +
  guides(color = guide_legend(override.aes = list(size = 4))) +
  theme_classic() +
  labs(title = "Ternary plot") +
  theme(axis.line = element_line(linetype = 1, color = "grey", size = 1),
        plot.title = element_text(size = 15, hjust = 0.5))

# 添加背景
print(p)
grid.raster(alpha(color, 0.1),
            width = unit(1, "npc"),
            height = unit(1, "npc"),
            interpolate = TRUE)
