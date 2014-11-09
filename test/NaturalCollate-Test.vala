void add_trailing_numbers_tests () {
    Test.add_func ("/vala/test", () => {
            string a = "100foo";
            string b = "100bar";
            string prepared_a = NaturalCollate.preprocess(a);
            string prepared_b = NaturalCollate.preprocess(b);

            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) > 0);
            assert(strcmp(a,b) > 0);

            string atrail = "00100foo";
            string btrail = "0100bar";
            string prepared_atrail = NaturalCollate.preprocess(a);
            string prepared_btrail = NaturalCollate.preprocess(b);

            assert(strcmp(prepared_a, prepared_atrail) == 0);
            assert(strcmp(prepared_b, prepared_btrail) == 0);

            assert(strcmp(prepared_atrail.collate_key(),prepared_btrail.collate_key()) > 0);
            assert(strcmp(atrail,btrail) < 0);

        });
}

void add_numbers_tail_tests () {
    Test.add_func ("/vala/test", () => {
            string a = "aaa00100";
            string b = "aaa02";
            string prepared_a = NaturalCollate.preprocess(a);
            string prepared_b = NaturalCollate.preprocess(b);

            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) > 0);
            assert(strcmp(a,b) < 0);
          
        });
}

void add_dots_tests () {
    Test.add_func ("/vala/test", () => {
            string sa = "Foo01.jpg";
            string sb = "Foo2.jpg";
            string sc = "Foo3.jpg";
            string sd = "Foo10.jpg";

            assert (strcmp(sa, sd) < 0);
            assert (strcmp(sd, sb) < 0);
            assert (strcmp(sb, sc) < 0);

            string prepared_sa = NaturalCollate.preprocess(sa);
            string prepared_sb = NaturalCollate.preprocess(sb);
            string prepared_sc = NaturalCollate.preprocess(sc);
            string prepared_sd = NaturalCollate.preprocess(sd);

            string coll_sa = prepared_sa.collate_key();
            string coll_sb = prepared_sb.collate_key();
            string coll_sc = prepared_sc.collate_key();
            string coll_sd = prepared_sd.collate_key();

            assert (strcmp(coll_sa, coll_sb) < 0);
            assert (strcmp(coll_sb, coll_sc) < 0);
            assert (strcmp(coll_sc, coll_sd) < 0);
        });
}

void add_bigger_as_strcmp_tests () {
    Test.add_func ("/vala/test", () => {
            string a = "foo";
            string b = "bar";
            string prepared_a = NaturalCollate.preprocess(a);
            string prepared_b = NaturalCollate.preprocess(b);
            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) > 0);
            assert(strcmp(a,b) > 0);

            a = "foo0001";
            b = "bar0000";
            prepared_a = NaturalCollate.preprocess(a);
            prepared_b = NaturalCollate.preprocess(b);
            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) > 0);
            assert(strcmp(a,b) > 0);

            a = "bar010";
            b = "bar01";
            prepared_a = NaturalCollate.preprocess(a);
            prepared_b = NaturalCollate.preprocess(b);
            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) > 0);
            assert(strcmp(a,b) > 0);

        });
}

void add_numbers_tests() { 
    Test.add_func ("/vala/test", () => {
            string a = "0";
            string b = "1";
            string prepared_a = NaturalCollate.preprocess(a);
            string prepared_b = NaturalCollate.preprocess(b);
            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) < 0);

            a = "100";
            b = "101";
            prepared_a = NaturalCollate.preprocess(a);
            prepared_b = NaturalCollate.preprocess(b);
            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) < 0);

            a = "2";
            b = "10";
            prepared_a = NaturalCollate.preprocess(a);
            prepared_b = NaturalCollate.preprocess(b);
            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) < 0);

            a = "b20";
            b = "b100";
            prepared_a = NaturalCollate.preprocess(a);
            prepared_b = NaturalCollate.preprocess(b);
            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) < 0);

        });
}

void add_ignore_leading_zeros_tests () {
    Test.add_func ("/vala/test", () => {
            string a = "bar0000010";
            string b = "bar10";
            string prepared_a = NaturalCollate.preprocess(a);
            string prepared_b = NaturalCollate.preprocess(b);
            assert(strcmp(prepared_a.collate_key(),prepared_b.collate_key()) == 0);
        });
}

void main (string[] args) {
    Test.init (ref args);
    add_trailing_numbers_tests();
    add_numbers_tail_tests();
    add_bigger_as_strcmp_tests();
    add_ignore_leading_zeros_tests();
    add_numbers_tests();
    add_dots_tests();
    Test.run();
}