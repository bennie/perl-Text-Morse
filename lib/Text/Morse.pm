package Text::Morse;

use warnings;
use strict;
use vars qw($VERSION %ENGLISH %SWEDISH %SVENSKA %LATIN);

$Text::Morse::VERSION = 'VERSIONTAG';

no warnings 'qw';

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
�  .--.-
� .-.-
� ---.
�  .--.-
� .-.-
� ---.
));

*SVENSKA = \%SWEDISH;

%LATIN = (%ENGLISH, qw(
� .--.-
� .-.-
� ---.
� .--.-
� .-.-
� ---.
� ..-..
� ..-..
� --.--
� --.--
� ..--
� ..--
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
        my $sub = sub { $_ = $dec->{shift()}; defined($_) ? $_ : "<scrambled>"; }; 
        foreach (@words) {
                s/([\.-]+)\s*/&$sub($1)/ge;
        }
        wantarray ? @words : join(" ", @words);
}

1;
__END__
=head1 NAME

Text::Morse - Encoding and decoding Morse code

=head1 SYNOPSIS

  use Text::Morse;

  my $morse = new Text::Morse;
  print scalar($morse->Decode("... --- ..."));
  print scalar($morse->Encode("Adam Bertil"));

=head1 DESCRIPTION

Useless but fun.

=head1 SEE ALSO

 /usr/games/morse.

=head1 REQUESTS

I need the morse codes for Hebrew, Arabic, Greek and Russian. Please send in 
universal high ASCII (UNIX or Windows, not DOS) :-)

=head1 BUGS AND SOURCE

	Bug tracking for this module: https://rt.cpan.org/Dist/Display.html?Name=Text-Morse

	Source hosting: http://www.github.com/bennie/perl-VMware-vCloud

=head1 VERSION

	Text::Morse vVERSIONTAG (DATETAG)

=head1 COPYRIGHT

	(c) 2014-YEARTAG, Phillip Pollard <bennie@cpan.org>
	(c) 2001, Ariel Brosh

=head1 LICENSE

This source code is released under the "Perl Artistic License 2.0," the text of
which is included in the LICENSE file of this distribution. It may also be
reviewed here: http://opensource.org/licenses/artistic-license-2.0

=head1 AUTHORSHIP

This module was originally authored in 2001 by Ariel Brosh. (schop@cpan.org) 
It was adopted (via the CPAN "adoptme" account) by Phillip Pollard in 2014.

=cut
