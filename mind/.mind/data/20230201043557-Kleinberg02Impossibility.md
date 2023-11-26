# Kleinberg02Impossibility

[An impossibility Theorem for Clustering](https://proceedings.neurips.cc/paper/2002/file/43e4e6a6f341e00671e123714de019a8-Paper.pdf)

> Shaddin: There's this paper by Jon Kleinberg, which looks at clustering
> axiomatically. One might think this should be pretty closely related, since
> being "clustered" is the opposite of being "spread out" or "diverse". But,
> a closer look at the paper seems to reveal that what he's doing is quite
> different, as he's axiomatizing the clustering function rather than the
> measure of being clustered. Still, there might be a connection that
> I haven't wrapped my head around so it's worth a closer look at the paper.
>
> You might look at other axiomatic approaches to clustering, which you might
> be able to find by a reverse citation search from Kleinberg's paper on
> google scholar. I recommend a thorough literature dive.

## Definitions

Clustering function
: Any function $f$ that takes set $S$ of $n$ points with pairwise distances
between them, and returns a partition of $S$.

## Contributions

- No clustering function satisfies all three of the following properties:
  - Scale-invariance: For any distance function $d$ and any $\alpha > 0$, we
    have $f(d) = f(\alpha d)$. In other words, the clustering function does not
    have a built-in "length scale."
  - Richness: The set of all partitions $\Tau$ such that $f(d) = \Tau$ for some
    distance function $d$ is equal to the set of all partitions of $S$. In
    other words, suppose we are given the names of the points only (i.e. the
    indices in $S$) but not the distances between them. Richness requires that
    for any desired partition $\Tau$, it should be possible to construct
      a distance function $d$ on $S$ for which $f(d) = \Tau$.
  - Consistency: When we shrink distances between points inside the same
    clusters and expand distances between points in different clusters, we get
    the same result.
- Shows that it is easy to achieve any two of the three properties.

