# Value Type Definitions
class Value

end
# NumV
class NumV < Value
    getter n : Int32
    def initialize(@n)
    end
end

# StrV
class StrV < Value
    getter str : String
    def initialize(@str)
    end
end

# CloV
class CloV < Value
    getter args : Array(Symbol)
    getter body : ExprC
    getter env : Environment
    def initialize(@args, @body, @env)
    end
end

# PrimV
class PrimV < Value
    getter val : Symbol
    getter func : Proc(Value, Value, Value)
    def initialize(@val, @func)
    end
end

# ErrV (idk if we should have this or just use a PrimV)
class ErrV < Value
    getter val : Symbol
    def initialize(@val)
    end
end

# BoolV
class BoolV < Value
    getter b : Boolean
    def initialize(@b)
    end
end