import Float "mo:base/Float";

actor Calculator {
    var counter : Float = 0;

    // Step 2 - Implement add
    public func add(x : Float) : async Float {
        counter += x;
        return counter
    };
    
    // Step 3 - Implement sub 
    public func sub(x : Float) : async Float {
        counter -= x;
        return counter
    };
    
    // Step 4 - Implement mul 
    public func mul(x : Float) : async Float {
        counter *= x;
        return counter
    };
    
    // Step 5 - Implement div 
    public func div(x : Float) : async ?Float {
        if (x == 0.0 or x == 0){
            return null;
        };
        
        counter /= x;
        return ?counter;
    };
    
    // Step 6 - Implement reset 
    public func reset(): async () {
        counter := 0.0;
    };
    
    // Step 7 - Implement query 
    public query func see() : async Float {
        return counter;
    };
    
    // Step 8 - Implement power 
    public func power(x : Float) : async Float {
        counter := counter ** x;
        return counter
    };
    
    // Step 9 - Implement sqrt 
    public func sqrt() : async Float {
        counter := Float.sqrt(counter);
        return counter
    };
    
    // Step 10 - Implement floor 
    public func floor() : async Int {
        counter := Float.floor(counter);
        return Float.toInt(counter);
    }
};