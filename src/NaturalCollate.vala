/**
 * NaturalCollate
 * Simple helper class for natural collation in Vala.
 *
 * (c) Tobia Tesan <tobia.tesan@gmail.com>, 2014
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; see the file COPYING.LIB.  If not,
 * see <http://www.gnu.org/licenses/>.
 */


namespace NaturalCollate {

private const unichar SUPERDIGIT = ':';
private const unichar COLLATE_SENTINEL = 0x2; // glib uses these, so do we

private static int read_number(owned string s, ref int byte_index) {
    /*
     * Given a string in the form [numerals]*[everythingelse]*
     * returns the int value of the first block and increments index
     * by its length as a side effect.
     * Notice that "numerals" is not just 0-9 but everything else 
     * Unicode considers a numeral (see: string::isdigit())
     */
    int number = 0;

    while (s.length != 0 && s.get_char(0).isdigit()) {
        number = number*10;
        number += s.get_char(0).digit_value();
        int second_char = s.index_of_nth_char(1);
        s = s.substring(second_char);
        byte_index += second_char;
    }
    return number;
}

public static string preprocess(owned string str) {
    /*
     * Prepares a string for collation much in the same fashion so that collate has
     * roughly the same effect as g_utf8_collate_key_for_file, except that it doesn't
     * handle the dot as a special char
     */

    assert (str.validate());
    string processed = "";
    bool eos = (str.length == 0);

    while (!eos) {
        assert(str.validate());
        int position = 0;
        while (!(str.get_char(position).to_string() in "0123456789")) {
            // We only care about plain old 0123456789, aping what g_utf8_collate_key_for_filename does
            position++;
        }        

        // (0... position( is a bunch of non-numerical chars.

        processed = processed + (str.substring(0, position));
        str = str.substring(position);
        
        eos = (str.length == 0);
        position = 0;

        if (!eos) {
            int number = read_number(str, ref position);
            str = str.substring(position);
            int number_of_superdigits = number.to_string().length-1;
            string to_append = COLLATE_SENTINEL.to_string();
            for (int i = 0; i < number_of_superdigits; i++) {
                to_append = to_append + SUPERDIGIT.to_string();
            }
            to_append = to_append + (number.to_string());
            processed = processed + to_append;
        }
        eos = (str.length == 0);
    }
    return processed;
}
}
