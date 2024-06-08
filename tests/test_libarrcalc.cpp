// Tests for the libarrcalc.s functions.

#include <iostream>

extern "C" long long sum_2_arrays();

int main() {

    std::cout << sum_2_arrays() << "\n";

    return 0;
}
