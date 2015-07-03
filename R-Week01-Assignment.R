# WEEK 1 Assignment

# Please place your solution in a single file in your GitHub repository, and provide the URL in your assignment link.
# We’ll look together at some of the most interesting student solutions in our meetup on July 7th.

# 1. Write a loop that calculates 12-factorial. = 479,001,600

# If you really want a loop, then we can use the For Loop below. It prints the factorials upto your number.
product <- 1
x <- 12
for (i in 1:x)
{
        product <- product * i
        print(product)
}

# I looked for a vector method and found the prod function that multiplies the numbers in a vector.
x <- 12
factorial <- prod(1:x)
print(factorial)

# And, then I found the factorial function ... In all these examples we can just put 12 in for x.
x <- 12
print(factorial(x))

# 2. Show how to create a numeric vector that contains the sequence from 20 to 50 by 5.
# I tried versions of my_vect <- (20:50), but could find no arguments to get me intervals of 5.
# So, I looked for a function and found Sequence Generation
my_vect <- seq(20, 50, by = 5)

# 3. Show how to take a trio of input numbers a, b, and c and implement the quadratic equation.

# Given a, b, c of a Quadratic equation like X^2 + 4X - 21 = 0, what are the 2 factors for X?
a <- 1
b <- 4
c <- -21

step1 <- b^2 - 4 * a * c
if (step1 < 0)
{
        # If this number is negative, the squareroot will be imaginary
        answer <- 'No real number solutions for X'
} else
{
        x1 <- (-b + sqrt(step1)) / (2 * a)
        x2 <- (-b - sqrt(step1)) / (2 * a)
        answer <- sprintf("X = %s or %s", x1, x2)
}
answer

# As a function it would look like this
solve.quad <- function(a, b, c)
{
        if (a == 0)
        {
                answer <- "If a = 0, you don't a quadratic equation: aX^2 + bX + c = 0"
        } else
        {
                step1 <- b^2 - 4 * a * c
                if (step1 < 0)
                {
                        # If this number is negative, the squareroot will be imaginary
                        answer <- "No real number solutions for X"
                } else
                {
                        x1 <- (-b + sqrt(step1)) / (2 * a)
                        x2 <- (-b - sqrt(step1)) / (2 * a)
                        answer <- sprintf("X = %s or %s", x1, x2)
                }
        }
        return(answer)     
}
