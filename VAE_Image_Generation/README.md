# Conditional β-VAE with Importance Sampling on MNIST

## Project Overview
This project implements a **Conditional Variational Auto-Encoder (C-VAE)** with **β-annealing** and **Importance Sampling** from scratch using **PyTorch**. [cite_start]The model is designed to perform class-conditioned image generation and reconstruction while learning a structured latent representation of the MNIST dataset[cite: 4, 90, 166].

## Technical Implementation
### 1. Architecture
* [cite_start]**Conditional Encoder**: Maps input images ($28 \times 28$) and their corresponding labels (one-hot encoded) to a 16-dimensional latent space[cite: 17, 18, 50, 56].
* [cite_start]**Conditional Decoder**: Reconstructs the image from the latent vector $z$ and the class label $y$ using a sigmoid activation for pixel-intensity output[cite: 83, 87].
* [cite_start]**Reparameterization**: Standard $z = \mu + \sigma \odot \epsilon$ trick used to allow backpropagation through stochastic nodes[cite: 103, 109, 110].



### 2. Loss Function & Enhancements
* [cite_start]**ELBO with Importance Sampling**: Implemented the Evidence Lower Bound (ELBO) using importance sampling ($L=5$) to provide a more accurate estimate of the log-likelihood[cite: 25, 125, 144].
* [cite_start]**β-Annealing**: Gradually scales the KL divergence term during training (from $0.0$ to $1.0$) to balance reconstruction accuracy with latent space regularization[cite: 23, 174, 177].
* [cite_start]**Early Stopping**: Monitored validation loss with a patience of 20 epochs to prevent overfitting[cite: 22, 169, 198].

## Dataset & Preprocessing
* [cite_start]**Augmentation**: Applied `RandomHorizontalFlip` (p=0.5) and `RandomRotation(15)` to the training set to increase model robustness[cite: 29, 31, 35].
* [cite_start]**Normalization**: Images were converted to tensors and pixel values normalized to the range $[0, 1]$[cite: 33, 34].

## Results and Analysis

### Training Dynamics
* [cite_start]**Overfitting**: The model reached its best performance around epoch 10. Beyond this point, training loss continued to decrease while validation loss began to rise, signaling overfitting[cite: 433, 446].
* [cite_start]**Optimization**: Training was halted at epoch 25 via the early stopping mechanism[cite: 360, 446].



### Latent Space Visualization
Using **t-SNE** to project the 16D latent space into 2D, the following observations were made:
* [cite_start]**Clustering**: The VAE successfully learned to group most digits into distinct, clear clusters (notably 0, 1, and 7)[cite: 409, 410, 439].
* [cite_start]**Similarity Overlap**: Digits with similar structural features, such as 3, 5, and 8, show partial overlap in the latent space[cite: 411, 440].



### Image Generation Quality
* [cite_start]**Clear Reconstructions**: Simple digits like 7, 2, 0, and 1 are clear and easily recognizable[cite: 375, 442].
* [cite_start]**Blurriness**: Complex digits like 4 and 9 exhibit slight blurriness, indicating the model struggles with finer details of complex shapes[cite: 376, 377, 442].

## Repository Structure
* [cite_start]`CVAE_Model.py`: Main implementation including Encoder, Decoder, and Training loop[cite: 44, 72, 90, 166].
* [cite_start]`vae_best_model.pth`: Saved state dictionary of the best-performing model[cite: 203].
* [cite_start]`Visualizations/`: Contains t-SNE plots and reconstruction comparisons[cite: 240, 263].

## Requirements
* `torch`
* `torchvision`
* `numpy`
* `matplotlib`
* `scikit-learn` (for t-SNE)
