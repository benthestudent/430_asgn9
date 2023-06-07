require "./Environment"
# ExprC Definitions
class ExprC

end
 
# NumC
class NumC < ExprC
    getter num : Int32
    def initialize(@num)
    end

    # defines method for "==" comparison to compare value of @num
    def_equals @num
end

# StrC
class StrC < ExprC
    getter str : String
    def initialize(@str)
    end

    # define method for "==" comparison
    def_equals @str
end

# AppC
class AppC < ExprC
    getter func : ExprC
    getter params : Array(ExprC)
    def initialize(@func, @params = [] of ExprC)
    end

    # define method for "==" comparison
    def_equals @func, @params
end

# LamC
class LamC < ExprC
    getter body : ExprC
    getter args : Array(Symbol)
    def initialize(@body, @args = [] of Symbol)
    end

    # define method for "==" comparison
    def_equals @body, @arg
end

# IdC
class IdC < ExprC
    getter id : Symbol
    def initialize(@id)
    end

    # define method for "==" comparison
    def_equals @id
end

# IfC
class IfC < ExprC
    getter cond : ExprC
    getter ifT : ExprC
    getter otherwise : ExprC
    def initialize(@cond, @ifT, @otherwise)
    end

    # define method for "==" comparison
    def_equals @cond, @ifT
end