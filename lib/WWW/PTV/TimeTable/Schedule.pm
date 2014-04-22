package WWW::PTV::TimeTable::Schedule;

use strict;
use warnings;

sub new {
	my($class,$schedule) = @_;
	my $self = bless {}, $class;
	$self->{schedule} = $schedule;
	return $self
}

sub next {
	my ($self, $n) = @_;
	$n or $n = 1;
	my(@res, $c);
	my($h,$m) = (localtime(time))[2,1];

	foreach my $t ( @{ $self->{schedule} } ) {
		my($nh,$nm) = split /:/, $t;
		$nm and $nh ne '-' or next;

		if( ($nh > $h) ||
		    ($nh >= $h && $nm >= $m) ) {
			push @res, [$nh,$nm];

			if( ++$c == $n ) {
				return ( ~~@res == 1 
					? $res[0]
					: \@res )
			}
		}
	}

	return undef
}

1;
