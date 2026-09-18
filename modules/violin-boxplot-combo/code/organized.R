# =============================================================================
# 提琴图加箱线显著性组合图
# organized：线性脚本 + 中文分节；路径相对本条目目录
# =============================================================================

script_dir <- tryCatch(
  dirname(normalizePath(sys.frame(1)$ofile)),
  error = function(e) {
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- grep("^--file=", args, value = TRUE)
    if (length(file_arg)) dirname(normalizePath(sub("^--file=", "", file_arg))) else normalizePath(getwd())
  }
)
root <- if (basename(script_dir) == "code") dirname(script_dir) else script_dir
out_dir <- file.path(root, "output", "figures")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# =========================================================
# 1. 加载包
# =========================================================
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(ggpubr)
})

# =========================================================
# 2. 示例数据（使用 IRIS 内置数据集，仅作演示）
# =========================================================
data(iris)
data <- data.frame(
  Region = iris$Species,
  Value  = iris$Sepal.Length
)

# =========================================================
# 3. 自定义配色（3 个组）
# =========================================================
fill_cols <- c("#4E79A7", "#F28E2B", "#59A14F")

# =========================================================
# 4. 自定义主题
# =========================================================
theme_clean_pub <- function(base_size = 14) {
  theme_bw(base_size = base_size) +
    theme(
      panel.grid.minor   = element_blank(),
      panel.grid.major   = element_line(linewidth = 0.3, color = "grey90"),
      panel.border       = element_rect(color = "black", linewidth = 0.8),
      axis.text          = element_text(color = "black"),
      axis.title         = element_text(face = "bold"),
      plot.title         = element_text(face = "bold", hjust = 0.5),
      strip.background   = element_blank()
    )
}

# =========================================================
# 5. 绘图
# =========================================================
p_combo <- ggplot(data, aes(x = Region, y = Value, fill = Region)) +
  geom_violin(
    trim  = FALSE,
    color = NA,
    alpha = 0.28,
    width = 0.9
  ) +
  geom_boxplot(
    width         = 0.22,
    linewidth     = 1.6,
    color         = "black",
    outlier.shape = NA,
    alpha         = 1
  ) +
  stat_summary(
    fun   = mean,
    geom  = "point",
    shape = 23,
    size  = 4,
    fill  = "white",
    color = "black",
    stroke = 1.4
  ) +
  scale_fill_manual(values = fill_cols) +
  labs(
    title = "Distribution of Sepal Length by Species",
    x     = "Species",
    y     = "Sepal Length"
  ) +
  theme_clean_pub() +
  theme(
    legend.position = "none",
    aspect.ratio    = 1
  )

print(p_combo)

# =========================================================
# 6. 显著性标注
# =========================================================
comparisons <- combn(as.character(unique(data$Region)), 2, simplify = FALSE)

p_sig <- p_combo +
  stat_compare_means(
    method        = "t.test",
    comparisons   = comparisons,
    label         = "p.label",
    bracket.size  = 0.4,
    tip.length    = 0.01,
    step_increase = 0.08
  )

print(p_sig)

# =========================================================
# 7. 输出图片
# =========================================================
ggsave(file.path(out_dir, "violin_boxplot_combo.png"),
       plot = p_combo, width = 7, height = 6, dpi = 300, bg = "white")
ggsave(file.path(out_dir, "violin_boxplot_combo_sig.png"),
       plot = p_sig, width = 7, height = 6, dpi = 300, bg = "white")

# =========================================================
# 8. 生成 preview.png（保存至模块根目录）
# =========================================================
ggsave(file.path(root, "preview.png"),
       plot = p_sig, width = 7, height = 6, dpi = 300, bg = "white")
