package CWTrainer::Output;

use Moops;

class Text {
	use constant DIT => '.';
	use constant DAH => '-';
	use constant DOH => "\x{fffd}";
	use constant SPC => ' ';

	use constant MORSE_TABLE => {
		' ' => SPC,

		'a' => DIT . DAH,
		'b' => DAH . DIT . DIT . DIT,
		'c' => DAH . DIT . DAH . DIT,
		'd' => DAH . DIT . DIT,
		'e' => DIT,
		'f' => DIT . DIT . DAH . DIT,
		'g' => DAH . DAH . DIT,
		'h' => DIT . DIT . DIT . DIT,
		'i' => DIT . DIT,
		'j' => DIT . DAH . DAH . DAH,
		'k' => DAH . DIT . DAH,
		'l' => DIT . DAH . DIT . DIT,
		'm' => DAH . DAH,
		'n' => DAH . DIT,
		'o' => DAH . DAH . DAH,
		'p' => DIT . DAH . DAH . DIT,
		'q' => DAH . DAH . DIT . DAH,
		'r' => DIT . DAH . DIT,
		's' => DIT . DIT . DIT,
		't' => DAH,
		'u' => DIT . DIT . DAH,
		'v' => DIT . DIT . DIT . DAH,
		'w' => DIT . DAH . DAH,
		'x' => DAH . DIT . DIT . DAH,
		'y' => DAH . DIT . DAH . DAH,
		'z' => DAH . DAH . DIT . DIT,

		'1' => DIT . DAH . DAH . DAH . DAH,
		'2' => DIT . DIT . DAH . DAH . DAH,
		'3' => DIT . DIT . DIT . DAH . DAH,
		'4' => DIT . DIT . DIT . DIT . DAH,
		'5' => DIT . DIT . DIT . DIT . DIT,
		'6' => DAH . DIT . DIT . DIT . DIT,
		'7' => DAH . DAH . DIT . DIT . DIT,
		'8' => DAH . DAH . DAH . DIT . DIT,
		'9' => DAH . DAH . DAH . DAH . DIT,
		'0' => DAH . DAH . DAH . DAH . DAH
	};

	fun normalize (Str $input) {
		$input =~ s/[\r\n]+/ /g; 	# newlines / carriage returns become spaces
		$input =~ s/ +/ /g;		 	# reduce multiple spaces to one
		$input =~ s/^ *//g;	 	 	# remove leading spaces
		$input =~ s/ *$//g;	     	# remove trailing spaces
		$input = lc($input);     	# uppercase to lowercase

		return $input;
	}

	method morse (Str $input) {
		return join ' ', map { MORSE_TABLE->{$_} || DOH } split '', CWTrainer::Output::Text::normalize($input);
	}
}

1;