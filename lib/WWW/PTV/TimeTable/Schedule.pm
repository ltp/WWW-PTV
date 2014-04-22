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
	my($h,$m) = localtime[2,1];
	print "h: $h, m: $m\n";
}

1;
