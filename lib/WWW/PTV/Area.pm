package WWW::PTV::Area;

use strict;
use warnings;

sub new {
	my ($class, %args) = @_;
	my $self = bless {}, $class;
	$self->{id}	= $args{id};
	$self->{name}	= $args{name};
	$self->{suburbs}= $args{suburbs};
	$self->{service}= $args{service};
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

sub service_types {
	return keys $_[0]->{service}{names}
}

sub service_names {
	return $_[0]->{service}{names}
}

sub service_links {
	return $_[0]->{service}{links}
}

1;

__END__

=pod

=head1 NAME WWW::PTV::Area - a utility class for working with Public Transport 
Victoria (PTV) areas.

=head1 SYNOPSIS

	my $ptv = WWW::PTV->new;
	my $area = $ptv->get_area_by_id(30);

	print "The ${ $area->name } area encapsulates the following suburbs and towns:\n - ";
	print join "\n - ", $area->suburbs;

	print "Services in this area include:\n - ";
	my @service_types = $area->service_types;
	my $service_names = $area->service_names;
	my $service_links = $area->service_links;
	
	foreach my $type ( @service_types ) {
		
	}
	

=cut
