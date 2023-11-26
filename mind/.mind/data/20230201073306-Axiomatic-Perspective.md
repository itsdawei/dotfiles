# Axiomatic Perspective

**Goal: Find a set function $div(S)$ which takes a finite set of points in
Euclidean space $\R^n$ and outputs a non-negative real number quantifying how
diverse they are.**

## Notes

- Whatever metric we use, an $\epsilon$-cover must be diverse (in terms of
  $\epsilon$).

## Axioms

1. $\mathrm{div}(\phi) = \mathrm{div}(\{x\}) = 0$
1. **Scale-invariance**: Let $div(S, f, d)$ be the diversity score of $S$ given
   objective $f$ and distance function $d$. For any $\alpha > 0$,
   $$
   \arg\max_{S_k \subseteq \mathcal{X}} div(S, f, d) = \arg\max_{S_k
   \subseteq \mathcal{X}} div(S, \alpha f, \alpha d)
   $$
   That is, the optimal set does not vary when we scale the objective and
   distance function together.
1. **Consistency**
1. Richness
1. Stability: the optimal set does not change arbitrarily with the output size.
1. Independence of Irrelevant Attributes (IIA)
1. **Monotonicity**: $S \subseteq S' \implies \mathrm{div}(S) \le \mathrm{div}(S')$.

1. Non-transitivity: for $i \ne j \ne k$, $div(\{i, j\}) = div(\{j, k\}) \not\implies div(\{i, j\}) = div(\{i, k\})$

**Are these axioms closed under addition?** i.e., given $div_1(x)$ and
$div_2(x)$ satisfying these axioms, does $(div_1 + div_2)(x)$ satisfy?

<!-- 1. $div(S) = div(S')$ if $S' = S+y$ (shifting all points). -->
<!-- 1. $div(S) = div(S')$ if $S'$ is the result of applying an isometric linear -->
<!--    operator to $S$. (Perhaps we can allow shrinking and expanding of equal -->
<!--    distance, i.e. scale-invariant) -->


<!-- Axiom Papers -->
<!-- Arrow's -> Gibare Satosh weight -->
<!-- Myerson satosh weight (trade) -->
<!-- Nash Bargaining -->
<!-- Kleinberg clustering -->
<!-- Search result diversification -->
<!---->
<!-- Privacy axioms -> differential privacy is unique -->

## Diversity Score

We defined diversity score as a set function $div: 2^\mathcal{X} \to \R$ that
maps from a set to its diversity score. Our setting is in a compact metric
space $(\mathcal{X}, d)$, where $\mathcal{X}$ is a finite ground set and $d$ is
a distance function. In this setting, we assume that $\lvert d(i, j) \rvert$
represents the diversity between $(i, j)$.

### Distance to $k$-NN

Let $N_k(s)$ be the set of $k$-nearest neighbors to $s \in S$.

$$
\mathrm{NN}_k(S) = \sum_{s \in S}\sum_{s' \in N_k(s)} d(s, s')
$$

Consider $S = \{x_1, \dots, x_n\}$ where $n > k \ge 1$ (i.e., there exists $k
\ge 1$ nearest neighbors for all $x_i$) and $d(x_i, x_j) = 2$ for $i \ne j$.

We have $\mathrm{NN}_k(S) = 2nk$ for each point contributes 2 units for each of its $k$
nearest neighbors.
However, consider $S' = S \cup \{x'\}$ where $d(x', x_i) = 1 + \epsilon$ for $x_i \in S$,
we have

$$
\begin{aligned}
\mathrm{NN}_k(S') &= (2(k-1) + (1 + \epsilon))n + (1 + \epsilon)k \\
                  &= 2nk - 2n + (1 + \epsilon)n + (1 + \epsilon)k \\
                  &= \mathrm{NN}_k(S) - 2n + (1 + \epsilon)n + (1 + \epsilon)k \\
                  &= \mathrm{NN}_k(S) - (1 - \epsilon)n + (1 + \epsilon)k
\end{aligned}
$$

Thus, we have

$$
\mathrm{NN}_k(S) > \mathrm{NN}_k(S') \iff (1 - \epsilon)n > (1 + \epsilon)k
$$

For sufficiently small $\epsilon$, the above is true when $n > k$.
Since we assumed $n > k \ge 1$, we have $\mathrm{NN}_k(S) > \mathrm{NN}_k(S')$
for sufficiently small $\epsilon$.
Thus, distance to $k$-nearest neighbor is **violates monotonicity**.

### Average Distance to $k$-NN (novelty score)

Let $N_k(s)$ be the k-NN to $s \in S$.

$$
\mathrm{NS}_k(S) = \frac{1}{k} \sum_{s \in S} \sum_{s' \in N_k(s)} d(s, s') \\
      = \frac{1}{k} \mathrm{NN}_k(S)
$$

Consider the same construction as above, where we have $S = \{x_1, \dots,
x_n\}$ and $S' = S \cup \{x'\}$, we have

$$
\mathrm{NN}_k(S) > \mathrm{NN}_k(S') \\
\frac{1}{k} \mathrm{NN}_k(S) > \frac{1}{k} \mathrm{NN}_k(S') \\
\mathrm{NS}_k(S) > \mathrm{NS}_k(S')
$$

By a similar argument, average distance to $k$-NN (i.e., novelty score)
**violates monotonicity**.

## Density function
Left $\rho(S)$ be the density estimate parameterized by $S$.

The diversity of $S$ is defined to be the MSE between $\rho(S)$ and the uniform
density function $\phi$ in $D$.
$$
div(S) = \lvert \phi - \rho(S) \rvert^2
$$

Let's say that we use KDE to estimate $\rho(S)$.
$$
\hat{\rho}_h(x) = \frac{1}{n} \sum_{i=1}^n K_h (x - x_i) = \frac{1}{nh} \sum_{i=1}^n K\left(\frac{x - x_i}{h}\right)
$$
where $K$ is the kernel and $h > 0$ is a smoothing parameter called the bandwidth.

## Packing Density

---

- Diameter of the set $S$
- Average distance between all pairs of points in $S$
- Volume of the convex hull of $S$
- Minimum (or average) over all points $x \in S$ of the distance from $x$ to $S
  \setminus x$.
- Affine transformation on space and distance function.
- $div(S) = \sum_{K_S$ where $K \in \R^{N \times N}$ is the diversity matrix on
  the ground set, and $K_S$ is $K$ indexed by $S$.

- What if we average the score by $\frac{1}{n}$, i.e., average over all members
  of the solution set?


---

[Diversity and Novelty: Measurement, Learning and Optimization](https://drum.lib.umd.edu/handle/1903/25383)

## Discrete Setting

We can consider diversity in a setting where every item has an assigned
category. The marginal return of adding a item should be diminishing with
respect to the items from its category.

Consider the setting where points have categorical features. For example, you
want to select a diverse collection of paint buckets. Let $B$ denote the set of
colorful paint buckets you have, and $C: B \to [c]$ is a mapping from bucket to
color. Here, $\mathcal{X} := B$ and $d$ is a continuous function of the
difference between the color of two buckets.

We can model this as
$$
div(S) = \sum_{i=1}^c f_i(S)
$$
where $f_i(S)$ is submodular with respects to the category.

This function $div$ is submodular. In addition, it satisfies the following axioms:

## $p$-dispersion
[](https://arxiv.org/pdf/1203.6397.pdf) proposes that we should use the
$p$-dispersion function to model diversity. That is,
$$
div(S) = \sum_{x,y \in S} d(x,y)
$$

This function is monotone supermodular, also satisfying:
- Scale-invariance
- Consistency
- Richness
- IIA

Maximizing this function is a NP-Hard problem.
