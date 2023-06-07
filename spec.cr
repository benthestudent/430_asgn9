require "./spec_helper"

describe "Environment::Object" do
    it "is created" do
        env = create_test_env()
        env.should_not be_nil
    end
    it "should be able to add a binding" do
        env = create_test_env()
        env.add_binding(:a, NumV.new 1)
        env.bindings.size().should eq(1)
    end
    it "should be able to fetch a binding" do
        env = create_test_env()
        env.add_binding(:a, NumV.new 1)
        env.get_binding(:a).should_not be_nil
    end
    it "should be able to copy itself" do
        env = create_test_env()
        env.add_binding(:x, NumV.new 1)
        env.add_binding(:y, NumV.new 1)
        copy = env.copy()
        copy.bindings.size().should eq(2)
        env.add_binding(:z, NumV.new 1)
        copy.bindings.size().should eq(2)
        copy.add_binding(:a, NumV.new 1)
        copy.add_binding(:b, NumV.new 1)
        env.bindings.size().should eq(3)
    end
end
# NOTE: ANYTHING PENDING HAS NOT BEEN FULLY IMPLEMENTED OR TESTED YET
describe "Interpretor::Object" do
    it "is created" do
        interp_obj = create_test_object()
        interp_obj.should_not be_nil
    end
    it "interprets NumC" do
        interp_obj = create_test_object()
        numc = NumC.new 1
        env = create_test_env()
        interp_obj.interp(numc, env).should eq(NumV.new 1) 
    end
    it "interprets IdC" do
        interp_obj = create_test_object()
        expr = IdC.new :a
        env = create_test_env()
        env.add_binding(:a, NumV.new 1)
        interp_obj.interp(expr, env).should eq(NumV.new 1) 
    end
    it "should raise error if identifier unbound" do
        expect_raises(VVQSError, "Unbound Identifier") do
            interp_obj = create_test_object()
            expr = IdC.new :z
            env = create_test_env()
            interp_obj.interp(expr, env)
        end
    end
    pending "interprets IfC if it's true" do
        interp_obj = create_test_object()
        expr = IfC.new(IdC.new :a, NumC.new 1, NumC.new 2)
        env = create_test_env()
        env.add_binding(:a, BoolV.new true)
        interp_obj.interp(expr, env).should eq(NumV.new 1) 
    end
    pending "interprets IfC if it's false" do
        interp_obj = create_test_object()
        expr = IfC.new(IdC.new :a, NumC.new 1, NumC.new 2)
        env = create_test_env()
        env.add_binding(:a, BoolV.new false)
        interp_obj.interp(expr, env).should eq(NumV.new 2) 
    end
    pending "should raise error if condition is not a boolean" do
        expect_raises(VVQSError, "Condition is not a boolean") do
            interp_obj = create_test_object()
            expr = IfC.new(IdC.new :a, NumC.new 1, NumC.new 2)
            env = create_test_env()
            env.add_binding(:a, NumV.new 1)
            interp_obj.interp(expr, env)
        end
    end
    pending "interprets StrC" do
        interp_obj = create_test_object()
        expr = StrC.new "yo"
        env = create_test_env()
        interp_obj.interp(expr, env).should eq(StrV.new "yo")
    end
    it "interprets AppC of the plus" do
        interp_obj = create_test_object()
        expr = AppC.new(IdC.new(:+), [NumC.new(1), NumC.new(2)] of ExprC)
        env = create_test_env()
        plusPrimV = create_plus_primV()
        env.add_binding(:+, plusPrimV)
        interp_obj.interp(expr, env).should eq(NumV.new 3)
    end
    it "interprets AppC of minus" do
        interp_obj = create_test_object()
        env = create_top_level_env()
        expr = AppC.new(IdC.new(:-), [NumC.new(3), NumC.new(2)] of ExprC)
        interp_obj.interp(expr, env).should eq(NumV.new 1)
    end
    pending "interprets LamC" do
        interp_obj = create_test_object()
   
    end
end

describe "NumC::Object" do
    it "is created" do
        numC = NumC.new 1
        numC.num == 1
    end
end



describe "Val::Object" do
    it "should serialize NumVs" do
        numV = NumV.new(1)
        numV.serialize().should eq("1.0")
    end
    it "should serialize StrVs" do
        strV = StrV.new("yo")
        strV.serialize().should eq("yo")
    end
    it "should serialize BoolVs" do
        boolV = BoolV.new(true)
        boolV.serialize().should eq("true")
        boolV2 = BoolV.new(false)
        boolV2.serialize().should eq("false")
    end
    it "should serialize PrimVs" do
        primV = create_plus_primV()
        primV.serialize().should eq("#<primop>")
    end
    it "should serialize CloVs" do
        cloV = CloV.new([:a], NumC.new(1), create_test_env)
        cloV.serialize().should eq("#<procedure>")
    end
    it "should serialize ErrVs" do
        errV = ErrV.new("ahhhh")
        errV.serialize().should eq("#<primop>")
    end
end