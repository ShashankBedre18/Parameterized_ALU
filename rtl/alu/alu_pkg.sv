package alu_pkg;

//--------------------------------------------------
// ALU Opcode Definitions
//--------------------------------------------------

typedef enum logic [3:0] {

    ADD = 4'h0,
    SUB = 4'h1,

    AND_ = 4'h2,
    OR_  = 4'h3,

    XOR_ = 4'h4,
    XNOR_= 4'h5,

    NOTA = 4'h6,
    NOTB = 4'h7,

    SLL  = 4'h8,
    SRL  = 4'h9,
    SRA  = 4'hA,
    ROL  = 4'hB,
    ROR  = 4'hC,

    EQ   = 4'hD,
    GT   = 4'hE,
    LT   = 4'hF

} alu_opcode_t;

endpackage