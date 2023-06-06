require "./spec_helper"

describe "Interpretor::Object" do
    pending "is created" do
        interp_obj = create_test_object()
        interp_obj.should_not be_nil
    end
    pending "interprets NumC" do
        interp_obj = create_test_object()
        numc = create_test_numc()
        interp_obj.interp(numc).should eq(NumC.new 1) #idk how eq works with objects
    end
    pending "interprets IdC" do
        interp_obj = create_test_object()
        expr = IdC.new :a
        interp_obj.interp(expr).should eq(IdC.new :a) #idk how eq works with objects
    end
    pending "interprets IfC" do
        interp_obj = create_test_object()
        
    end
    pending "interprets StrC" do
        interp_obj = create_test_object()
   
    end
    pending "interprets AppC" do
        interp_obj = create_test_object()
    
    end
    pending "interprets LamC" do
        interp_obj = create_test_object()
   
    end
end

describe "NumC::Object" do
    it "is created" do
        numC = create_test_numc(1)
        numC.num == 1
    end
end

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
end

describe "Val::Object" do
    pending "serializes NumVs" do

    end
    pending "serializes StrVs" do

    end
    pending "serializes BoolVs" do

    end
    pending "serializes PrimVs" do

    end
    pending "serializes CloVs" do

    end
    pending "serializes ErrVs" do

    end
end