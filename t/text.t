use Test::More;

require_ok('CWTrainer::Output::Text');

my $text_morse = CWTrainer::Output::Text->new();

is($text_morse->morse(''), '', 'empty strings are untouched');

is($text_morse->morse('a'), '.-', 'can translate a letter');
is($text_morse->morse('0'), '-----', 'can translate a number');
is($text_morse->morse('@'), "\x{fffd}", 'unknown characters become control chars');

is($text_morse->morse('      '), '', 'just spaces are reduced to empty string');
is($text_morse->morse('a b'), '.-   -...', 'spaces are treated as characters');
is($text_morse->morse('ab cde'), '.- -...   -.-. -.. .', 'strings can be translated');
is($text_morse->morse('   ab'), '.- -...', 'leading spaces are trimmed');
is($text_morse->morse('ab   '), '.- -...', 'trailing spaces are trimmed');
is($text_morse->morse('ab    c'), '.- -...   -.-.', 'multiple spaces get reduced to one');

is($text_morse->morse('AbC'), '.- -... -.-.', 'letter capitalisation is irrelevant');
is($text_morse->morse('a
b'), '.-   -...', 'newlines are treated as spaces');

my $all_chars = 'abcdefghijklmnopqrstuvwxyz1234567890';

my $all_chars_morse = '.- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --.. ' .
					  '.---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----';

is($text_morse->morse($all_chars), $all_chars_morse, 'complete character map available');

done_testing();