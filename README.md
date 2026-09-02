#  Network Data: Human Connectome Analysis

![Language](https://img.shields.io/badge/Language-R-blue)
![Course](https://img.shields.io/badge/Course-Statistical and Computational Methods for Network Data-brightgreen)
![Status](https://img.shields.io/badge/Status-Completed-success)

##  Overview
Statistical and computational network analysis of the human connectome using graph theory and Exponential Random Graph Models (ERGM). This project investigates the structural topology, biological efficiency, and resilience of the human brain network, moving from data denoising to targeted lesion simulations.

##  Academic Context
* **Authors:** Giorgia Cappellato, Matteo Cristina, Elisa Quadrini
* **Course:** Statistical and Computational Methods for Network Data

##  Dataset & Preprocessing
The network is built upon Diffusion MRI (dMRI) scans of 477 healthy individuals from the Human Connectome Project (HCP), mapped across 1,015 distinct brain regions. 
* **Nodes:** Grey matter regions (primarily in the cortex).
* **Edges:** White matter nerve fibers (axons) weighted by mean fiber count and median electrical connectivity.
* **Distance-Dependent Thresholding:** Instead of a rigid consensus threshold that overly penalizes long-range connections, we implemented an adaptive, dynamically decaying exponential threshold based on physical fiber length. This successfully filtered out short-range biological noise while preserving crucial inter-hemispheric highways.

##  Key Findings & Network Architecture

### 1. Scale-Free Tail & Biological Constraints
Using Maximum Likelihood Estimation (MLE) and KS-statistic minimization, we analyzed the heavily right-skewed degree distribution. 
* A power-law behavior emerges strictly for hubs with $x_{min} \ge 57$ connections ($p=0.408$).
* The steep scaling exponent ($\alpha = 4.29$) reflects a strict biological constraint: skull volume and ATP consumption force massive hubs to decay much faster than in standard scale-free networks.

### 2. Hub Efficiency & Brain Lateralization
By calculating an electrical-to-fiber strength ratio, we uncovered two distinct evolutionary strategies in the subcortical core (which houses 8 of the top 10 hubs):
* **Putamen:** Acts as a massive physical highway, relying on raw fiber volume.
* **Caudate:** Uses fewer connections but highly optimizes them for maximum electrical signal transmission.

### 3. Vulnerability & Lesion Simulation
We simulated structural brain lesions to track the collapse of the Largest Connected Component (LCC):
* **Random Failure:** Simulates normal aging; the network degrades gracefully and linearly.
* **Targeted Attack:** Simulates neurodegenerative diseases (e.g. Alzheimer's) by removing the highest-degree hubs first, resulting in a rapid, catastrophic fragmentation of the connectome.

### 4. Community Detection (Louvain Algorithm)
The Louvain algorithm naturally segregated the connectome into structurally dense cliques without prior spatial coordinates. The mathematical modularity perfectly matched anatomical functions, splitting the brain along the midline and grouping regions by task (e.g. Frontal/Central for motor control; Parietal/Occipital for sensory integration).

### 5. Exponential Random Graph Models (ERGM)
We fit multiple ERGMs to understand the probabilistic rules of brain wiring. Our final validated model (Model 3) confirmed that:
* The baseline connection probability is extremely sparse (~2.72%).
* There is a strong homophily based on tissue type and hemisphere.
* Subcortical structures exhibit a massive, statistically significant propensity to form connections compared to peripheral regions.

## 🚀 How to Reproduce this Project

This project uses `renv` to ensure full reproducibility and to lock package versions.

1. Clone this repository:
   ```bash
   git clone [https://github.com/yourusername/human-connectome-analysis.git](https://github.com/yourusername/human-connectome-analysis.git)
