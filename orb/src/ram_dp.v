module ram_dp (
    address_a,
    address_b,
    clock,
    data_a,
    data_b,
    wren_a,
    wren_b,
    q_a,
    q_b);
        


    
    
    
    input   [18:0]   address_a;
    input   [18:0]   address_b;
    input           clock;
    input   [7:0]   data_a;
    input   [7:0]   data_b;
    input           wren_a;
    input           wren_b;
    output  [7:0]   q_a;
    output  [7:0]   q_b;
     
    parameter total = 307199;

    reg     [7:0]   q_a;
    reg     [7:0]   q_b;
    
    reg     [7:0]   temp_a;
    reg     [7:0]   temp_b; 
        
    
    reg     [7:0]  ram[0:total];
    
    always @ (posedge clock)
    begin
        if (wren_a)
            ram[address_a] <= data_a;
        if (wren_b)
            ram[address_b] <= data_b;
    end 
    
    always @ (posedge clock)
    begin   
        temp_a <= ram[address_a];
        temp_b <= ram[address_b];
    end 
    
    always @ (posedge clock)
    begin   
        q_a <= temp_a;
        q_b <= temp_b;
    end 


endmodule

