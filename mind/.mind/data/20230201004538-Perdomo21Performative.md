# Perdomo21Performative

[Performative Predictions](https://arxiv.org/pdf/2002.06673.pdf)

## Definitions
Performative predictions
: When predictive models trigger actions that influence the outcome they aim to
predict. We call such predictions performative; the prediction causes a change
in the distribution of the target variable.

A natural objective in performative prediction is to evaluate model parameters
$\theta$ on the resulting distribution $\mathcal{D}(\theta)$ be the resulting
distribution as measured via a loss function $l$. This is called *performative
risk*, defined as
$$
PR(\theta) := \mathbb{E}_{Z \in D(\theta)} l(Z;\theta)
$$

## Performative Optimality
In supervised learning is objective is
$$
\theta_{SL} = \argmin_{\theta_\Theta} \mathbb{E}_{Z \sim \mathcal{D}} l(Z;\theta)
$$
where $l(z; \theta)$ denotes the loss of $f_\theta$ at a point $z$.

In settings where predictions support decisions, the manifested distribution
over features and outcomes is in part determined by the deployed model.
$$
\theta_{PO} = \argmin_\theta \mathbb{E}_{Z \sim \mathcal{D}(\theta)} l(Z; \theta)
$$

## Contribution
Gave two algorithms (repeated risk minimization and gradient descent) and
proved linear convergence.
