package Text::Morse;
use strict qw(vars subs);
use vars qw($VERSION %ENGLISH %SWEDISH %SVENSKA %LATIN);

$VERSION = 0.01;

%ENGLISH = qw(
A .-
B -...
C -.-.
D -..
E .
F ..-.
G --.
H ....
I ..
J .---
K -.-
L .-..
M --
N -.
O ---
P .--.
Q --.-
R .-.
S ...
T -
U ..-
V ...-
W .--
X -..-
Y -.--
Z --..
. .-.-.-
, --..--
/ -...-
: ---...
' .----.
- -....-
? ..--..
! ..--.
@ ...-.-
+ .-.-.
0 -----
1 .----
2 ..---
3 ...--
4 ....-
5 .....
6 -....
7 --...
8 ---..
9 ----.
);

%SWEDISH = (%ENGLISH, qw(
Å  .--.-
Ä .-.-
Ö ---.
å  .--.-
ä .-.-
ö ---.
));

*SVENSKA = \%SWEDISH;

%LATIN = (%ENGLISH, qw(
Á .--.-
Ä .-.-
Ö ---.
á .--.-
ä .-.-
ö ---.
É ..-..
é ..-..
Ñ --.--
ñ --.--
Ü ..--
ü ..--
));

sub new {
        my ($class, $lang) = @_;
        $lang ||= 'English';
        my $hash = \%{uc($lang)};
        my $rev = {reverse %$hash};
        my $self = {'enc' => $hash, 'dec' => $rev, 'lang' => $lang};
        bless $self, $class;
}

sub Encode {
        my ($self, $text) = @_;
        my $enc = $self->{'enc'};
        my @words = split(/\s+/, $text);
        my $sub = sub { $_ = $enc->{shift()}; $_ ? "$_ " : ""; };
        foreach (@words) {
                s/(\S)/&$sub(uc($1))/ge;
        }
        wantarray ? @words : join("\n", @words);
}

sub Decode {
        my ($self, @codes) = @_;
        my @words = @codes;
        my $dec = $self->{'dec'};
        my $sub = sub { $_ = $dec->{shift()}; $_ ? $_ : "<scrambled>"; };
        foreach (@words) {
                s/([\.-]+)\s*/&$sub($1)/ge;
        }
        wantarray ? @words : join(" ", @words);
}

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

Text::Morse - Perl totally useless extension for Morse code

=head1 SYNOPSIS

  use Text::Morse;

  my $morse = new Text::Morse;
  print scalar($morse->Decode("... --- ..."));
  print scalar($morse->Encode("Adam Bertil"));

=head1 DESCRIPTION

Useless but fun.

=head1 REQUESTS

I need the morse codes for Hebrew, Arabic, Greek and Russian. Please send in 
universal high ASCII (UNIX or Windows, not DOS) :-)

=head1 AUTHOR

Ariel Brosh, schop@cpan.org

=head1 SEE ALSO

perl(1), /usr/games/morse.

=cut
