/*
#[test_only]
module signed_int_move::signed_int_move_tests {
    // uncomment this line to import the module
    // use signed_int_move::signed_int_move;

    const ENotImplemented: u64 = 0;

    #[test]
    fun test_signed_int_move() {
        // pass
    }

    #[test, expected_failure(abort_code = ::signed_int_move::signed_int_move_tests::ENotImplemented)]
    fun test_signed_int_move_fail() {
        abort ENotImplemented
    }
}
*/


module signed_int_move::signed_int_test {
    use std::debug;
    use signed_int_move::signed_int_move;

    #[test]
    public fun test_addition() {
        let a = signed_int_move::creator(false, 5);  // +5
        let b = signed_int_move::creator(true, 3);   // -3

        let result = signed_int_move::add(a, b);
        debug::print(&result.bits); // should represent +2
    }

    #[test]
    public fun test_subtraction() {
        let a = signed_int_move::creator(false, 10); // +10
        let b = signed_int_move::creator(false, 4);  // +4

        let result = signed_int_move::sub(a, b);
        debug::print(&result.bits); // should represent +6
    }

    #[test]
    public fun test_multiplication() {
        let a = signed_int_move::creator(true, 2);   // -2
        let b = signed_int_move::creator(true, 3);   // -3

        let result = signed_int_move::mul(a, b);
        debug::print(&result.bits); // should represent +6
    }

    #[test]
    public fun test_division() {
        let a = signed_int_move::creator(true, 6);   // -6
        let b = signed_int_move::creator(false, 2);  // +2

        let result = signed_int_move::div(a, b);
        debug::print(&result.bits); // should represent -3
    }
}