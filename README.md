## Notebook tutorials and explorations of machine learning on Google Kubernetes Engine.

Work in progress!


Rough idea for content:

### Introductory

How to set up clusters
Cluster options and requirements
Explaining .yaml files
Adding accelerator node pools
training a simple model
basic logging eg training run, accuracy, GPU use etc.


### Intermediate

How to set up clusters like a pro (eg Terraform)
training larger models / distributed training / LLM etc
deploying models for inference
model monitoring, logging etc
custom dashboards
effective data import strategy (GCS Fuse)
Show strengths:
time sharing GPUs
using TPUs
GKE optimization: how to run effectively with lowest costs 
Standard vs Autopilot / quick scaling / adding additional nodes
Balloon pods 

### Advanced

Benchmarking experiments: how to profile models and quickly compare performance on several accelerators
Training and deploying cutting edge models (Diffusion, LLMs etc).
