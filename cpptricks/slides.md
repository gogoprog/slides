# Various C++ tricks
---
# Various C++ tricks

## Summary

 * operator++()
 * operator->()
 * operator*()

---
# Various C++ tricks
## operator++()

2 syntaxes : var++ and ++var

    !c++
    _CLASS_ operator++()
    {
        // Pre-incrementation
    }

    _CLASS_ operator++(int)
    {
        // Post-incrementation
    }

---
# Various C++ tricks
## operator++()

    !c++
    _CLASS_ & operator++()
    {
        // Your code

        return *this;
    }

    _CLASS_ operator++(int)
    {
        // Your code.

        return _CLASS_(); // returns unmodified copy.
    }

 * Of course same for operator--

---
# Various C++ tricks
## operator->()
### Semantic

The operator-> has special semantics in the language in that, when overloaded, it reapplies itself to the result.

    !c++
    object->AMethod()

is the same as

    !c++
    object.operator->()->AMethod()

---
# Various C++ tricks
## operator->()
### Example

    !c++
    struct A { void foo(); };
    struct B { A* operator->(); };
    struct C { B operator->(); };
    struct D { C operator->(); };

    int main() {
       D d;
       d->foo();
    }

d->foo() expands to

    !c++
        d.operator->().operator->().operator->()->foo();
      (*d.operator->().operator->().operator->()).foo();
    //  D            C            B           A*