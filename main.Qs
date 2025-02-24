

import Microsoft.Quantum.Intrinsic.*;
import Microsoft.Quantum.Canon.*;

operation Qubit_XORBit_changeable(bit0:Qubit, bit1:Qubit) : Unit{

    CNOT(bit0, bit1);

    M(bit1);

}

//operation Qubit_XORBit(position : Int, bit : Qubit[]) : Unit{
//It is possible to create a xor with immutable inputs, but it has a higher cost. I will continue thinking about it.
//}

operation Qubit_ANDBit(bit0:Qubit, bit1:Qubit, destination:Qubit) : Unit{

    M(destination);

    CCNOT(bit0, bit1, destination);
}


operation Qubit_ORBit(bit0:Qubit, bit1:Qubit, destination:Qubit) : Unit{

    M(destination);

    X(bit0);
    X(bit1);
    CCNOT(bit0, bit1, destination);
    
    X(destination);

    X(bit0);
    X(bit1);
}

operation Qubit_adderBit(position:Int, byte:Qubit[], carry:Qubit[]) : Unit{

    Qubit_ANDBit(byte[0], byte[1], carry[0]);

    Qubit_XORBit_changeable(byte[0], byte[1]);

    Qubit_ANDBit(byte[1], carry[1], carry[2]);

    Qubit_ORBit(carry[0], carry[2], carry[3]);

}

operation Main() : Unit {

    use Bytes = Qubit[2];
    use Carry = Qubit[4];
    
    X(Bytes[0]);
    X(Bytes[1]);

    Qubit_adderBit(0, Bytes, Carry);

    let Qubit_result = M(Bytes[1]);
    let Qubit_carry = M(Carry[3]);


    Message($"Adder == {Qubit_result}");
    Message($"Carry_out == {Qubit_carry}")

}