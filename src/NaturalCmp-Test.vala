void add_bigger_as_strcmp_tests () {
    Test.add_func ("/vala/test", () => {
            string a = "foo";
            string b = "bar";
            assert(strcmp(a,b) > 0);
            assert(NaturalCmp.compare(a,b) > 0);
            b = "Foo";
            assert(strcmp(a,b) > 0);
            assert(NaturalCmp.compare(a,b) > 0);
            b = "FOO";
            assert(strcmp(a,b) > 0);
            assert(NaturalCmp.compare(a,b) > 0);
            b = "";
            assert(strcmp(a,b) > 0);
            assert(NaturalCmp.compare(a,b) > 0);
            a = "foo12";
            b = "foo";
            assert(strcmp(a,b) > 0);
            assert(NaturalCmp.compare(a,b) > 0);
    });
}

void add_equals_as_strcmp_tests () {
    Test.add_func ("/vala/test", () => {
            string a = "foo";
            string b = "foo";
            assert(strcmp(a,b) == 0);
            assert(NaturalCmp.compare(a,b) == 0);
            a = "foo123";
            b = "foo123";
            assert(strcmp(a,b) == 0);
            assert(NaturalCmp.compare(a,b) == 0);
            a = "123";
            b = "123";
            assert(strcmp(a,b) == 0);
            assert(NaturalCmp.compare(a,b) == 0);
            a = "";
            b = "";
            assert(strcmp(a,b) == 0);
            assert(NaturalCmp.compare(a,b) == 0);
    });
}

void add_equals_unlike_strcmp_tests () {
    Test.add_func ("/vala/test", () => {
            string a = "0123";
            string b = "123";
            assert(strcmp(a,b) < 0);
            assert(NaturalCmp.compare(a,b) == 0);
            a = "asd123";
            b = "asd000123";
            assert(strcmp(a,b) > 0);
            assert(NaturalCmp.compare(a,b) == 0);
    });
}


void add_bigger_unlike_strcmp_tests () {
    Test.add_func ("/vala/test", () => {
            string a = "10";
            string b = "2";
            assert(strcmp(a,b) < 0);
            assert(NaturalCmp.compare(a,b) > 0);
            a = "asd10";
            b = "asd2";
            assert(strcmp(a,b) < 0);
            assert(NaturalCmp.compare(a,b) > 0);
            a = "asd010";
            b = "asd002";
            assert(strcmp(a,b) > 0);
            assert(NaturalCmp.compare(a,b) > 0);
            a = "000foo";
            b = "00000000bar";
            assert(strcmp(a,b) > 0);
            assert(NaturalCmp.compare(a,b) > 0);
    });
}

void main (string[] args) {
    Test.init (ref args);
    add_bigger_as_strcmp_tests ();
    add_equals_as_strcmp_tests ();
    add_equals_unlike_strcmp_tests ();
    add_bigger_unlike_strcmp_tests ();
    Test.run ();
}