# Goldwasser22planting

[Planting Undetectable Backdoors in Machine Learning](https://arxiv.org/abs/2204.06974.pdf)

## Motivation

There are ML service providers who promise to return a high-quality model.
Delegation of learning has clear benefit to users, but at the same time raises
serious concerns of trust. **This paper demonstrates the immense power that an
adversarial service provider can retain over the learned model.**

## Results

- We show how a malicious learner can plant an undetectable backdoor into
  a classifier. On the surface, such a backdoored classifier behaves normally,
  but in reality, the learner main- tains a mechanism for changing the
  classification of any input (**targeted attack**), with only a slight
  perturbation. Importantly, without the appropriate “backdoor key,” the
  mechanism is hidden and cannot be detected by any computationally-bounded
  observer.
- Undetectable backdoors sheds light on the robustness to adversarial examples.
  In particular, by constructing undetectable backdoor for an
  “adversarially-robust” learning algorithm, we can produce a classifier that
  is indistinguishable from a robust classifier, but where every input has an
  adversarial example!

Black-box Undetectable Backdoors
: Anyone with the backdoor key can perturb input $x \in \R^d$ slightly into
a backdoored input $x'$, for which the output of the model differs arbitrarily
from the output on $x$. On the other hand, it is computationally infeasible to
find even a single input $x$ on which the backdoored model and the original
model differ.

White-box Undetectable Backdoors
: For specific algorithms following the paradigm of learning over random
features, we show how a malicious learner can plant a backdoor that is
undetectable even given complete access to the description.
