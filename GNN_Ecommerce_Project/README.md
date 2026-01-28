# E-commerce Product Classification using Graph Neural Networks (GNNs)

## Overview
This project demonstrates a real-world application of **Graph Neural Networks (GNNs)** for e-commerce product classification. Instead of treating products as independent data points, the project models **co-purchasing relationships** between products as a graph, allowing the model to learn from both product features and relational structure.

The work is motivated by real-world use cases such as **product categorisation, recommendation systems, and catalogue enrichment** used by large e-commerce platforms.

---

## Problem Formulation
- **Task:** Node classification  
- **Nodes:** Products  
- **Edges:** Co-purchasing relationships between products  
- **Goal:** Predict the category of each product using both node features and graph structure  

This formulation enables the model to capture dependencies between related products that traditional machine learning models often ignore.

---

## Dataset
- **Amazon Computers Dataset** (via PyTorch Geometric)
- Publicly available real-world e-commerce dataset
- Node features were normalised
- Dataset split into training, validation, and test sets

---

## Model Architecture
- Custom **3-layer Graph Convolutional Network (GCN)**
- Skip connections to reduce over-smoothing
- Dropout for regularisation
- ReLU activations and log-softmax output

The architecture was intentionally designed and tuned rather than directly reusing a workshop or tutorial model.

---

## Training & Evaluation
- Framework: **PyTorch & PyTorch Geometric**
- Evaluation metric: **Accuracy**
- **Test Accuracy Achieved:** **74.44%**

---

## Ablation Study & Analysis
To validate architectural choices, ablation studies were conducted by:
- Removing skip connections
- Reducing GCN depth
- Comparing against a baseline GCN model

These experiments showed clear performance degradation when key components were removed, confirming the effectiveness of the proposed design.

---

## Visualisation
The project includes:
- Graph structure visualisation
- Training and validation learning curves
- Performance comparison across model variants

These visualisations help interpret model behaviour and training dynamics.

---

## Tools & Technologies
- Python
- PyTorch
- PyTorch Geometric
- NumPy
- Matplotlib
- Graph Neural Networks (GCN)

---

## Repository Structure
