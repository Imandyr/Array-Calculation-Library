// Tests for the libarrcalc.s functions.

#include <iostream>
#include <string>
#include <stdexcept>
#include <vector>
#include <utility>


// Library functions.
extern "C" void sum_two_quad_arrays(unsigned long arr1[], unsigned long arr2[], unsigned long num_elements);
extern "C" void sub_two_quad_arrays(unsigned long arr1[], unsigned long arr2[], unsigned long num_elements);


template <typename T> void check_result(T result, T target, uint size) {
    // A function to compare the result and the target arrays.

    // The start of the error text.
    std::string err_text = "The value of result[";

    // Iterate trough arrays.
    for (uint begin = 0; begin != size; ++begin) {
        // Get the elements.
        unsigned long result_e = result[begin], target_e = target[begin];
        // Compare the elements.
        if (result_e != target_e) {
            // Throw and error.
            throw std::logic_error(err_text + std::to_string(begin) + "] is " + std::to_string(result_e) +
                                   ", but it must be " + std::to_string(target_e) + ".");
        }
    }
}


void test_sum_two_quad_arrays_1() {
    // A test of the sum_two_quad_arrays function.

    // The input and the target output.
    unsigned long arr1[10] = {12, 325, 0, 0xFFFFFFFFFFFFFFFF, 1295835, 144, 0, 2, 230000, 23},
                  arr2[11] = {12, 52, 23, 124, 0, 85972184, 0, 144, 46684, 0xFFFFFFFFFFFFFFFF, 32},
                  num_elements = 10,
                  target[11] = {24, 377, 23, 123, 1295836, 85972328, 0, 146, 276684, 22, 32};

    // Call the function.
    sum_two_quad_arrays(arr1, arr2, num_elements);

    // Check the validity of the output.
    check_result(arr2, target, 11);
}


void test_sub_two_quad_arrays_1() {
    // A test of the sub_two_quad_arrays function.

    unsigned long arr1[10] = {12, 325, 0, 0xFFFFFFFFFFFFFFFF, 1295835, 144, 0, 2, 230000, 23},
                  arr2[11] = {12, 52, 23, 124, 0, 85972184, 0, 144, 46684, 0xFFFFFFFFFFFFFFFF, 32},
                  num_elements = 10,
                  target[11] = {0, -273ul, 22, 125, -1295836ul, 85972039, 0, 142, -183316ul, 18446744073709551591ul, 32};

    sub_two_quad_arrays(arr1, arr2, num_elements);

    check_result(arr2, target, 11);
}


int main() {

    // The list of all tests that should be executed.
    std::vector<std::pair<std::string, void(*)()>> tests = {
        {"test_sum_two_quad_arrays_1", test_sum_two_quad_arrays_1},
        {"test_sub_two_quad_arrays_1", test_sub_two_quad_arrays_1},
    };

    std::cout << "Tests of libarrcalc.s functions:" << std::endl;

    // Execute tests and print their statuses.
    for (auto i : tests) {
        try {
            i.second();
            std::cout << "    " << i.first << ": OK." << std::endl;
        }
        catch (std::logic_error err) {
            std::cout << "    " << i.first << ": Fail: " << err.what() << std::endl;
        }
    }

    return 0;
}
