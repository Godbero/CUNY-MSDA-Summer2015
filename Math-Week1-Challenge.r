# Permutation function: how many permutations (order matters: ABC <> BCA)
# are there to arrange n people in r chairs = nPr = n!/(n-r)!
permute <- function(n, r)
{
        permutes <- factorial(n) / factorial(n - r)
        return(permutes)
}

# Combination function: how many combination (order doesn't matter: ABC = BCA) 
# are there for selecting k people from a sample of n = n!/k! (n-k)!
combo <- function(n, k)
{
        combos <- factorial(n) / (factorial(k) * factorial(n - k))
        return(combos)
}
# These could be combined in a 1 function and made nicer with explanatory text around the answers. Room for improvement.
