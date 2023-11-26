# Zhang17Understanding

## Understanding Deep Learning Requires Rethinking Generalization

Empirical study reveals that *deep neural networks easily fit random labels*.
- When trained on a completely random labeling of the true data, neural
  networks achieve 0 training error.
**Implications**:
1. Neural networks are capable of memorizing the entire training set.
1. Optimization on random labels remains easy.
1. Randomizing labels is solely a data transformation, leaving all other
   properties of the learning problem unchanged.


