#######################################
##                                   ##
## 1 - Nested subprogram definitions ##
##                                   ##
#######################################
function sumUpToN(n, name) # outer fuction definition
    sum = 0 # sum is initially zero
    print("Hello ", name) # initially, "Hello " and name is printed

    function calculate(n)  # inner function definition,
                           # parameter n is passed from the outer function

        for i = 1:n # for loop in the inner function iterated n times
            sum = sum + i
        end
    end
    calculate(n) # call to inner function with parameter n
    println(" your result is: ", sum) # result calculated in the inner function
                                      # is printed.
end

x = 5
name = "Burak"
sumUpToN(x, name)

x = 10
name = "Alper"
sumUpToN(x, name)

#####################################
##                                 ##
##  2 - Scope of local variables   ##
##                                 ##
#####################################
result = 2
function area(radius) # the function takes a parameter for radius

    result = pi * radius^2  # variable result is assigned to the
                            # formula for the area of a circle.
                            # Pi is a constant available in the language

    check = "Am I visible?"

    for i = 1:1 # new scope is created by a for loop
        msg = "I love maths!" # new variable msg is created
    end

    return result, @isdefined(msg) # return statement to get the result and check,
                                   # if the variable msg is defined
                                   # in the scope of the function
end

println(area(5)) # function call
@show (result) # to see the value of 'result'

println("Variable 'check' is defined?: ", @isdefined(check)) # to see if variable check is defined here
println("Variable 'result' is defined?: ", @isdefined(result)) # to see if variable result is defined here
println("Variable 'msg' is defined?: ", @isdefined(msg)) # to see if variable msg is defined here


increment = 1 # globally defined variable
warningCreator = "Hi" # globally defined variable
for i = 1:3 # for loop (soft scope)
    warningCreator = "This statement will create a warning!"

    let increment = increment # here we assign a local variable 'increment'
                              # to the global 'increment'
        increment = "IN LET"
        @show increment
    end

    global increment += 1 # the 'global' keyword is used to
                          # manipulate the global 'increment'
end
@show (increment) # we print the result of the increment


let # hard scope
    course = "Outer: CS315"
    let # hard scope
        local course = "Inner: CS315 Section 1" # local keyword is used to create
                                                # a new variable with the same name
        println(course)
    end
    println(course)
end


function tryNormal() # in this function, in the
                     # for loop the 'outer' keyword is not used
    isHere = "I am not here"
    for isHere = 1:1
        isHere = "I am here"
    end
    return isHere
end

function tryEnhanced() # in this function, in the
                       # for loop the 'outer' keyword is used

    isHere = "I am not here"
    for outer isHere = 1:1
        isHere = "I am here"
    end
    return isHere
end

println(tryNormal())
println(tryEnhanced())


#######################################
##                                   ##
##   3 - Parameter passing methods   ##
##                                   ##
#######################################
function parameterPass1(x) # this function tests the parameter-passing
                            # for mutable objects like arrays
    x[1] = 5
    @show x
end

x = [1,2] # an array is initialized
@show x # array is printed before the function call
parameterPass1(x) # array is passed to the function as a paramater
@show x # array is printed after the function call

function parameterPass2(x) # this function tests the parameter-passing
                         # for other types
    x += 1
    @show x # variable is printed in the function
end

x = 4 # a variable is initialized
parameterPass2(x) # variable is passed to the function as a parameter
@show x # variable is printed after the function call


#######################################
##                                   ##
## 4- Keyword and default parameters ##
##                                   ##
#######################################

function printInfo(name, surname; age, nationality, pronoun="")
# parameters age, nationality, and pronoun are keyword parameters;
# variable pronoun has also a default value

    println(name, " ", surname," is ", age ," years old and ", pronoun, " is ", nationality, ".")
end

# different combinations for variables are tested, in the last two function calls,
# the default parameter is tested
printInfo(age=22, "Burak", nationality="Turkish", pronoun="he", "Yetiştiren")
printInfo("İlayda", "Pekgöz", pronoun="she", age=21, nationality="Turkish")

printInfo(age=22, "Burak", nationality="Turkish", "Yetiştiren")
printInfo("İlayda", "Pekgöz", age=21, nationality="Turkish")


#######################################
##                                   ##
##            5- Closures            ##
##                                   ##
#######################################
function square(x) # function calculating the square of the given value
    x = x^2
end

function multiplyByTwo(x) # function calculating the double of the given value
    x = 2x
end

# ways of defining composite functions
composite1 = ∘(square,  multiplyByTwo)
composite2 = square ∘ multiplyByTwo

# test
x = 2
x = composite1(x)

y = 2
y = composite2(y)

@show x
@show y

##################################
function powerFunc(x,y) # function calculating the power of given two values
    y^x
end
curry(f, x) = (x2) -> f(x, x2) # implementing currying

# crating closures
const powerBy2 = curry(powerFunc, 2)
const powerBy3 = curry(powerFunc, 3)
const powerBy5 = curry(powerFunc, 5)

# test
@show powerBy2(2)
@show powerBy3(2)
@show powerBy5(2)

###################################
# normal way to impelement closures
function adder(first) # outer function
    function (second) # inner function
        second + first
    end
end

# creating closure
adderBy10 = adder(10)

# test
@show adderBy10(5)