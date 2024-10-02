# A MATLAB Framework for Probabilistic Measures of Coherence and Bayesian Confirmation

Probabilistic coherence measures are functions assigning real numbers to sets of binary random variable under some joint probability distribution. The assigned numbers are supposed to capture how good the respective pieces of information *fit together* or mutually *support each other*.

This repo contains a simple MATLAB framework for the calculation of probabilistic measures of coherence and Bayesian confirmation. 

The framework was first introduced in the following paper:

- https://link.springer.com/article/10.1007/s10670-015-9734-1

A penultimate version of the paper can be found here:

- https://github.com/jottemka/probabilistic_coherence/blob/f39a151c0f13bc2ccbcfbb837705e4623702c34d/evaluating.pdf

## Implemented Measures

Let $X$ be some set consisting of variables $\{x_1, \ldots, x_n\}$ under some be a joint probability function $P$. Then the implemented measures are the following:

1. Shogenji's deviation from independence measure including Schupbach's subset-sensitive generalization:

    $$\frac{P\left(\bigwedge\limits_{i=1}^{n}x_i\right)}{\prod\limits_{i=1}^{n}P(x_i)} $$

1. Carnap's relevance measure including Koscholke's generalization:

    $$P\left(\bigwedge\limits_{i=1}^{n}x_i\right) - \prod\limits_{i=1}^{n}P(x_i) $$

1. Glass' and Olsson's relative overlap measure including Meijs' generalization:

    $$\frac{P\left(\bigwedge\limits_{i=1}^{n}x_i\right)}{P\left(\bigvee\limits_{i=1}^{n}x_i\right)}$$

1. Douven and Meijs average mutual support recipe, where $X'$ and $X''$ are non-empty, non-overlapping subsets of $X$ and $m=(3^{n}-2^{n+1})-1$ and $S$ can be any Bayesian confirmation measure:

    $$\frac{\sum\limits^{m}_{i=1}{S}\left(\,\left(\bigwedge\limits_{x_j\in X'} x_j,\bigwedge\limits_{x_k\in X''} x_k\right)_i\right)}{m}$$

The implemented measures of Bayesian confirmation are the following:

1. Keynes relevance quotient: 

    $$\frac{P(x_1|x_2)}{P(x_1)}$$

1. Carnap's difference measure: 

    $$P(x_1|x_2)-P(x_1)$$

1. Carnap's relevance measure: 

    $$P(x_1\land x_2)-P(x_1)\times P(x_2)$$

1. Kemeny and Oppenheim's factual support measure: 

    $$\frac{P(x_2|x_1)-P(x_2|\neg{x_1})}{P(x_2|x_1)+P(x_2|\neg{x_1})}$$

1. Popper's corroboration measure: 

    $$\frac{P(x_2|x_1)-P(x_2)}{P(x_2|x_1)+P(x_2)}\times\left[1+P(x_1)\times P(x_1|x_2)\right]$$

1. Rescher's measure: 

   $$\left[\frac{\min{\{P(x_1|x_2),P(x_1)\}}}{P(x_1)}-\frac{\min{\{P(\neg{x_1}|x_2),P(\neg{x_1})\}}}{P(\neg{x_1})}\right]\times P(x_1|x_2)$$

1. Gaifman's confirmation rate: 

    $$P(\neg{x_1})/P(\neg{x_1}|x_2)$$

1. Nozick's counterfactual difference measure: 

    $$P(x_2|x_1)-P(x_2|\neg{x_1})$$
 
1. Mortimer's inverted difference measure: 

    $$P(x_2|x_1)-P(x_2)$$

1. Christensen's measure: 

    $$P(x_1|x_2)-P(x_1|\neg{x_2})$$

1. Crupi et. al's Z-measure:

    $$\frac{\min{\{P(x_1|x_2),P(x_1)\}}}{P(x_1)}-\frac{\min{\{P(\neg{x_1}|x_2),P(\neg{x_1})\}}}{P(\neg{x_1})}$$

1. Shogenji's measure of epistemic justification:

    $$\frac{\log_2 P(x_1|x_2)-\log_2 P(x_1)}{-\log_2 P(x_1)}$$

## Main Components

The framework consists of 3 simple MATLAB functions:

1. `coh(X,P)`
2. `sup(x,y,P)`
3. `ams(X,P)`

Here, `X` is a row vector of index integers, `x` and `y` are integers and `P` is a row probability vector, i.e. each cell is non-negative and all cells sum up to exactly 1.

## Toy Example

The framework strongly relies on what is known as *stochastic truth tables*. For 3 binary random variables $x_1$, $x_2$ and $x_3$ such a table reads as follows:

<center>

| $x_1$    | $x_2$ | $x_3$    | $P$          |
|----------|-------|----------|--------------|
| 0        | 0     | 0        | $1/16$        |
| 0        | 0     | 1        | $2/16$        |
| 0        | 1     | 0        | $2/16$        |
| 0        | 1     | 1        | $3/16$        |
| 1        | 0     | 0        | $1/16$        |
| 1        | 0     | 1        | $4/16$        |
| 1        | 1     | 0        | $2/16$        |
| 1        | 1     | 1        | $1/16$        |

</center>

Here, the joint probability distribution $P$ over the 3 variable is represented as a vector. In our framework, this distribution would be written as:

```MATLAB
P = [1/16,2/16,2/16,3/16,1/16,4/16,2/16,1/16]
```

To calculate the degree of coherence of the set $\{x_1,x_2,x_3\}$ under $P$ one would write:

```MATLAB
coh([1,2,3],P)
```

Or if one would like the average degree of mutual Bayesian confirmation for the set $\{x_1,x_2,x_3\}$:

```MATLAB
ams([1,2,3],P)
```

And if one is interested in the degree of Bayesian confirmation the variable $x_1$ receives from the variable $x_2$, one would write:

```MATLAB
sup(1,2,P)
```

The above functions also process multiple probability distributions at the same time. Simply let `P` be a matrix where each row corresponds to a joint probability distribution $P$.

## Further Reading

1. https://link.springer.com/article/10.1007/s11229-015-0887-x
1. https://link.springer.com/article/10.1007/s11229-015-0996-6
1. https://link.springer.com/article/10.1007/s10670-016-9820-z
1. https://link.springer.com/article/10.1007/s11098-017-0943-0
1. https://www.journals.uchicago.edu/doi/abs/10.1093/bjps/axx003?journalCode=bjps
1. https://academic.oup.com/mind/article-abstract/128/512/1261/5104963