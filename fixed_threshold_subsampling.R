edges = read.csv("all_20k.csv/edges.csv") 
nodes = read.csv("all_20k.csv/nodes.csv") 

library(igraph)
library(ggplot2)
library(dplyr)
library(ggrepel)
library(patchwork)

g <- graph_from_data_frame(d = edges, vertices = nodes, directed = FALSE)
g <- simplify(g, remove.multiple = FALSE, remove.loops = TRUE)

thresholds <- 1:477
percolation_results <- data.frame(
  Threshold = integer(), 
  LCC_Proportion = numeric(), 
  Density = numeric()
)

total_nodes <- vcount(g)

for (x in thresholds) {
  edges_to_keep <- E(g)[E(g)$occurences >= x]
  
  sub_g <- subgraph.edges(g, eids = edges_to_keep, delete.vertices = FALSE)
  
  comp <- components(sub_g)
  lcc_size <- max(comp$csize)
  lcc_proportion <- lcc_size / total_nodes
  
  dens <- edge_density(sub_g)
  

  percolation_results <- rbind(
    percolation_results, 
    data.frame(Threshold = x, LCC_Proportion = lcc_proportion, Density = dens)
  )
}




p_lcc <- ggplot(percolation_results, aes(x = Threshold, y = LCC_Proportion)) +
  geom_line(color = "#8e44ad", size = 1.2) +
  geom_vline(xintercept = 238, linetype = "dashed", color = "gray50") + # 50% marker
  theme_minimal() +
  labs(
    title = "Network Percolation: Largest Connected Component (LCC)",
    subtitle = "Tracking network fragmentation as rare edges are removed",
    x = "Occurrence Threshold (Number of Subjects)",
    y = "Proportion of Nodes in Main Component"
  ) +
  theme(plot.title = element_text(face = "bold", size = 14))


p_density <- ggplot(percolation_results, aes(x = Threshold, y = Density)) +
  geom_line(color = "#d35400", size = 1.2) +
  theme_minimal() +
  labs(
    title = "Network Density Decay",
    subtitle = "Tracking the elimination of biological noise and spurious tracts",
    x = "Occurrence Threshold (Number of Subjects)",
    y = "Global Edge Density"
  ) +
  theme(plot.title = element_text(face = "bold", size = 14))

print(p_lcc)
print(p_density)


chosen_threshold <- 238
edges_to_keep <- E(g)[E(g)$occurences >= chosen_threshold]
sub_g_temp <- subgraph.edges(g, eids = edges_to_keep, delete.vertices = FALSE)
comp <- components(sub_g_temp)
lcc_id <- which.max(comp$csize) 
g_denoised <- induced_subgraph(sub_g_temp, V(sub_g_temp)[comp$membership == lcc_id]) # keep only the main component
