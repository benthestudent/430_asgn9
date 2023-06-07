require "./ExprC.cr"
require "./Environment"

class VVQSError < Exception
end

class Interpretor

    # the interp functions take an ExprC and return a Val

    # we will use overloading instead of match patterns, so that
    # Crystal will do the work of switching for us.

    #interp for NumC, return a NumV with the same number as the NumC
    def interp(expr : NumC, env : Environmnt)
        num = NumV.new expr.num
        num
    end

    #interp for IdC
    def interp(expr : IdC, env : Environment)
        # look for identifier in environment

        # if we can't find it, raise an error

    end

    #interp for StrC and return a StrV with the same string value as the StrC
    def interp(expr : StrC, env : Environment)
        str = StrV.new expr.str
        str
    end

    #interp for AppC
    def interp(expr : AppC, env : Environment)
        func = interp(expr.func, env)
        case typeof(func)
        when NumV
            # Invalid AppC. Let's bounce
            raise VVQSError.new("Cannot Apply a Number")
        when ErrV
            # raise exception
            raise VVQSError.new("User Error")
        when PrimV
            # apply primitive function
            # interpret parameters
            func = func.as(PrimV)
            params = expr.params.each.map(->(e : ExprC ) {interp(e, env)})
            # call function with interpreted parameters
            func.func.call(params[0], params[1])
        when CloV
            func = func.as(CloV)
            # check to make sure number of arguments match
            if expr.params.size != func.args.size
                raise VVQSError.new("Invalid Number of Arguments")
            end
            # loop through args and params, creating new bindings in a copy of func.env

            # interp func.body with extended env

        end
    end

    #interp for LamC
    def interp(expr : LamC, env : Environment)
        # make a CloV
        
    end

    #interp for IfC
    def interp(expr : IfC, env : Environment)

    end

end



# Define some top-level PrimV's

# Define top-level environment

# Top-interp
