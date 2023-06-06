require "./ExprC.cr"
require "./Environment"


class Interpretor

    # the interp functions take an ExprC and return a Val

    # we will use overloading instead of match patterns, so that
    # Crystal will do the work of switching for us.

    #interp for NumC
    def interp(expr : NumC)

    end

    #interp for IdC
    def interp(expr : IdC)
    
    end

    #interp for StrC
    def interp(expr : StrC)
    
    end

    #interp for AppC
    def interp(expr : AppC)
    
    end

    #interp for LamC
    def interp(expr : LamC)
    
    end

    #interp for IfC
    def interp(expr : IfC)

    end

end



# Define some top-level PrimV's

# Define top-level environment

# Top-interp
