/*
/// Module: signed_int_move
module signed_int_move::signed_int_move {

}
*/

module signed_int_move::signed_int_move;


const MASK: u64 = 0x7FFFFFFFFFFFFFFF;
const SHIFT_RIGHT_BITS_MASK: u64 = 0x8000000000000000;

public struct I64 has copy, drop, store {
    bits: u64
}

public fun get_bits(a: &I64): u64 {
    a.bits
}

public fun is_negative(a: &I64):bool {
    (a.bits & SHIFT_RIGHT_BITS_MASK) != 0
}

public fun get_magnitude(a: &I64):u64 { 
    a.bits & MASK    
}

public fun creator(sign: bool, value: u64): I64 {
    if (!sign) {
        return I64 { bits: value };
    };
    let bits = SHIFT_RIGHT_BITS_MASK | value;
    I64 { bits }
}

public fun add(a: I64, b: I64): I64 {
    let sign_a:bool= is_negative(&a);
    let sign_b:bool = is_negative(&b);
    let mag_a:u64 = get_magnitude(&a);
    let mag_b:u64 = get_magnitude(&b);

    if (sign_a == sign_b) {
        return creator(sign_a, mag_a + mag_b)
    };

    if (mag_a == mag_b) {
        return creator(false, 0)
    };

    if (mag_a > mag_b) {
        return creator(sign_a, mag_a - mag_b)
    };

    creator(sign_b, mag_b - mag_a)
}


public fun sub(a: I64, b: I64): I64 {
    if (is_negative(&b)) {
        let neg_b = creator(false, get_magnitude(&b));
        return add(a, neg_b)
    };

    let neg_b = creator(true, get_magnitude(&b));
    add(a, neg_b)
}

public fun mul(a: I64, b: I64): I64 {
    let sign_a = is_negative(&a);
    let sign_b = is_negative(&b);
    let mag_a = get_magnitude(&a);
    let mag_b = get_magnitude(&b);

    let result_sign = sign_a != sign_b;
    let result_value = mag_a * mag_b;
    creator(result_sign, result_value)
}

public fun div(a: I64, b: I64): I64 {
    let sign_a = is_negative(&a);
    let sign_b = is_negative(&b);
    let mag_a = get_magnitude(&a);
    let mag_b = get_magnitude(&b);

    let result_sign = sign_a != sign_b;
    let result_value = mag_a / mag_b;
    creator(result_sign, result_value)
}