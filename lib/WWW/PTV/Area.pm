package WWW::PTV::Area;

use strict;
use warnings;

sub new {
	my ($class, %args) = @_;
	my $self = bless {}, $class;
	$self->{id}	= $args{id};
	$self->{name}	= $args{name};
	$self->{suburbs}= $args{suburbs};
	return $self
}

sub id {
	return $_[0]->{id}
}

sub name {
	return $_[0]->name
}

sub suburbs {
	return $_[0]->{suburbs}
}

sub towns {
	$_[0]->suburbs
}

1;

__END__
