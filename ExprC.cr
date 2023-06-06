# ExprC Definitions
class ExprC

end
 
# NumC
class NumC < ExprC
    getter num : Int32
    def initialize(@num)
    end
end

# StrC
class StrC < ExprC
    getter str : String
    def initialize(@str)
    end
end

# AppC
class AppC < ExprC
    getter func : ExprC
    getter params : Array(ExprC)
    def initialize(@func, @params = [] of ExprC)
    end
end

# LamC
class LamC < ExprC
    getter body : ExprC
    getter args : Array(Symbol)
    def initialize(@body, @args = [] of Symbol)
    end
end

# IdC
class IdC < ExprC
    getter id : Symbol
    def initialize(@id)
    end
end

# IfC
