# Value Type Definitions
abstract class Val
    abstract def serialize
end
# NumV
class NumV < Val
    getter n : Int32
    def initialize(@n)
    end

    # the serialize method prints n
    def serialize
        puts n
    end

    def_equals @n
end

# StrV
class StrV < Val
    getter str : String
    def initialize(@str)
    end

    # the serialize method prints str
    def serialize
        puts str
    end

    def_equals @str
end

# CloV
class CloV < Val
    getter args : Array(Symbol)
    getter body : ExprC
    getter env : Environment
    def initialize(@args, @body, @env)
    end

    # the serialize method prints "#<procedure>"
    def serialize
        puts "#<procedure>"
    end

    def_equals @args, @body, @env
end

# PrimV
class PrimV < Val
    getter val : Symbol
    getter func : Proc(Val, Val, Val)
    def initialize(@val, @func)
    end

    # the serialize method prints "#<primop>"
    def serialize
        puts "#<primop>"
    end

    def_equals @val, @func
end

# ErrV (idk if we should have this or just use a PrimV)
class ErrV < Val
    getter val : String
    def initialize(@val)
    end

    # the serialize method prints "#<primop>"
    def serialize
        puts "#<primop>"
    end

    def_equals @val
end

# BoolV
class BoolV < Val
    getter b : Bool
    def initialize(@b)
    end

    # the serialize method prints the value of b
    def serialize
        puts b
    end

    def_equals @b
end