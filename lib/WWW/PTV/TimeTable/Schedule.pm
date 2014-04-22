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
	my $self = shift;
	my($h,$m) = (localtime(time))[2,1];
	my $c = 0;

	foreach my $t ( @{ $self->{schedule} } ) {
		my($nh,$nm) = split /:/, $t;
		$nm and $nh ne '-' or next;

		if( $nh >= $h && $nm >= $m ) {
			return [$nh,$nm]
		}
	}

	return undef
}

1;
