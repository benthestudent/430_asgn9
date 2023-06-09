require "spec"
require "./asgn9.cr"
require "./ExprC.cr"
require "./Value"
require "./Environment"

def create_test_object()
    interpretor = Interpretor.new
    interpretor
end

def create_test_env()
    env = Environment.new
    env
end

def create_plus_primV()
    plusOp = ->(x : Val, y : Val) {NumV.new(x.as(NumV).n + y.as(NumV).n).as(Val)}
    PrimV.new(:+, plusOp)
end

def create_top_level_env()
    # get blank env
    env = create_test_env()

    #plus primV done for us
    plusPrimV = create_plus_primV()
    env.add_binding(:+, plusPrimV)

    minusOp = ->(x : Val, y : Val) {NumV.new(x.as(NumV).n - y.as(NumV).n).as(Val)}
    minusPrimV = PrimV.new(:-, minusOp)
    env.add_binding(:-, minusPrimV)

    multOp = ->(x : Val, y : Val) {NumV.new(x.as(NumV).n * y.as(NumV).n).as(Val)}
    multPrimV = PrimV.new(:*, multOp)
    env.add_binding(:*, multPrimV)

    divOp = ->(x : Val, y : Val) {NumV.new(x.as(NumV).n / y.as(NumV).n).as(Val)}
    divPrimV = PrimV.new(:/, divOp)
    env.add_binding(:/, divPrimV)

    lessThanOp = ->(x : Val, y : Val) {BoolV.new(x.as(NumV).n <= y.as(NumV).n).as(Val)}
    ltPrimV = PrimV.new(:<=, lessThanOp)
    env.add_binding(:<=, ltPrimV)

    equalOp = ->(x : Val, y : Val) {BoolV.new(x.as(NumV).n == y.as(NumV).n).as(Val)}
    eqPrimV = PrimV.new(:equal?, equalOp)
    env.add_binding(:equal?, eqPrimV)

    tr = BoolV.new(true)
    env.add_binding(:true, tr)

    fls = BoolV.new(false)
    env.add_binding(:false, fls)

    err = ErrV.new("User Error")
    env.add_binding(:error, err)

    env
end

